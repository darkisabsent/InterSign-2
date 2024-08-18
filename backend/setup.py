import setuptools

setuptools.setup(
    name='audio-speech-to-sign-language-converter',
    packages=setuptools.find_packages(),
    setup_requires=['nltk', 'joblib', 'click', 'regex', 'sqlparse', 'setuptools'],
    install_requires=[
        'Flask',
        'Flask-CORS',
        'pyaudio',
        'google-cloud-speech',
        'requests',
    ],
)