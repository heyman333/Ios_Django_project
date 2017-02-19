from django.db import models

class Board(models.Model):

    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=100)
    date = models.DateTimeField(auto_now_add=True)
    name = models.CharField(max_length=10)
    content = models.TextField()
    owner = models.ForeignKey('auth.User', related_name='board_Board')

    class Meta:
        ordering = ('id',)
