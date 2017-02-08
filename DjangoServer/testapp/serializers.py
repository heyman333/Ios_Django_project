from django.contrib.auth.models import User
from rest_framework import serializers

from testapp.models import Test, Person


class TestSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Test
        fields = ('url', 'owner', 'id', 'content')

class PersonSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')

    class Meta:
        model = Person
        fields = ('url', 'owner', 'id', 'name', 'age', 'gender', 'address')

class UserSerializer(serializers.HyperlinkedModelSerializer):
    testapp_Test = serializers.HyperlinkedRelatedField(many=True, view_name='test-detail', read_only=True)
    testapp_Person = serializers.HyperlinkedRelatedField(many=True, view_name='person-detail', read_only=True)

    class Meta:
        model = User
        fields = ('url', 'username', 'testapp_Test', 'testapp_Person')