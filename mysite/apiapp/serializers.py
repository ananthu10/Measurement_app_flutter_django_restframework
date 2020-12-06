# # from rest_framework import serializer
# # from .models import awsimage


# # class awsimageserializer(serializer.HyperLinkedModelSerializer):
# #     class Meta:
# #         model = awsimage
# #         fields = ('title', 'images')
# from .models import awsimage
# from rest_framework import routers, serializers, viewsets

# # Serializers define the API representation.


# class awsimageserializer(serializers.HyperlinkedModelSerializer):
#     class Meta:
#         model = awsimage
#         fields = ['title', 'images']

# # ViewSets define the view behavior.
from rest_framework import serializers
from django.core.files import File
import base64
from .models import File


class FileSerializer(serializers.ModelSerializer):
    class Meta():
        model = File
        fields = ('file1', 'width', 'timestamp')

    def get_base64_image(self, obj):
        f = open(obj.image_file.path, 'rb')
        image = File(f)
        data = base64.b64encode(image.read())
        f.close()
        return data
