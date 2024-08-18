import cv2
import numpy as np
import pickle
from tensorflow.keras.models import load_model
import mediapipe as mp
import pyttsx3
import sounddevice as sd
import soundfile as sf
import subprocess
import os
# Constants for device indices
REALTEK_SPEAKERS_INDEX = 3
CABLE_OUTPUT_INDEX = 1
# Load the trained model and gesture labels
model = load_model('./saved_models/gesture_recognition_lstm.h5')

with open('./saved_models/gesture_labels.pkl', 'rb') as f:
    gesture_labels = pickle.load(f)

# Initialize MediaPipe
mp_hands = mp.solutions.hands
hands = mp_hands.Hands()

# Initialize pyttsx3 for TTS
tts_engine = pyttsx3.init()

# Define a function to preprocess landmarks
def preprocess_landmarks(landmarks):
    landmarks_np = np.array(landmarks).reshape(1, 1, -1)  # Reshape for LSTM
    return landmarks_np

# Define a function to play audio directly
def play_audio_directly(text):
    """Generate TTS audio from text and play it directly."""
    tts_engine.save_to_file(text, 'gesture_tts.wav')
    tts_engine.runAndWait()
    
    # Play the audio file
    data, fs = sf.read('gesture_tts.wav', dtype='float32')
    sd.play(data, samplerate=fs)
    sd.wait()  # Wait until the audio is done playing

# Set default audio device (call only once for optimization)
def set_default_audio_device(device_index):
    """Set the default audio playback device by index using PowerShell."""
    ps_script = f'''
    $device = Get-AudioDevice -List | Where-Object {{ $_.Index -eq {device_index} }}
    if ($device -ne $null) {{
        Set-AudioDevice -Index $device.Index
    }} else {{
        Write-Host "Device not found"
    }}
    '''
    ps_script_path = 'set_default_audio_device.ps1'
    with open(ps_script_path, 'w') as f:
        f.write(ps_script)
    
    subprocess.run(["powershell", "-ExecutionPolicy", "Bypass", "-File", ps_script_path], check=True)
    os.remove(ps_script_path)

# Set the default audio device once before starting the main loop
set_default_audio_device(CABLE_OUTPUT_INDEX)

# Track the last gesture to avoid redundant TTS
last_gesture = None

# Start video capture
cap = cv2.VideoCapture(0)

while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break

    frame = cv2.flip(frame, 1)  # Flip the frame horizontally
    rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = hands.process(rgb_frame)

    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            landmarks = [(lm.x, lm.y, lm.z) for lm in hand_landmarks.landmark]
            preprocessed_landmarks = preprocess_landmarks(landmarks)

            # Make prediction
            prediction = model.predict(preprocessed_landmarks)
            gesture_label_idx = np.argmax(prediction)
            
            # Get the predicted gesture
            predicted_gesture = list(gesture_labels.keys())[gesture_label_idx]
            
            # Print the predicted gesture
            print(f'Predicted gesture: {predicted_gesture}')
            
            # Generate and play TTS only if the gesture has changed
            if predicted_gesture != last_gesture:
                last_gesture = predicted_gesture
                play_audio_directly(predicted_gesture)

    # Exit condition
    key = cv2.waitKey(1) & 0xFF
    if key == ord('q'):
        set_default_audio_device(REALTEK_SPEAKERS_INDEX)
        break

cap.release()
cv2.destroyAllWindows()
