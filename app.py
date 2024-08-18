from flask import Flask, request, jsonify
import cv2
import numpy as np
import pickle
from tensorflow.keras.models import load_model
import mediapipe as mp

app = Flask(__name__)

# Load the trained model and gesture labels
model = load_model('./saved_models/gesture_recognition_lstm.h5')

with open('./saved_models/gesture_labels.pkl', 'rb') as f:
    gesture_labels = pickle.load(f)

# Initialize MediaPipe
mp_hands = mp.solutions.hands
hands = mp_hands.Hands()

def preprocess_landmarks(landmarks):
    landmarks_np = np.array(landmarks).reshape(1, 1, -1)
    return landmarks_np

@app.route('/predict', methods=['POST'])
def predict():
    file = request.files['file']
    image = cv2.imdecode(np.fromstring(file.read(), np.uint8), cv2.IMREAD_COLOR)
    rgb_frame = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    results = hands.process(rgb_frame)

    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            landmarks = [(lm.x, lm.y, lm.z) for lm in hand_landmarks.landmark]
            preprocessed_landmarks = preprocess_landmarks(landmarks)
            prediction = model.predict(preprocessed_landmarks)
            gesture_label_idx = np.argmax(prediction)
            predicted_gesture = list(gesture_labels.keys())[gesture_label_idx]
            return jsonify({'gesture': predicted_gesture})

    return jsonify({'gesture': 'No gesture detected'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)