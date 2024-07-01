#!/bin/bash

VENVPATH="./venv"
CWD="$(pwd)"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

FILE_ID=$1

get_date() {
    echo "$(date "+%H:%M %z")"
}

cd "$SCRIPT_DIR"

# Check if virtual environment exists
if [ -d "$VENVPATH" ]; then
    echo "[$(get_date)] [OK] Virtual environment already exists."
else
    # Create virtual environment
    python --version &> /dev/null

    if [ $? -eq 0 ]; then
        python -m venv venv
    else 
        python3 -m venv venv
    fi
    
    echo "[$(get_date)] [OK] Virtual environment created."
fi

# Activate the virtual env
echo "[$(get_date)] [INFO] Activating virtual environment."
if [ -d "$SCRIPT_DIR/venv/bin" ]; then
    source "$SCRIPT_DIR/venv/bin/activate"
else
    source "$SCRIPT_DIR/venv/Scripts/activate"
fi

# If Gdown is not installed
if ! command -v gdown &> /dev/null; then
    echo "[$(get_date)] [INFO] Installing Gdown."
    pip install gdown --quiet --disable-pip-version-check

    gdown --version &> /dev/null # Checks if gdown was downloaded
    if [ $? -eq 0 ]; then
        echo "[$(get_date)] [OK] Gdown installed."
    else
        echo "[$(get_date)] [ERROR] Gdown failed to install."
        deactivate
        echo "[$(get_date)] [OK] Deactivated virtual environment."
        cd "$CWD"
        exit 1
    fi
fi

echo "[$(get_date)] [INFO] Starting download for file with id '$FILE_ID'."
gdown --id "$FILE_ID" &> /dev/null

if [ $? -eq 0 ]; then
    echo "[$(get_date)] [OK] File with id '$FILE_ID' successfully downloaded."
else
    echo "[$(get_date)] [ERROR] Download failed."
    deactivate
    echo "[$(get_date)] [OK] Deactivated virtual environment."
    cd "$CWD"
    return 1
fi

# Deactivate the virtual env
deactivate
echo "[$(get_date)] [OK] Deactivated virtual environment."

cd "$CWD"

