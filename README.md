# Termux-X11-XFCE4-auto-installer

A shell script to automatically install XFCE4 and create a startup script for Termux.

> ⚡ **Native Performance:** Everything runs directly inside the native Termux environment **without PRoot, chroot, or Linux containers**, ensuring maximum speed and low resource usage.

---

# Important
- Install **Termux** and **Termux:X11** from official F-Droid or GitHub releases (do **NOT** use the Play Store version).

---

## What does the script do?

The installer runs sequentially inside native Termux and performs the following actions:

1. **Environment Setup & Repository Connection:**
   - Checks if the `x11-repo` package repository is enabled inside Termux. If not, installs it automatically[span_0](start_span)[span_0](end_span).
   - Updates the native Termux package index (`pkg update`)[span_1](start_span)[span_1](end_span).

2. **Native Dependency Installation:**
   - Checks and installs **`xfce4`** (Desktop Environment built for Termux)[span_2](start_span)[span_2](end_span).
   - Checks and installs **`virglrenderer-android`** (Hardware-accelerated 3D graphics rendering support)[span_3](start_span)[span_3](end_span).

3. **Startup Script Generation (`wm.sh`):**
   - Automatically generates a standalone launcher script named `wm.sh` in your current Termux directory[span_4](start_span)[span_4](end_span).
   - Configures key environment variables for native graphics acceleration (`DISPLAY`, `GALLIUM_DRIVER`, `MESA`)[span_5](start_span)[span_5](end_span).

4. **Automated Launch Routine (configured inside `wm.sh`):**
   - Cleans up any leftover processes from previous sessions (`xfce4`, `termux-x11`, `virgl`)[span_6](start_span)[span_6](end_span).
   - Starts the background `termux-x11` server[span_7](start_span)[span_7](end_span).
   - Launches `virgl_test_server_android` for native 3D GPU acceleration[span_8](start_span)[span_8](end_span).
   - Automatically opens the Android **Termux:X11** app[span_9](start_span)[span_9](end_span).
   - Starts the **XFCE4** desktop session directly on your device[span_10](start_span)[span_10](end_span).

5. **Finalization:**
   - Makes `wm.sh` executable (`chmod +x`)[span_11](start_span)[span_11](end_span).
   - After installation, the setup script is no longer needed and can be safely deleted[span_12](start_span)[span_12](end_span).
