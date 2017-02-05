from django.db import models

# Create your models here.

class Test(models.Model):
    id = models.AutoField(primary_key=True)
    content = models.CharField(max_length=100, default="Hello, World!")

    class Meta:
        ordering = ('id',)