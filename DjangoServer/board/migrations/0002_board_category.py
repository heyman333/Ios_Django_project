# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('board', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='board',
            name='category',
            field=models.CharField(max_length=10, default=None, choices=[('웹', '웹'), ('모바일', '모바일'), ('빅데이터', '빅데이터'), ('디자인', '디자인'), ('기타', '기타')]),
        ),
    ]
