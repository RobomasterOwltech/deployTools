import subprocess
import json
import re
import os
import argparse
import threading
from datetime import datetime, timezone

def get_time():
    # Get the current date and time
    current_datetime = datetime.now()

    # Extract the current hour and minute
    current_hour = current_datetime.hour
    current_minute = current_datetime.minute

    # Convert to the local timezone (system's default timezone)
    current_datetime_local = current_datetime.astimezone()

    timezone = str(current_datetime_local)[-6:]

    return f"{current_hour}:{current_minute} {timezone}"

def get_script_path():
    # Get the path of the current script
    script_path = os.path.abspath(__file__)
    return script_path

def load_json_file(file_path):
    try:
        with open(file_path, 'r') as file:
            data = json.load(file)
            return data
    except FileNotFoundError:
        print(f"Error: File '{file_path}' not found.")
    except json.JSONDecodeError:
        print(f"Error: Invalid JSON format in file '{file_path}'.")
    except Exception as e:
        print(f"An error occurred: {e}")

def parse_arguments():
    parser = argparse.ArgumentParser(description='Script to download pre-added files.')

    subparsers = parser.add_subparsers(title="subcommands", dest="subcommand", required=True)

    # List command
    list_parser = subparsers.add_parser("ls", help="List files")

    # Download command
    download_parser = subparsers.add_parser("download", help="Download files")
    download_parser.add_argument('filename', help='Path to the file to be processed')

    return parser.parse_args()

def get_id_by_filename(filename, dict): # Returns the id of a file
    for key, value in dict.items():
        if re.search(filename.lower(), key.lower()):
            return value
        
    return None

def convert_windows_path_to_linux(windows_path):
    # Replace backslashes with forward slashes
    linux_path = windows_path.replace('\\', '/')

    # Handle the conversion of the drive letter (C:) to /c/
    if ':' in linux_path:
        drive_letter, rest_of_path = linux_path.split(':', 1)
        linux_path = f'/{drive_letter.lower()}{rest_of_path}'

    return linux_path

def list_files(json):
    for file in json:
        print(file)

args = parse_arguments()

BASE_DIR = os.path.dirname(get_script_path()) # Gets the base dir

JSON_PATH = os.path.join(BASE_DIR, 'drive_files.json')  # Replace with your JSON file path
loaded_data = load_json_file(JSON_PATH)

if args.subcommand == "ls":
    list_files(loaded_data)
    exit(0)

# Access the filename from the arguments
filename = args.filename

if loaded_data:
    try:
        file_id = get_id_by_filename(filename, loaded_data)

        if not file_id:
            raise SystemError("File specified not found in JSON.")
    
        bash_command = f"bash {convert_windows_path_to_linux(BASE_DIR)}/download_artifact.sh {file_id}"
        download = subprocess.Popen(bash_command, shell=True, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

        # Create a thread to read and print the subprocess output
        def print_output():
            while True:
                output = download.stdout.readline()
                if not output:
                    break
                print(output.strip())

        # Start the thread
        output_thread = threading.Thread(target=print_output)
        output_thread.start()

        # Wait for the subprocess to complete and get the return code
        return_code = download.wait()

    except Exception as err:
        print(f"[{get_time()}] [ERROR] {err}")
        exit(1)