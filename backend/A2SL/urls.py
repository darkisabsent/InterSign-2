from django.urls import path
from . import views

urlpatterns = [
    path('translate/', views.translate_speech_to_sign_language, name='translate'),
]