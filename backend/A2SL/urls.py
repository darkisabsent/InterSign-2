from django.urls import path
from .views import home_view, about_view, contact_view, animation_view, translate_text, signup_view, login_view, logout_view

urlpatterns = [
    path('', home_view, name='home'),
    path('about/', about_view, name='about'),
    path('contact/', contact_view, name='contact'),
    path('animation/', animation_view, name='animation'),
    path('translate_text', translate_text, name='translate_text'),
    path('signup/', signup_view, name='signup'),
    path('login/', login_view, name='login'),
    path('logout/', logout_view, name='logout'),
]