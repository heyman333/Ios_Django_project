# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import multiselectfield.db.fields


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0005_auto_20170219_1556'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='image',
            field=models.ImageField(blank=True, null=True, default='Images/None/default.PNG', upload_to='Images/'),
        ),
        migrations.AlterField(
            model_name='profile',
            name='interest',
            field=multiselectfield.db.fields.MultiSelectField(max_length=225, blank=True, null=True, choices=[('C', 'C'), ('C++', 'C++'), ('C#', 'C#'), ('Java', 'Java'), ('JavaScript', 'JavaScript'), ('JSP', 'JSP'), ('JPA', 'JPA'), ('Python', 'Python'), ('Ruby', 'Ruby'), ('Object-C', 'Object-C'), ('Swift', 'Swift'), ('PHP', 'PHP'), ('HTML', 'HTML'), ('CSS', 'CSS'), ('Node.js', 'Node.js'), ('Spring', 'Spring'), ('Django', 'Django'), ('.NET', '.NET'), ('IOS', 'IOS'), ('Android', 'Android'), ('HybridApp', 'HybridApp'), ('Linux', 'Linux'), ('Hadoop', 'Hadoop'), ('DataStructure', 'DataStructure'), ('Algorithm', 'Algorithm'), ('UI/UX', 'UI/UX'), ('PhotoShop', 'PhotoShop'), ('Illustrator', 'Illustrator'), ('InDesign', 'InDesign')]),
        ),
    ]
