from rest_framework import permissions
from rest_framework import viewsets
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.reverse import reverse

from testapp.models import Test, Person
from testapp.permission import IsOwnerOrReadOnly
from testapp.serializers import TestSerializer, PersonSerializer


class TestViewSet(viewsets.ModelViewSet):

    queryset = Test.objects.all()
    serializer_class = TestSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly,)

    def perform_create(self, serializer):
            serializer.save(owner=self.request.user)

class PersonViewSet(viewsets.ModelViewSet):

    queryset = Person.objects.all()
    serializer_class = PersonSerializer
    permission_classes = (permissions.IsAuthenticatedOrReadOnly,
                          IsOwnerOrReadOnly,)

    def perform_create(self, serializer):
            serializer.save(owner=self.request.user)

@api_view(('GET',))
def api_root(request, format=None):
    return Response({
        'users': reverse('user-list', request=request, format=format),
        'Test': reverse('Test-list', request=request, format=format),
        'Person': reverse('Person-list', request=request, format=format)
    })