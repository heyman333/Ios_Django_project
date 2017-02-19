# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('board', '0004_auto_20170219_1347'),
    ]

    operations = [
        migrations.AlterField(
            model_name='board',
            name='fri',
            field=models.CharField(max_length=10, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='fri_time',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='mon',
            field=models.CharField(max_length=10, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='mon_time',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='people_num',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='board',
            name='sat',
            field=models.CharField(max_length=10, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='sat_time',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='sun',
            field=models.CharField(max_length=10, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='sun_time',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='thu',
            field=models.CharField(max_length=10, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='thu_time',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='tue',
            field=models.CharField(max_length=10, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='tue_time',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='wed',
            field=models.CharField(max_length=10, null=True),
        ),
        migrations.AlterField(
            model_name='board',
            name='wed_time',
            field=models.CharField(max_length=20, null=True),
        ),
    ]
