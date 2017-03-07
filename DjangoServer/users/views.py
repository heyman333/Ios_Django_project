# -*- coding: utf-8 -*-

from django.contrib.auth import get_user_model
from django.contrib.auth.models import User
from rest_framework import permissions

from rest_framework import viewsets
from rest_framework.generics import CreateAPIView
from rest_framework.parsers import FormParser, MultiPartParser
from rest_framework.permissions import AllowAny

from users.models import Profile, Image
from users.permission import IsOwnerOrReadOnly
from users.serializers import UserSerializer, UserCreateSerializer, ProfileSerializer, ImageSerializer


class UserViewSet(viewsets.ReadOnlyModelViewSet):
    permission_classes = [AllowAny]
    queryset = User.objects.all()
    serializer_class = UserSerializer

class UserCreateAPIView(CreateAPIView):
    model = get_user_model()
    serializer_class = UserCreateSerializer
    permission_classes = [AllowAny]

class ProfileViewSet(viewsets.ModelViewSet):

    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
    permission_classes = (permissions.IsAuthenticated, IsOwnerOrReadOnly,)

    def perform_create(self, serializer):
            serializer.save(owner=self.request.user)

class ImageViewSet(viewsets.ModelViewSet):

    queryset = Image.objects.all()
    serializer_class = ImageSerializer
    permission_classes = (permissions.IsAuthenticated, IsOwnerOrReadOnly,)
    parser_classes = (MultiPartParser, FormParser,)

    def perform_create(self, serializer):
            serializer.save(owner=self.request.user)