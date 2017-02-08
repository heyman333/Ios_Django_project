from django.db import models

class Test(models.Model):
    id = models.AutoField(primary_key=True)
    content = models.CharField(max_length=100, default="Hello, World!")
    owner = models.ForeignKey('auth.User', related_name='testapp_Test')

    class Meta:
        ordering = ('id',)

class Person(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=10)
    age = models.IntegerField()
    gender = models.CharField(choices=[('남자', '남자'), ('여자', '여자')], max_length=10)
    address = models.CharField(max_length=100)
    owner = models.ForeignKey('auth.User', related_name='testapp_Person')

    class Meta:
        ordering = ('id',)
