from django.conf.urls import url, include
from rest_framework.routers import DefaultRouter

from testapp import views

router = DefaultRouter()
router.register(r'testapp', views.TestViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
]