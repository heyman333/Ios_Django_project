from django.contrib.auth import get_user_model
from django.contrib.auth.models import User

from rest_framework import viewsets
from rest_framework.generics import CreateAPIView
from rest_framework.permissions import AllowAny

from users.serializers import UserSerializer, UserCreateSerializer


class UserViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

class UserCreateAPIView(CreateAPIView):
    model = get_user_model()
    serializer_class = UserCreateSerializer
    permission_classes = (AllowAny,)