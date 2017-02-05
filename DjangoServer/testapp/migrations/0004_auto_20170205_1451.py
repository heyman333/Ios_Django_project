# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('testapp', '0003_auto_20170205_0216'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='test',
            options={'ordering': ('id',)},
        ),
        migrations.RemoveField(
            model_name='test',
            name='age',
        ),
        migrations.RemoveField(
            model_name='test',
            name='name',
        ),
        migrations.AddField(
            model_name='test',
            name='content',
            field=models.CharField(max_length=100, default='Hello, World!'),
        ),
        migrations.AlterField(
            model_name='test',
            name='id',
            field=models.AutoField(primary_key=True, serialize=False),
        ),
    ]
