from django.db import models
from multiselectfield import MultiSelectField


INTEREST_CHOICES = (
        ('프론트엔드', '프론트엔드'),
        ('백엔드', '백엔드'),
        ('응용프로그래밍', '응용프로그래밍'),
        ('게임프로그래밍', '게임프로그래밍'),
        ('빅데이터', '빅데이터'),
        ('iOS', 'iOS'),
        ('안드로이드', '안드로이드'),
        ('머신러닝', '머신러닝'),
        ('UI/UX', 'UI/UX'),
        ('그래픽디자인', '그래픽디자인'),
        ('기획', '기획'),
    )

class Profile(models.Model):

    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=10)
    interest = MultiSelectField(choices = INTEREST_CHOICES, max_length=225, null=True, blank=True)
    image = models.ImageField(upload_to='Images/', blank=True, null=True)
    owner = models.ForeignKey('auth.User', related_name='users_Profile')
    myself = models.TextField(null=True)
    address = models.CharField(max_length=100, null=True)
    address_ok = models.BooleanField(default=False)
    katalk = models.CharField(max_length=100, null=True)
    katalk_ok = models.BooleanField(default=False)

    class Meta:
        ordering = ('id',)