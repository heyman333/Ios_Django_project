from django.contrib import admin
from users.models import Profile, Image


class ProfileAdmin(admin.ModelAdmin):
    list_display = ('owner', 'id', 'name', 'myself')

class ImageAdmin(admin.ModelAdmin):
    list_display = ('owner', 'id', 'image')

admin.site.register(Profile, ProfileAdmin)
admin.site.register(Image, ImageAdmin)