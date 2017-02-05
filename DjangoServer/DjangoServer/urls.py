from django.conf.urls import include, url
from django.contrib import admin

urlpatterns = [

    url(r'^admin/', include(admin.site.urls)),
    # testapp url
    url(r'^', include('testapp.urls')),
]
