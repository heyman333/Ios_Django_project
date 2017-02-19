# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('board', '0006_comment'),
    ]

    operations = [
        migrations.AlterField(
            model_name='comment',
            name='board_id',
            field=models.IntegerField(),
        ),
    ]
