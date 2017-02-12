from django.conf.urls import url, include
from rest_framework.routers import DefaultRouter

from users import views
from users.views import UserCreateAPIView

router = DefaultRouter()
router.register(r'list', views.UserViewSet)
router.register(r'profile', views.ProfileViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^register/', UserCreateAPIView.as_view(), name='register'),
]