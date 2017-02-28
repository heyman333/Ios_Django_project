from django.conf.urls import url, include
from rest_framework.routers import DefaultRouter

from board import views
from board.views import WriteAPIView

router = DefaultRouter()
router.register(r'web', views.WebViewSet, base_name='web')
router.register(r'mobile', views.MobileViewSet, base_name='mobile')
router.register(r'bigdata', views.BigDataViewSet, base_name='bigdata')
router.register(r'design', views.DesignViewSet, base_name='design')
router.register(r'etc', views.ETCViewSet)
router.register(r'comments', views.CommentViewset)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^write/', WriteAPIView.as_view(), name='write'),
]