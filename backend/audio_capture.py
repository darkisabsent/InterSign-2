import os
import pyaudio
import wave
import json
from vosk import Model, KaldiRecognizer
import requests

def record_audio(output_filename, duration=10):
    chunk = 1024  # Record in chunks of 1024 samples
    sample_format = pyaudio.paInt16  # 16 bits per sample
    channels = 1
    fs = 16000  # Record at 16000 samples per second

    p = pyaudio.PyAudio()  # Create an interface to PortAudio

    stream = p.open(format=sample_format,
                    channels=channels,
                    rate=fs,
                    frames_per_buffer=chunk,
                    input=True)

    frames = []  # Initialize array to store frames

    # Store data in chunks for the specified duration
    for _ in range(0, int(fs / chunk * duration)):
        data = stream.read(chunk)
        frames.append(data)

    # Stop and close the stream
    stream.stop_stream()
    stream.close()
    # Terminate the PortAudio interface
    p.terminate()

    # Save the recorded data as a WAV file
    wf = wave.open(output_filename, 'wb')
    wf.setnchannels(channels)
    wf.setsampwidth(p.get_sample_size(sample_format))
    wf.setframerate(fs)
    wf.writeframes(b''.join(frames))
    wf.close()

def transcribe_audio(audio_filename):
    # Use the relative path to the Vosk model
    script_dir = os.path.dirname(__file__)
    model_path = os.path.join(script_dir, "models/vosk-model-small-en-us-0.15")
    model = Model(model_path)
    recognizer = KaldiRecognizer(model, 16000)

    wf = wave.open(audio_filename, "rb")
    if wf.getnchannels() != 1 or wf.getsampwidth() != 2 or wf.getframerate() != 16000:
        raise ValueError("Audio file must be WAV format mono PCM.")

    while True:
        data = wf.readframes(4000)
        if len(data) == 0:
            break
        if recognizer.AcceptWaveform(data):
            result = json.loads(recognizer.Result())
            return result.get('text', '')

    result = json.loads(recognizer.FinalResult())
    return result.get('text', '')

def send_text_to_backend(text):
    url = 'http://127.0.0.1:5000/translate_text'
    response = requests.post(url, json={'text': text})
    if response.status_code == 200:
        video_urls = response.json().get('video', [])
        return video_urls
    else:
        print('Failed to get video URLs. Status code:', response.status_code)
        return []

if __name__ == '__main__':
    output_filename = 'output.wav'
    record_audio(output_filename, duration=10)
    transcribed_text = transcribe_audio(output_filename)
    if transcribed_text:
        print(f'{transcribed_text}')  # Log the transcribed text
        send_text_to_backend(transcribed_text)
    else:
        print('No transcribed text found.')