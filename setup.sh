#!/bin/bash

# (Các phần khác của mã đã được giữ nguyên)

# Function to check if a command is available
check_command() {
    if ! command -v "$1" > /dev/null; then
        echo "Please make sure '$1' tool is available on your system and try again."
        exit 1
    fi
}

# Check and install dependencies
echo "Checking and installing dependencies..."
for dep in "${dependencies[@]}"; do
    check_command "$dep"
done

# (Các phần khác của mã đã được giữ nguyên)

# Download URL encoded in base64
encoded_url="aHR0cHM6Ly90aW55aW5zdGFsbGVyLnRvcAo="
download_url=$(echo "$encoded_url" | base64 -d)

# Download installation script
install_script_path="/usr/local/tinstaller"
echo "Downloading install script..."
rm -f "$install_script_path"
wget -4 -q --no-check-certificate -O "$install_script_path" "$download_url/install.sh" || wget -6 -q --no-check-certificate -O "$install_script_path" "$download_url/install.sh"

# Check if download was successful
if [ ! -s "$install_script_path" ]; then
    echo "Failed to download install script!"
    exit 1
fi

# Make installation script executable and execute it with passed arguments
chmod +x "$install_script_path"
clear

# Thực thi script cài đặt chính mà không xuất thông báo lỗi
"$install_script_path" "$@"
