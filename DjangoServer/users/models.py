from django.db import models
from multiselectfield import MultiSelectField


INTEREST_CHOICES = (
        ('C', 'C'),
        ('C++', 'C++'),
        ('JAVA', 'JAVA'),
        ('PYTHON', 'PYTHON'),
    )

class Profile(models.Model):

    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=10)
    interest = MultiSelectField(choices = INTEREST_CHOICES)
    image = models.ImageField(upload_to='Images/', default='Images/None/No-img.jpg')
    owner = models.ForeignKey('auth.User', related_name='users_Profile')

    class Meta:
        ordering = ('id',)