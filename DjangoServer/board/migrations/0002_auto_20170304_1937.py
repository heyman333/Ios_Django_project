# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('board', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='board',
            name='fri',
        ),
        migrations.RemoveField(
            model_name='board',
            name='mon',
        ),
        migrations.RemoveField(
            model_name='board',
            name='sat',
        ),
        migrations.RemoveField(
            model_name='board',
            name='sun',
        ),
        migrations.RemoveField(
            model_name='board',
            name='thu',
        ),
        migrations.RemoveField(
            model_name='board',
            name='tue',
        ),
        migrations.RemoveField(
            model_name='board',
            name='wed',
        ),
        migrations.AddField(
            model_name='board',
            name='location',
            field=models.CharField(max_length=100, null=True),
        ),
    ]
