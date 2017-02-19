# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('board', '0002_auto_20170216_0038'),
    ]

    operations = [
        migrations.AlterField(
            model_name='board',
            name='date',
            field=models.DateTimeField(auto_now_add=True),
        ),
    ]
