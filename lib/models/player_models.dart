import 'package:firebase_database/firebase_database.dart'; // Para Firebase
import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';
import 'package:superdiva_radio/constants/config.dart';
import 'package:superdiva_radio/models/metadata_models.dart';
import 'package:superdiva_radio/models/timestop_models.dart';
import 'package:volume_regulator/volume_regulator.dart';

class PlayerScreenModel with ChangeNotifier {
  final _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  double volume = 0;
  Image? artwork;
  List<String>? metadata;
  MetadataService? _metadataService;
  SmartstopService? _smartstopService;

  String get artist => metadata?[0] ?? appNameScreen;
  String get track => metadata?[1] ?? appDescription;

  PlayerScreenModel() {
    _smartstopService = SmartstopService(
      callback: _radioPlayer.stop,
      duration: const Duration(seconds: 60),
    );

    // Activa el parser de carátulas de álbum de iTunes si es necesario
    if (albumCover) {
      _radioPlayer.itunesArtworkParser(true);
    }

    // Inicializa el servicio de volumen
    VolumeRegulator.getVolume().then((value) {
      volume = value.toDouble();
      notifyListeners();
    });

    VolumeRegulator.volumeStream.listen((value) {
      volume = value.toDouble();
      notifyListeners();
    });

    // Obtiene la URL de transmisión desde Firebase
    _initializeStreamUrl();
    
    // Escucha los cambios de metadatos
    _radioPlayer.metadataStream.listen((value) async {
      metadata = value;
      if (albumCover) artwork = await _radioPlayer.getArtworkImage();
      notifyListeners();
    });

    // Escucha el estado de reproducción (play/stop)
    _radioPlayer.stateStream.listen((state) {
      if (isPlaying == state) return;
      isPlaying = state;
      isPlaying ? _onPlay() : _onPause();
    });
  }

  // Inicializa la URL de transmisión desde Firebase
  Future<void> _initializeStreamUrl() async {
    final DatabaseReference dbRef = FirebaseDatabase.instance.ref('linkStream');
    final DataSnapshot snapshot = await dbRef.get();
    final String streamUrl = snapshot.value as String;

    _radioPlayer
        .setChannel(
            title: appNameScreen,
            url: streamUrl, // Utiliza la URL obtenida de Firebase
            imagePath: 'assets/images/logo.png')
        .then((_) {
      if (autoplay) play();
    });
  }

  // Reproducir la radio
  void play() {
    isPlaying = true;
    _radioPlayer.play();
    _onPlay();
  }

  // Pausar la radio
  void pause() {
    isPlaying = false;
    _radioPlayer.pause();
    _onPause();
  }

  // Lógica cuando se inicia la reproducción
  void _onPlay() {
    notifyListeners();
    _metadataService?.start();
    _smartstopService?.stop();
  }

  // Lógica cuando se pausa la reproducción
  void _onPause() {
    notifyListeners();
    _metadataService?.stop();
    _smartstopService?.start();
  }

  // Ajusta el volumen
  void setVolume(double value) {
    VolumeRegulator.setVolume(value.toInt());
    notifyListeners();
  }
}