from rest_framework import serializers

from testapp.models import Test


class TestSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Test
        fields = ('name', 'age')