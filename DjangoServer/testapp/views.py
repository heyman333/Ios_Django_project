from django.contrib.auth.models import User
from django.shortcuts import render

# Create your views here.
from rest_framework import permissions
from rest_framework import renderers
from rest_framework import viewsets
from rest_framework.decorators import detail_route, api_view
from rest_framework.response import Response
from rest_framework.reverse import reverse

from testapp.models import Test
from testapp.permisiion import IsOwnerOrReadOnly
from testapp.serializers import TestSerializer, UserSerializer


class TestViewSet(viewsets.ModelViewSet):

    queryset = Test.objects.all()
    serializer_class = TestSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly,)

    def perform_create(self, serializer):
            serializer.save(owner=self.request.user)

class UserViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

@api_view(('GET',))
def api_root(request, format=None):
    return Response({
        'users': reverse('user-list', request=request, format=format),
        'testapp': reverse('testapp-list', request=request, format=format)
    })