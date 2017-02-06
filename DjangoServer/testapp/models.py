from django.db import models
from pygments.lexers import get_all_lexers
from pygments.styles import get_all_styles

class Test(models.Model):
    id = models.AutoField(primary_key=True)
    content = models.CharField(max_length=100, default="Hello, World!")
    owner = models.ForeignKey('auth.User', related_name='testapp')

    class Meta:
        ordering = ('id',)