from django.conf.urls import url, include
from rest_framework.routers import DefaultRouter
from rest_framework_jwt.views import obtain_jwt_token, refresh_jwt_token

from users import views
from users.views import UserCreateAPIView

router = DefaultRouter()
router.register(r'list', views.UserViewSet)
router.register(r'profiles', views.ProfileViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    url(r'^register/', UserCreateAPIView.as_view(), name='register'),
    url(r'^auth/token/', obtain_jwt_token),
    url(r'^api-token-refresh/', refresh_jwt_token),
]
