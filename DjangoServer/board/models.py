from django.db import models

class Board(models.Model):

    CATEGORY_CHOICES = (
        ('웹', '웹'),
        ('모바일', '모바일'),
        ('빅데이터', '빅데이터'),
        ('디자인', '디자인'),
        ('기타', '기타'),
    )

    id = models.AutoField(primary_key=True)
    category = models.CharField(choices=CATEGORY_CHOICES, max_length=10, default=None)
    title = models.CharField(max_length=100)
    date = models.DateTimeField(auto_now_add=True)
    name = models.CharField(max_length=10)
    content = models.TextField()
    owner = models.ForeignKey('auth.User', related_name='board_Board')
    mon_time = models.CharField(max_length=20, null=True)
    tue_time = models.CharField(max_length=20, null=True)
    wed_time = models.CharField(max_length=20, null=True)
    thu_time = models.CharField(max_length=20, null=True)
    fri_time = models.CharField(max_length=20, null=True)
    sat_time = models.CharField(max_length=20, null=True)
    sun_time = models.CharField(max_length=20, null=True)
    people_num = models.IntegerField(default=0)
    location = models.CharField(max_length=100, null=True)

    class Meta:
        ordering = ('id',)

class Comment(models.Model):

    id = models.AutoField(primary_key=True)
    date = models.DateTimeField(auto_now_add=True)
    name = models.CharField(max_length=10)
    content = models.TextField()
    board_id = models.IntegerField(null=False)
    owner = models.ForeignKey('auth.User', related_name='board_Comment')

    class Meta:
        ordering = ('id',)