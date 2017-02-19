from django.db import models

class Board(models.Model):

    id = models.AutoField(primary_key=True)
    title = models.CharField(max_length=100)
    date = models.DateTimeField(auto_now_add=True)
    name = models.CharField(max_length=10)
    content = models.TextField()
    owner = models.ForeignKey('auth.User', related_name='board_Board')
    mon = models.CharField(max_length=10, null=True)
    mon_time = models.CharField(max_length=20, null=True)
    tue = models.CharField(max_length=10, null=True)
    tue_time = models.CharField(max_length=20, null=True)
    wed = models.CharField(max_length=10, null=True)
    wed_time = models.CharField(max_length=20, null=True)
    thu = models.CharField(max_length=10, null=True)
    thu_time = models.CharField(max_length=20, null=True)
    fri = models.CharField(max_length=10, null=True)
    fri_time = models.CharField(max_length=20, null=True)
    sat = models.CharField(max_length=10, null=True)
    sat_time = models.CharField(max_length=20, null=True)
    sun = models.CharField(max_length=10, null=True)
    sun_time = models.CharField(max_length=20, null=True)
    people_num = models.IntegerField(default=0)

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
