from django.db import models
from multiselectfield import MultiSelectField


INTEREST_CHOICES = (
        ('C', 'C'),
        ('C++', 'C++'),
        ('C#', 'C#'),
        ('Java', 'Java'),
        ('JavaScript', 'JavaScript'),
        ('JSP', 'JSP'),
        ('JPA', 'JPA'),
        ('Python', 'Python'),
        ('Ruby', 'Ruby'),
        ('Object-C', 'Object-C'),
        ('Swift', 'Swift'),
        ('PHP', 'PHP'),
        ('HTML', 'HTML'),
        ('CSS', 'CSS'),
        ('Node.js', 'Node.js'),
        ('Spring', 'Spring'),
        ('Django', 'Django'),
        ('.NET', '.NET'),
        ('IOS', 'IOS'),
        ('Android', 'Android'),
        ('HybridApp', 'HybridApp'),
        ('Linux', 'Linux'),
        ('Hadoop', 'Hadoop'),
        ('DataStructure', 'DataStructure'),
        ('Algorithm', 'Algorithm'),
        ('UI/UX', 'UI/UX'),
        ('PhotoShop', 'PhotoShop'),
        ('Illustrator', 'Illustrator'),
        ('InDesign', 'InDesign'),
    )

class Profile(models.Model):

    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=10)
    interest = MultiSelectField(choices = INTEREST_CHOICES, max_length=225, null=True, blank=True)
    image = models.ImageField(upload_to='Images/', blank=True, null=True)
    owner = models.ForeignKey('auth.User', related_name='users_Profile')

    class Meta:
        ordering = ('id',)