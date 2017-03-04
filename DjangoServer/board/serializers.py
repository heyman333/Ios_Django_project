from rest_framework import serializers
from board.models import Board, Comment


class BoardSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Board
        fields = ('id', 'owner', 'category', 'title', 'date', 'name', 'content',
                  'mon_time',
                  'tue_time',
                  'wed_time',
                  'thu_time',
                  'fri_time',
                  'sat_time',
                  'sun_time',
                  'people_num', 'location')

class CommentSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Comment
        fields = ['id', 'url', 'owner', 'name', 'date', 'content', 'board_id']
