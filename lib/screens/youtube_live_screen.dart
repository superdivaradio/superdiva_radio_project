import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeLiveScreen extends StatefulWidget {
  const YouTubeLiveScreen({Key? key}) : super(key: key);

  @override
  _YouTubeLiveScreenState createState() => _YouTubeLiveScreenState();
}

class _YouTubeLiveScreenState extends State<YouTubeLiveScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    const liveStreamUrl = 'UC_YY1UzwMARXJwGo4LwTDlw'; // ID del canal de YouTube
    _controller = YoutubePlayerController(
      initialVideoId: liveStreamUrl, // Inserta el ID del canal o video en vivo aquí
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
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
        title: const Text('Superdiva Radio Live'),
        backgroundColor: Colors.redAccent,
      ),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.redAccent,
      ),
    );
  }
}