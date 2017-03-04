# -*- coding: utf-8 -*-
# Generated by Django 1.10.5 on 2017-03-02 09:29
from __future__ import unicode_literals

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import multiselectfield.db.fields


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Image',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('image', models.ImageField(blank=True, null=True, upload_to='Images/')),
                ('owner', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='users_Image', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('id',),
            },
        ),
        migrations.CreateModel(
            name='Profile',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=10)),
                ('interest', multiselectfield.db.fields.MultiSelectField(blank=True, choices=[('프론트엔드', '프론트엔드'), ('백엔드', '백엔드'), ('응용프로그래밍', '응용프로그래밍'), ('게임프로그래밍', '게임프로그래밍'), ('빅데이터', '빅데이터'), ('iOS', 'iOS'), ('안드로이드', '안드로이드'), ('머신러닝', '머신러닝'), ('UI/UX', 'UI/UX'), ('그래픽디자인', '그래픽디자인'), ('기획', '기획')], max_length=225, null=True)),
                ('image', models.ImageField(blank=True, null=True, upload_to='Images/')),
                ('myself', models.TextField(null=True)),
                ('address', models.CharField(max_length=100, null=True)),
                ('address_ok', models.BooleanField(default=False)),
                ('katalk', models.CharField(max_length=100, null=True)),
                ('katalk_ok', models.BooleanField(default=False)),
                ('owner', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='users_Profile', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'ordering': ('id',),
            },
        ),
    ]
