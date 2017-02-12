from django.contrib import admin

from testapp.models import Test, Person

class TestAdmin(admin.ModelAdmin):
    list_display = ('id', 'content', 'owner')
class PersonAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'age', 'address', 'owner')

admin.site.register(Test, TestAdmin)
admin.site.register(Person, PersonAdmin)