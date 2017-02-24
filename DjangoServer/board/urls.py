from django.conf.urls import url, include
from rest_framework.routers import DefaultRouter

from board import views

router = DefaultRouter()
router.register(r'list', views.BoardViewSet)
router.register(r'comments', views.CommentViewset)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
]