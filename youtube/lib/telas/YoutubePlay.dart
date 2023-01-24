import 'package:flutter/material.dart';
import 'package:flutter_youtube_view/flutter_youtube_view.dart';
import 'package:youtube/model/Video.dart';

class YoutubePlay extends StatefulWidget {
  Video video;

  YoutubePlay({Key? key, required this.video}) : super(key: key);

  @override
  State<YoutubePlay> createState() => _YoutubePlayState();
}

class _YoutubePlayState extends State<YoutubePlay>
    implements YouTubePlayerListener {
  FlutterYoutubeViewController? _controller;
  double _currentVideoSecond = 0.0;
  String _playerState = "";

  @override
  void onCurrentSecond(double second) {
    _currentVideoSecond = second;
  }

  @override
  void onError(String error) {
    print("onError error = $error");
  }

  @override
  void onReady() {
    print("onReady");
  }

  @override
  void onStateChange(String state) {
    setState(() {
      _playerState = state;
    });
  }

  @override
  void onVideoDuration(double duration) {
    print("onVideoDuration duration = $duration");
  }

  void _onYoutubeCreated(FlutterYoutubeViewController controller) {
    this._controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
            child: FlutterYoutubeView(
                onViewCreated: _onYoutubeCreated,
                listener: this,
                scaleMode: YoutubeScaleMode.none,
                params: YoutubeParam(
                  autoPlay: true,
                  videoId: widget.video.id!,
                  showUI: true,
                  startSeconds: 0.0,
                  showYoutube: false,
                  showFullScreen: true,
                ))));
  }
}
