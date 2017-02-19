from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from rest_framework.routers import DefaultRouter

from board.views import BoardViewSet, CommentViewset
from users.views import UserViewSet, ProfileViewSet

router = DefaultRouter()
router.register(r'users_List', UserViewSet)
router.register(r'users_Profile', ProfileViewSet)
router.register(r'board_Board', BoardViewSet)
router.register(r'board_Comment', CommentViewset)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^board/', include('board.urls')),
    url(r'^users/', include('users.urls')),

]+static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
