from django.contrib import admin
from users.models import Profile

class ProfileAdmin(admin.ModelAdmin):
    list_display = ('owner', 'id', 'name', 'myself')

admin.site.register(Profile, ProfileAdmin)