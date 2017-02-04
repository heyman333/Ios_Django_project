from django.shortcuts import render

# Create your views here.
from rest_framework import renderers
from rest_framework import viewsets
from rest_framework.decorators import detail_route

from testapp.models import Test
from testapp.serializers import TestSerializer


class TestViewSet(viewsets.ModelViewSet):

    queryset = Test.objects.all()
    serializer_class = TestSerializer