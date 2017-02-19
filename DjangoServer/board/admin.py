from django.contrib import admin

from board.models import Board

class BoardAdmin(admin.ModelAdmin):
    list_display = ('id', 'owner', 'title', 'date', 'name', 'content')

admin.site.register(Board, BoardAdmin)