from django.conf.urls import url, include
from rest_framework.routers import DefaultRouter

from board import views
from board.views import WriteAPIView

router = DefaultRouter()
router.register(r'web', views.WebViewSet)
router.register(r'mobile', views.MobileViewSet)
router.register(r'bigdata', views.BigDataViewSet)
router.register(r'design', views.DesignViewSet)
router.register(r'etc', views.ETCViewSet)
router.register(r'comments', views.CommentViewset)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^write/', WriteAPIView.as_view(), name='register'),
]