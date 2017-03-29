from rest_framework import permissions
from rest_framework import viewsets
from rest_framework.generics import CreateAPIView
from rest_framework.permissions import AllowAny

from board.models import Board, Comment
from board.permission import IsOwnerOrReadOnly
from board.serializers import BoardSerializer, CommentSerializer

class WriteAPIView(CreateAPIView):

    model = Board
    serializer_class = BoardSerializer
    permission_classes = (permissions.IsAuthenticated, IsOwnerOrReadOnly,)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

class WebViewSet(viewsets.ModelViewSet):

    queryset = Board.objects.filter(category='웹')
    serializer_class = BoardSerializer
    permission_classes = (permissions.IsAuthenticated, IsOwnerOrReadOnly,)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

class MobileViewSet(viewsets.ModelViewSet):

    queryset = Board.objects.filter(category='모바일')
    serializer_class = BoardSerializer
    permission_classes = (permissions.IsAuthenticated, IsOwnerOrReadOnly,)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

class BigDataViewSet(viewsets.ModelViewSet):

    queryset = Board.objects.filter(category='빅데이터')
    serializer_class = BoardSerializer
    permission_classes = (permissions.IsAuthenticated, IsOwnerOrReadOnly,)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

class DesignViewSet(viewsets.ModelViewSet):

    queryset = Board.objects.filter(category='디자인')
    serializer_class = BoardSerializer
    permission_classes = (permissions.IsAuthenticated, IsOwnerOrReadOnly,)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

class ETCViewSet(viewsets.ModelViewSet):

    queryset = Board.objects.filter(category='기타')
    serializer_class = BoardSerializer
    permission_classes = (permissions.IsAuthenticated, IsOwnerOrReadOnly,)

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)

class CommentViewSet(viewsets.ModelViewSet):

    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
    permission_classes = [AllowAny]

    def perform_create(self, serializer):
        serializer.save(owner=self.request.user)