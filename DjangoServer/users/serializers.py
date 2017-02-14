from django.contrib.auth import get_user_model
from django.contrib.auth.models import User
from django.db.models import Q
from rest_framework import fields
from rest_framework import serializers
from rest_framework.serializers import ModelSerializer, CharField, ValidationError

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


class UserLoginSerializer(ModelSerializer):
    token = CharField(allow_blank=True, read_only=True)
    username = CharField(required=False, allow_blank=True)

    class Meta:
        model = User
        fields = [
            'username',
            'password',
            'token',
        ]
        extra_kwargs = {"password":
                            {"write_only": True}
                        }

    def validate(self, data):
        username = data.get("username", None)
        password = data.get("password", None)
        if not username:
            raise ValidationError("A username is required to login.")

        user = User.objects.filter(
            Q(username=username)
        ).distinct()
        if user.exists() and user.count() ==1:
            user_obj = user.first()
        else:
            raise ValidationError("This username is not valid.")

        if user_obj:
            if not user_obj.check_password(password):
                raise ValidationError("Incorrect credentials please try again.")

        data["token"] = "SOME RANDOM TOKEN"
        return data

class ProfileSerializer(serializers.HyperlinkedModelSerializer):
    owner = serializers.ReadOnlyField(source='owner.username')
    image = serializers.ImageField(max_length=None, use_url=True)
    interest = fields.MultipleChoiceField(choices=INTEREST_CHOICES)

    class Meta:
        model = Profile
        fields = ('url', 'owner', 'id', 'name', 'interest', 'image')