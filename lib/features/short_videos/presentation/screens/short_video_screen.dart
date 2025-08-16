import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shawn/features/short_videos/model/short_video_model.dart';
import 'package:shawn/features/short_videos/presentation/widgets/short_video_widget.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ShortVideoScreen extends StatefulWidget {
  const ShortVideoScreen({super.key});

  @override
  State<ShortVideoScreen> createState() => _ShortVideoScreenState();
}

class _ShortVideoScreenState extends State<ShortVideoScreen> with WidgetsBindingObserver{

  final _controllers=<int,VideoPlayerController?>{};
  bool _isAppPaused=false;
  
  final _shortVideos=[
    ShortVideoModel(
        title: 'Drishyam 2',
        description: 'Drishyam 2 Epic dialogue Akshay khanna 😯😯',
        category: 'Thriller',
        videoLink: 'https://github.com/user-attachments/assets/e827b1a2-a06e-483b-b14a-88c067808dd2',
        posterImg: 'gIClWRv5OSe8rl5Koi0AeUcCZ9Z.jpg',
        likes: 31000
    ),

    ShortVideoModel(
        title: 'Golmaal Fun Unlimited',
        description: 'Friends Or Worse Enemies?😭 | Golmaal Fun Unlimited',
        category: 'Comedy',
        videoLink: 'https://github.com/user-attachments/assets/11a06972-50a2-4314-a451-dcf42fe7024d',
        posterImg: '3ubefqLk26Gy0lXCfGIu8hQrBak.jpg',
        likes: 5100000,
    ),
    ShortVideoModel(
        title: 'Drishyam',
        description: 'Nothing, just Gaitonde laying out plain facts 😂😎',
        category: 'Thriller',
        videoLink: 'https://github.com/user-attachments/assets/f67f8581-d77e-432a-86ad-0a095e7ce4dd',
        posterImg: 'gIClWRv5OSe8rl5Koi0AeUcCZ9Z.jpg',
        likes: 10100
    ),
    ShortVideoModel(
        title: 'Golmaal Fun Unlimited',
        description: 'Lucky\'s funny call with Gopal 😂 | Golmaal Returns',
        category: 'Comedy',
        videoLink: 'https://github.com/user-attachments/assets/a38047ca-af55-4948-84e9-45d40ebb928c',
        posterImg: '3ubefqLk26Gy0lXCfGIu8hQrBak.jpg',
        likes: 781000
    ),

  ];

  VideoPlayerController _playerController(String link)=> 
      VideoPlayerController.networkUrl(
        Uri.parse(link),
      )..setLooping(true);

  int _currentIndex=0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    for(int i=0;i<_shortVideos.length;i++){
      _controllers[i]=_playerController(_shortVideos[i].videoLink);
    }
    _initController(0);
    _initController(1);
  }

  void _initController(int index){
    if(_controllers[index]==null){
      _controllers[index]=_playerController(_shortVideos[index].videoLink);
    }
    final playerController= _controllers[index]!;

    if(!playerController.value.isInitialized){
      playerController.initialize().then((_){
        print('initialized $index');
        _playVideo(index);
      });
      print('init $index');
    }
  }

  void _playVideo(int index){
    final playerController= _controllers[index]!;
    if(playerController.value.isInitialized && !playerController.value.isPlaying && _currentIndex==index && !_isAppPaused){
      print('video Play $index');
      setState(() {
        playerController.play();
      });
    }
  }

  void _pauseVideo(int index){
    if(index>=0){
      final playerController= _controllers[index]!;
      playerController.pause();
    }
  }

  void _disposePlayer(int index){
    if(index>=0){
      _controllers[index]?.dispose();
      _controllers[index]=null;
      print('dispose $index');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: _controllers.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          print('page loaded $index');
          // return Text('data $index');
          final shortVideoModel= _shortVideos[index];
          return ShortVideoWidget(
            index: index,
            controller: _controllers[index]!,
            title: shortVideoModel.title,
            likes: shortVideoModel.likes,
            posterImg: shortVideoModel.posterImg,
            description: shortVideoModel.description,
            contentCategory: shortVideoModel.category,
          );
        },
        onPageChanged: (index){
          //if user scroll upwards
          if(index<_currentIndex && index>0){
            print('in $index');
            _initController(index-1);
          }
          if(index % 2==0){
            _disposePlayer(index-2);
          }
          if(index+1 <_controllers.length){
            //initializing next player
            _initController(index+1);
          }
          //pause the previous video before playing the new one
          _pauseVideo(_currentIndex);
          _currentIndex=index;
          _playVideo(index);
        },

      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _isAppPaused=true;
      _pauseVideo(_currentIndex);
    } else if (state == AppLifecycleState.resumed) {
      _isAppPaused=false;
      _playVideo(_currentIndex);
    }
  }


  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for(int i=_currentIndex-1; i<_controllers.length;i++){
      _disposePlayer(i);
    }
    super.dispose();
  }
}
