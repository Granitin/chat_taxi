import 'dart:async';

import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class PlaySoundsWidget extends StatefulWidget {
  const PlaySoundsWidget({Key? key}) : super(key: key);

  @override
  State<PlaySoundsWidget> createState() => _PlaySoundsWidgetState();
}

class _PlaySoundsWidgetState extends State<PlaySoundsWidget> {
  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  final audios = <Audio>[
    Audio('assets/sounds/ding.mp3'),
  ];

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    //_subscriptions.add(_assetsAudioPlayer.playlistFinished.listen((data) {
    //  print('finished : $data');
    //}));
    //openPlayer();
    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      debugPrint('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      debugPrint('audioSessionId : $sessionId');
    }));

    // openPlayer();
  }

  // void openPlayer() async {
  //   await _assetsAudioPlayer.open(
  //     Playlist(audios: audios, startIndex: 0),
  //     showNotification: true,
  //     autoStart: true,
  //   );
  // }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    debugPrint('dispose');
    super.dispose();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ding'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  AssetsAudioPlayer.playAndForget(
                    Audio('assets/sounds/ding.mp3'),
                  );
                },
                child: const Text('play Ding'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
