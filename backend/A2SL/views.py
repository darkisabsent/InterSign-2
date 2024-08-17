from django.http import JsonResponse
from django.shortcuts import render, redirect
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth import login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.staticfiles import finders
from django.views.decorators.csrf import csrf_exempt
from .utils import translate_text_to_sign_language
import nltk
import speech_recognition as sr
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer
from .utils import translate_text_to_sign_language

# Ensure necessary NLTK data is downloaded
nltk.download('punkt')
nltk.download('averaged_perceptron_tagger')
nltk.download('wordnet')

def translate_speech_to_sign_language(request):
    if request.method == 'POST':
        audio_file = request.FILES['audio']
        recognizer = sr.Recognizer()
        with sr.AudioFile(audio_file) as source:
            audio = recognizer.record(source)
            try:
                text = recognizer.recognize_google(audio)
                sign_language_video = translate_text_to_sign_language(text)
                return JsonResponse({'text': text, 'video': sign_language_video})
            except sr.UnknownValueError:
                return JsonResponse({'error': 'Speech not recognized'}, status=400)
            except sr.RequestError:
                return JsonResponse({'error': 'API unavailable'}, status=500)
    return JsonResponse({'error': 'Invalid request method'}, status=405)

@csrf_exempt
def translate_text_to_sign_language(request):
    if request.method == 'POST':
        text = request.POST.get('text', '')
        video_sequence = translate_text_to_sign_language(text)
        return JsonResponse({'video': video_sequence})
    return JsonResponse({'error': 'Invalid request method'}, status=405)