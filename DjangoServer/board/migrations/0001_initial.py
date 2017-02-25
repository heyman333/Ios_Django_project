# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
from django.conf import settings


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Board',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('title', models.CharField(max_length=100)),
                ('date', models.DateTimeField(auto_now_add=True)),
                ('name', models.CharField(max_length=10)),
                ('content', models.TextField()),
                ('mon', models.CharField(max_length=10, null=True)),
                ('mon_time', models.CharField(max_length=20, null=True)),
                ('tue', models.CharField(max_length=10, null=True)),
                ('tue_time', models.CharField(max_length=20, null=True)),
                ('wed', models.CharField(max_length=10, null=True)),
                ('wed_time', models.CharField(max_length=20, null=True)),
                ('thu', models.CharField(max_length=10, null=True)),
                ('thu_time', models.CharField(max_length=20, null=True)),
                ('fri', models.CharField(max_length=10, null=True)),
                ('fri_time', models.CharField(max_length=20, null=True)),
                ('sat', models.CharField(max_length=10, null=True)),
                ('sat_time', models.CharField(max_length=20, null=True)),
                ('sun', models.CharField(max_length=10, null=True)),
                ('sun_time', models.CharField(max_length=20, null=True)),
                ('people_num', models.IntegerField(default=0)),
                ('owner', models.ForeignKey(related_name='board_Board', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('id',),
            },
        ),
        migrations.CreateModel(
            name='Comment',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('date', models.DateTimeField(auto_now_add=True)),
                ('name', models.CharField(max_length=10)),
                ('content', models.TextField()),
                ('board_id', models.IntegerField()),
                ('owner', models.ForeignKey(related_name='board_Comment', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('id',),
            },
        ),
    ]
