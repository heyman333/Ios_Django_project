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
            name='Profile',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=10)),
                ('age', models.IntegerField()),
                ('email', models.EmailField(max_length=254)),
                ('interest', models.CharField(max_length=100)),
                ('image', models.ImageField(default='Images/None/No-img.jpg', upload_to='Images/')),
                ('owner', models.ForeignKey(related_name='users_Profile', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('id',),
            },
        ),
    ]
