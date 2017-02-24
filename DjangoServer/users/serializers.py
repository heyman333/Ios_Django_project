from django.contrib.auth import get_user_model
from django.contrib.auth.models import User
from rest_framework import fields
from rest_framework import serializers

from users.models import Profile, INTEREST_CHOICES


class UserSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = User
        fields = ('url', 'username')

class UserCreateSerializer(serializers.HyperlinkedModelSerializer):
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

class ProfileSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')
    interest = fields.MultipleChoiceField(choices=INTEREST_CHOICES)

    class Meta:
        model = Profile
        fields = ('url', 'owner', 'id', 'name', 'interest', 'image', 'myself')