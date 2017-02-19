# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('board', '0003_auto_20170216_0039'),
    ]

    operations = [
        migrations.AddField(
            model_name='board',
            name='fri',
            field=models.CharField(max_length=10, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='fri_time',
            field=models.CharField(max_length=20, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='mon',
            field=models.CharField(max_length=10, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='mon_time',
            field=models.CharField(max_length=20, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='people_num',
            field=models.IntegerField(default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='sat',
            field=models.CharField(max_length=10, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='sat_time',
            field=models.CharField(max_length=20, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='sun',
            field=models.CharField(max_length=10, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='sun_time',
            field=models.CharField(max_length=20, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='thu',
            field=models.CharField(max_length=10, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='thu_time',
            field=models.CharField(max_length=20, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='tue',
            field=models.CharField(max_length=10, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='tue_time',
            field=models.CharField(max_length=20, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='wed',
            field=models.CharField(max_length=10, default=None),
        ),
        migrations.AddField(
            model_name='board',
            name='wed_time',
            field=models.CharField(max_length=20, default=None),
        ),
    ]
