# from django.contrib import admin
# from django.urls import path, include
# from rest_framework import routers

# router = routers.DefaultRouter()
# router.register(r'awsimage', views.AwsImageViewSet)


# urlpatterns = [
#     path('', include(router.urls)),
#     path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
# ]
# from django.contrib import admin
# from django.urls import path, include
# from rest_framework import routers
# from .views import AwsImageViewSet
# router = routers.DefaultRouter()
# router.register(r'awsimage', AwsImageViewSet)

# urlpatterns = [

#     path('', include(router.urls)),
#     path('api-auth/', include('rest_framework.urls', namespace='rest_framework'))
# ]
from django.conf.urls import url
from .views import FileView

urlpatterns = [
    url(r'^upload/$', FileView.as_view(), name='file-upload'),
]
