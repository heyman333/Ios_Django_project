from django.shortcuts import render

# Create your views here.
from rest_framework import renderers
from rest_framework import viewsets
from rest_framework.decorators import detail_route

from testapp.models import Test
from testapp.serializers import TestSerializer


class TestViewSet(viewsets.ModelViewSet):
    """
    이 뷰셋은 `list`와 `create`, `retrieve`, `update`, 'destroy` 기능을 자동으로 지원합니다

    여기에 `highlight` 기능의 코드만 추가로 작성했습니다
    """
    queryset = Test.objects.all()
    serializer_class = TestSerializer