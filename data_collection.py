import cv2
import os
import mediapipe as mp
import numpy as np
import pickle

# Initialize MediaPipe hands and drawing utilities
mp_hands = mp.solutions.hands
hands = mp_hands.Hands(static_image_mode=False, max_num_hands=2, min_detection_confidence=0.7)
mp_drawing = mp.solutions.drawing_utils

# Setup directories
gesture_type = 'static'  # Change to 'static' or moving for static gestures
gesture_name = 'great'    # Change this to the specific gesture name
save_dir = f'./landmark_dataset/{gesture_type}/{gesture_name}'
os.makedirs(save_dir, exist_ok=True)

# Function to save landmarks as tensors
def save_landmarks(landmarks, file_path):
    landmarks_array = np.array([[lm.x, lm.y, lm.z] for lm in landmarks.landmark], dtype=np.float32)
    with open(file_path, 'wb') as f:
        pickle.dump(landmarks_array, f)

cap = cv2.VideoCapture(0)  # Start video capture
frame_count = 0

recording = False
while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break

    frame = cv2.flip(frame, 1)  # Flip the frame horizontally
    rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
    results = hands.process(rgb_frame)

    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            mp_drawing.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)

            if recording:
                file_path = f'{save_dir}/landmarks_{frame_count}.pkl'
                save_landmarks(hand_landmarks, file_path)
                frame_count += 1

    cv2.imshow('Gesture Recording', frame)

    key = cv2.waitKey(1) & 0xFF
    if key == ord('r'):  # Press 'r' to start/stop recording for moving gestures
        recording = not recording
        print("Recording started..." if recording else "Recording stopped.")
    elif key == ord('p'):  # Press 'p' to start/stop capturing for static gestures
        recording = True
        print("Capturing static gesture...")
        while frame_count < 200 and recording:
            ret, frame = cap.read()
            if not ret:
                break

            frame = cv2.flip(frame, 1)
            rgb_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            results = hands.process(rgb_frame)

            if results.multi_hand_landmarks:
                for hand_landmarks in results.multi_hand_landmarks:
                    mp_drawing.draw_landmarks(frame, hand_landmarks, mp_hands.HAND_CONNECTIONS)
                    file_path = f'{save_dir}/landmarks_{frame_count}.pkl'
                    save_landmarks(hand_landmarks, file_path)
                    frame_count += 1

            cv2.imshow('Gesture Recording', frame)
            if cv2.waitKey(1) & 0xFF == ord('p'):  # Press 'p' again to stop capturing
                recording = False
                break

    if key == ord('q'):  # Press 'q' to quit
        break

cap.release()
cv2.destroyAllWindows()
