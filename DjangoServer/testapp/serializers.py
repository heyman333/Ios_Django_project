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

