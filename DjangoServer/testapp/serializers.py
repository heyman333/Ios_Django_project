from django.contrib.auth import get_user_model
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

class UserCreateSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    def create(self, validated_data):
        user = get_user_model().objects.create(
            username=validated_data['username']
        )
        user.set_password(validated_data['password'])
        user.save()
        return user

    class Meta:
        model = get_user_model()
        fields = ('username', 'password')

