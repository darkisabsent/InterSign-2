import time
import sounddevice as sd
import soundfile as sf
import subprocess
import os

# Constants for device indices
REALTEK_SPEAKERS_INDEX = 3
CABLE_OUTPUT_INDEX = 1

def set_default_audio_device(device_index):
    """Set the default audio playback device by index using PowerShell."""
    # PowerShell command to set default audio device
    ps_script = f'''
    $device = Get-AudioDevice -List | Where-Object {{ $_.Index -eq {device_index} }}
    if ($device -ne $null) {{
        Set-AudioDevice -Index $device.Index
    }} else {{
        Write-Host "Device not found"
    }}
    '''

    # Run PowerShell command
    ps_script_path = 'set_default_audio_device.ps1'
    with open(ps_script_path, 'w') as f:
        f.write(ps_script)
    
    subprocess.run(["powershell", "-ExecutionPolicy", "Bypass", "-File", ps_script_path], check=True)
    time.sleep(1)  # Wait for the system to apply the changes
    
    # Clean up the PowerShell script file
    os.remove(ps_script_path)

def play_audio(file_path):
    """Play audio through the default audio device."""
    data, fs = sf.read(file_path, dtype='float32')
    sd.play(data, samplerate=fs)
    sd.wait()  # Wait until the audio is done playing

def main():
    # Set the Realtek Speakers as the default playback device
    set_default_audio_device(CABLE_OUTPUT_INDEX)
    
    # Play the audio
    play_audio('test_tts.wav')

    # Optionally revert to another device (if needed)
    set_default_audio_device(REALTEK_SPEAKERS_INDEX)

if __name__ == "__main__":
    main()
