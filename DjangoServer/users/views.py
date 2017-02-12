from django.contrib.auth import get_user_model
from django.contrib.auth.models import User
from rest_framework import permissions

from rest_framework import viewsets
from rest_framework.generics import CreateAPIView
from rest_framework.permissions import AllowAny

from users.models import Profile
from users.permission import IsOwnerOrReadOnly
from users.serializers import UserSerializer, UserCreateSerializer, ProfileSerializer


class UserViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class UserCreateAPIView(CreateAPIView):
    model = get_user_model()
    serializer_class = UserCreateSerializer
    permission_classes = (AllowAny,)

class ProfileViewSet(viewsets.ModelViewSet):

    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly,)

    def perform_create(self, serializer):
            serializer.save(owner=self.request.user)