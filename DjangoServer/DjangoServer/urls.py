from django.conf import settings
from django.conf.urls import include, url
from django.conf.urls.static import static
from django.contrib import admin

urlpatterns = [

    url(r'^admin/', include(admin.site.urls)),
    # testapp url
    url(r'^testapp/', include('testapp.urls')),
    # users url
    url(r'^users/', include('users.urls'))

]+static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
