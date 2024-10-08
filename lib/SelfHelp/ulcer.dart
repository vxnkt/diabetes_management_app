import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class UlcerPage extends StatefulWidget {
  @override
  _UlcerPageState createState() => _UlcerPageState();
}

class _UlcerPageState extends State<UlcerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'I7W9XEeMuKQ', // The video ID from the provided URL
      flags: YoutubePlayerFlags(
        autoPlay: false, // Video doesn't autoplay
        mute: false,    // Video sound is not muted
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ulcer Library'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Welcome to the Ulcer Library!',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              print('Player is ready.');
            },
          ),
        ],
      ),
    );
  }
}
