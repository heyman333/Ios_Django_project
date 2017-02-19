from rest_framework import serializers
from board.models import Board


class BoardSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Board
        fields = ('id', 'url', 'owner', 'title', 'date', 'name', 'content')
