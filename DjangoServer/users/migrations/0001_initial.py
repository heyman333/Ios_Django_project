# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import multiselectfield.db.fields
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Profile',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=10)),
                ('interest', multiselectfield.db.fields.MultiSelectField(max_length=225, blank=True, null=True, choices=[('C', 'C'), ('C++', 'C++'), ('C#', 'C#'), ('Java', 'Java'), ('JavaScript', 'JavaScript'), ('JSP', 'JSP'), ('JPA', 'JPA'), ('Python', 'Python'), ('Ruby', 'Ruby'), ('Object-C', 'Object-C'), ('Swift', 'Swift'), ('PHP', 'PHP'), ('HTML', 'HTML'), ('CSS', 'CSS'), ('Node.js', 'Node.js'), ('Spring', 'Spring'), ('Django', 'Django'), ('.NET', '.NET'), ('IOS', 'IOS'), ('Android', 'Android'), ('HybridApp', 'HybridApp'), ('Linux', 'Linux'), ('Hadoop', 'Hadoop'), ('DataStructure', 'DataStructure'), ('Algorithm', 'Algorithm'), ('UI/UX', 'UI/UX'), ('PhotoShop', 'PhotoShop'), ('Illustrator', 'Illustrator'), ('InDesign', 'InDesign')])),
                ('image', models.ImageField(blank=True, null=True, upload_to='Images/')),
                ('owner', models.ForeignKey(related_name='users_Profile', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('id',),
            },
        ),
    ]
