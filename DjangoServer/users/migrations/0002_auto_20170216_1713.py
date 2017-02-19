# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import multiselectfield.db.fields


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='interest',
            field=multiselectfield.db.fields.MultiSelectField(max_length=225, choices=[('C', 'C'), ('C++', 'C++'), ('C#', 'C#'), ('Java', 'Java')]),
        ),
    ]
