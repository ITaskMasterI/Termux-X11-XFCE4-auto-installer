#!/data/data/com.termux/files/usr/bin/bash

# Error handling — stop execution if anything goes wrong
set -e

echo -e "\e[34m[=== Checking and configuring environment ===]\e[0m"

# 1. Check and enable x11-repo
if pkg list-installed 2>/dev/null | grep -q "x11-repo"; then
    echo -e "\e[32m[✓] Repository x11-repo is already enabled\e[0m"
else
    echo -e "\e[33m[*] Enabling x11-repo...\e[0m"
    pkg install -y x11-repo
fi

# Update package lists just in case
echo -e "\e[34m[*] Updating package lists...\e[0m"
pkg update -y

# Function to check and install packages
install_if_missing() {
    local package=$1
    if pkg list-installed 2>/dev/null | grep -q "^$package/"; then
        echo -e "\e[32m[✓] Package $package is already installed\e[0m"
    else
        echo -e "\e[33m[*] Installing package $package...\e[0m"
        pkg install -y "$package"
    fi
}

# 2. Check required packages
install_if_missing "xfce4"
install_if_missing "virglrenderer-android"

# 3. Self-creation of the wm.sh script
echo -e "\e[34m[*] Creating startup script wm.sh...\e[0m"

cat << 'EOF' > wm.sh
#!/data/data/com.termux/files/usr/bin/bash

# -------------------------
# ENV
# -------------------------
echo -e "\e[32mConfiguring environment\e[0m"
export DISPLAY=:0
export GALLIUM_DRIVER=virpipe
export MESA_GL_VERSION_OVERRIDE=4.3
export MESA_GLSL_VERSION_OVERRIDE=430

# -------------------------
# CLEANUP
# -------------------------
echo -e "\e[32mCleaning up leftover processes\e[0m"
pkill -f xfce4 || true
pkill -f termux-x11 || true
pkill -f virgl_test_server_android || true

sleep 0.5

# -------------------------
# START X SERVER
# -------------------------
echo -e "\e[32mStarting X11 server\e[0m"
termux-x11 :0 > /dev/null 2>&1 &

sleep 0.5

# -------------------------
# OPTIONAL GPU LAYER
# -------------------------
echo -e "\e[32mStarting graphics driver\e[0m"
virgl_test_server_android > /dev/null 2>&1 &

sleep 2

# -------------------------
# START Termux:X11 APP
# -------------------------
echo -e "\e[32mStarting Termux:X11\e[0m"
am start --user 0 -n com.termux.x11/.MainActivity > /dev/null 2>&1

sleep 0.5

# -------------------------
# DESKTOP
# -------------------------
echo -e "\e[32mStarting desktop environment\e[0m"
xfce4-session > /dev/null 2>&1

am start --user 0 -n com.termux/.HomeActivity > /dev/null 2>&1
echo -e "\e[32mScript execution completed\e[0m"
EOF

# 4. Set executable permissions
chmod +x wm.sh

echo -e "\e[32m[✓] Done! Script wm.sh successfully created and ready to use.\e[0m"
echo -e "To start the desktop environment, run: \e[36m./wm.sh\e[0m"
echo -e "\e[36minstall_wm.sh\e[0m is no longer needed and can be deleted"

