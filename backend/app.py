import os
from flask import Flask, request, jsonify

app = Flask(__name__)

# Directory where video files are stored
VIDEO_DIR = './videos'

@app.route('/translate_text', methods=['POST'])
def translate_text():
    try:
        data = request.get_json()
        if not data or 'text' not in data:
            return jsonify({'error': 'Invalid input'}), 400

        text = data['text']
        words = text.split()
        video_urls = []

        for word in words:
            word_video_path = os.path.join(VIDEO_DIR, f'{word}.mp4')
            if os.path.exists(word_video_path):
                print(f'Found video for word: {word}')
                video_urls.append(f'{word}.mp4')
            else:
                print(f'No video found for word: {word}, checking characters...')
                for char in word:
                    char_video_path = os.path.join(VIDEO_DIR, f'{char}.mp4')
                    if os.path.exists(char_video_path):
                        print(f'Found video for character: {char}')
                        video_urls.append(f'{char}.mp4')
                    else:
                        print(f'No video found for character: {char}')
                        
        print(f'Generated video URLs: {video_urls}')
        return jsonify({'video': video_urls, 'text': text})  # Include the transcribed text in the response
    except Exception as e:
        print(f'Error: {e}')
        return jsonify({'error': 'Internal server error'}), 500

if __name__ == '__main__':
    app.run(debug=True)