# DashReel App Fix - Reels

## Bugs & My Fixes (Screen recording):
https://drive.google.com/drive/folders/1G_DZqFCG8KcajqpD5Nz1yrEOT8df_FRf?usp=sharing

## Bug
- Videos continue playing in the background even after closing the app.
- The app must be force killed to stop the video playback.

## Fixes
- I used WidgetsBindingObserver to manage the app lifecycle, pausing the video when the app was paused and resuming it when it resumed.
- Additionally, I used a global variable `_isAppPaused` to track whether the app is paused.
- Within the playVideo method, the video is played only when _isAppPaused is false.

```bash
 bool _isAppPaused=false;

 @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _isAppPaused=true;
      _pauseVideo(_currentIndex);
    }
    else if (state == AppLifecycleState.resumed) {
      _isAppPaused=false;
      _playVideo(_currentIndex);
    }
  }
```

## Play video

```bash
 void _playVideo(int index){
    if(playerController.value.isInitialized && !playerController.value.isPlaying && !_isAppPaused){
      setState(() {
        playerController.play();
      });
    }
  }
```



