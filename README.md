# Termux-X11-XFCE4-auto-installer

A shell script to automatically install XFCE4 and create a startup script for Termux.

> ⚡ **Native Performance:** Everything runs directly inside the native Termux environment **without PRoot, chroot, or Linux containers**.

---

# Important
- Install **Termux** and **Termux:X11** from official F-Droid or GitHub releases (do **NOT** use the Play Store version).

---

## What does the script do?

The installer runs sequentially inside native Termux and performs the following actions:

1. **Environment Setup & Repository Connection:**
   - Checks if the `x11-repo` package repository is enabled inside Termux. If not, installs it automatically.
   - Updates the native Termux package index (`pkg update`).

2. **Native Dependency Installation:**
   - Checks and installs **`xfce4`** (Desktop Environment built for Termux).
   - Checks and installs **`virglrenderer-android`** (Hardware-accelerated 3D graphics rendering support).

3. **Startup Script Generation (`wm.sh`):**
   - Automatically generates a standalone launcher script named `wm.sh` in your current Termux directory.
   - Configures key environment variables for native graphics acceleration (`DISPLAY`, `GALLIUM_DRIVER`, `MESA`).

4. **Automated Launch Routine (configured inside `wm.sh`):**
   - Cleans up any leftover processes from previous sessions (`xfce4`, `termux-x11`, `virgl`).
   - Starts the background `termux-x11` server.
   - Launches `virgl_test_server_android` for native 3D GPU acceleration.
   - Automatically opens the Android **Termux:X11** app.
   - Starts the **XFCE4** desktop session directly on your device.

5. **Finalization:**
   - Makes `wm.sh` executable (`chmod +x`).
   - After installation, the setup script is no longer needed and can be safely deleted.

5. **Finalization:**
   - Makes `wm.sh` executable (`chmod +x`).
   - After installation, the setup script is no longer needed and can be safely deleted.
