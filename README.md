## DashReel App Fix - Reels

# Bugs & My Fixes (Screen recording):
https://drive.google.com/drive/folders/1G_DZqFCG8KcajqpD5Nz1yrEOT8df_FRf?usp=sharing

# Bug
- Videos continue playing in the background even after closing the app.
- The app must be force killed to stop the video playback.

# Fixes
- I used WidgetsBindingObserver to manage the app lifecycle, pausing the video when the app was paused and resuming it when it resumed.
- Additionally, I used a global variable to track whether the app is paused.

