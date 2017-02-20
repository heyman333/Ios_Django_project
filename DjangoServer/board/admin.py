from django.contrib import admin

from board.models import Board, Comment


class BoardAdmin(admin.ModelAdmin):
    list_display = ('id', 'owner', 'name', 'title', 'date')

class CommentAdmin(admin.ModelAdmin):
    list_display = ['id', 'owner', 'name', 'date', 'content', 'board_id']

admin.site.register(Board, BoardAdmin)
admin.site.register(Comment, CommentAdmin)