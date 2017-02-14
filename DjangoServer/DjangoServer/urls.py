from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin
from rest_framework.routers import DefaultRouter

from testapp.views import TestViewSet, PersonViewSet
from users.views import UserViewSet, ProfileViewSet

router = DefaultRouter()
router.register(r'users_List', UserViewSet)
router.register(r'users_Profile', ProfileViewSet)
router.register(r'testapp_Test', TestViewSet)
router.register(r'testapp_Person', PersonViewSet)

urlpatterns = [
    url(r'^', include(router.urls)),
    url(r'^admin/', include(admin.site.urls)),
    # testapp url
    url(r'^testapp/', include('testapp.urls')),
    # users url
    url(r'^users/', include('users.urls')),

]+static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
