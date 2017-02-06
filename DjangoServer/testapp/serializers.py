from django.contrib.auth.models import User
from rest_framework import serializers

from testapp.models import Test


class TestSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Test
        fields = ('url', 'owner', 'id', 'content')

class UserSerializer(serializers.HyperlinkedModelSerializer):
    testapp = serializers.HyperlinkedRelatedField(many=True, view_name='test-detail', read_only=True)

    class Meta:
        model = User
        fields = ('url', 'username', 'testapp')