from flask import Flask, request, jsonify
from flask_cors import CORS
import os

app = Flask(__name__)
CORS(app)

VIDEO_DIR = './videos'

@app.route('/translate_text', methods=['POST'])
def translate_text():
    data = request.get_json()
    text = data.get('text', '').upper()
    print(f'Received text: {text}')
    
    if not text:
        print('No text received.')
        return jsonify({'video': []})
    
    words = text.split()
    video_urls = []

    for word in words:
        word_video_path = os.path.join(VIDEO_DIR, f'{word}.mp4')
        if os.path.exists(word_video_path):
            video_urls.append(f'{word}.mp4')
        else:
            for char in word:
                char_video_path = os.path.join(VIDEO_DIR, f'{char}.mp4')
                if os.path.exists(char_video_path):
                    video_urls.append(f'{char}.mp4')
                else:
                    print(f'No video found for character: {char}')
                    
    print(f'Generated video URLs: {video_urls}')
    return jsonify({'video': video_urls})

if __name__ == '__main__':
    app.run(debug=True)