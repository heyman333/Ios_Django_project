# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import multiselectfield.db.fields


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0003_auto_20170212_1907'),
    ]

    operations = [
        migrations.AlterField(
            model_name='profile',
            name='interest',
            field=multiselectfield.db.fields.MultiSelectField(max_length=17, choices=[('C', 'C'), ('C++', 'C++'), ('JAVA', 'JAVA'), ('PYTHON', 'PYTHON')]),
        ),
    ]
