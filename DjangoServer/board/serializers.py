from rest_framework import serializers
from board.models import Board


class BoardSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Board
        fields = ('id',
                  'url',
                  'owner',
                  'title',
                  'date',
                  'name',
                  'content',
                  'mon',
                  'mon_time',
                  'tue',
                  'tue_time',
                  'wed',
                  'wed_time',
                  'thu',
                  'thu_time',
                  'fri',
                  'fri_time',
                  'sat',
                  'sat_time',
                  'sun',
                  'sun_time',
                  'people_num',)
