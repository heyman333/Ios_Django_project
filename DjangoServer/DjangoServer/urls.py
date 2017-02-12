from django.conf.urls import include, url
from django.contrib import admin

import users

urlpatterns = [

    url(r'^admin/', include(admin.site.urls)),
    # testapp url
    url(r'^testapp/', include('testapp.urls')),
    # users url
    url(r'^users/', include('users.urls'))

]
