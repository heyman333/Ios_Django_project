# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import multiselectfield.db.fields


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='profile',
            name='myself',
            field=models.TextField(null=True),
        ),
        migrations.AlterField(
            model_name='profile',
            name='interest',
            field=multiselectfield.db.fields.MultiSelectField(max_length=225, blank=True, null=True, choices=[('프론트엔드', '프론트엔드'), ('백엔드', '백엔드'), ('응용프로그래밍', '응용프로그래밍'), ('게임프로그래밍', '게임프로그래밍'), ('빅데이터', '빅데이터'), ('iOS', 'iOS'), ('안드로이드', '안드로이드'), ('머신러닝', '머신러닝'), ('UI/UX', 'UI/UX'), ('그래픽디자인', '그래픽디자인'), ('기획', '기획')]),
        ),
    ]
