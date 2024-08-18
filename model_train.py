import os
import numpy as np
import pickle
from tensorflow.keras.models import Sequential # type: ignore
from tensorflow.keras.layers import LSTM, Dense # type: ignore
from tensorflow.keras.utils import to_categorical # type: ignore
from sklearn.model_selection import train_test_split

# Load Data
X, y = [], []
gesture_labels = {}
gesture_type = 'static'  # Choose which gestures you work with

# Detect all available gestures
base_dir = f'./landmark_dataset/{gesture_type}'
gesture_names = os.listdir(base_dir)

for i, gesture_name in enumerate(gesture_names):
    gesture_labels[gesture_name] = i
    data_dir = os.path.join(base_dir, gesture_name)
    for file_name in os.listdir(data_dir):
        with open(os.path.join(data_dir, file_name), 'rb') as f:
            landmarks = pickle.load(f)
            X.append(landmarks)
            y.append(i)

X = np.array(X)
y = to_categorical(y, num_classes=len(gesture_labels))

# Print the shape to understand its structure
print(f"Original shape of X: {X.shape}")

# Reshape for static gestures
X = X.reshape(X.shape[0], 1, X.shape[1] * X.shape[2])

# Split Data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Build LSTM Model
model = Sequential([
    LSTM(64, return_sequences=True, input_shape=(X_train.shape[1], X_train.shape[2])),
    LSTM(64),
    Dense(64, activation='relu'),
    Dense(len(gesture_labels), activation='softmax')
])

model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

# Train Model
model.fit(X_train, y_train, epochs=30, batch_size=32, validation_data=(X_test, y_test))

# Evaluate Model
loss, accuracy = model.evaluate(X_test, y_test)
print(f'Test Accuracy: {accuracy:.2f}')

# Save the model and gesture labels
model_save_path = './saved_models/gesture_recognition_lstm.h5'
model.save(model_save_path)
print(f"Model saved to {model_save_path}")

# Save gesture labels
gesture_labels_save_path = './saved_models/gesture_labels.pkl'
with open(gesture_labels_save_path, 'wb') as f:
    pickle.dump(gesture_labels, f)
print(f"Gesture labels saved to {gesture_labels_save_path}")
