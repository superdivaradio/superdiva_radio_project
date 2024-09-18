import 'dart:async';
import 'dart:convert';

import 'package:dart_common_utils/dart_common_utils.dart';
import 'package:firebase_database/firebase_database.dart'; // Firebase para la URL
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:superdiva_radio/constants/config.dart'; // Configuración local

class MetadataService {
  MetadataService({
    required this.callback,
  });

  Function(List<String>) callback;
  List<String>? _previousMetadata;
  Timer? _timer;
  late DatabaseReference metadataRef;

  // Inicializa Firebase para obtener la URL de metadatos desde la base de datos en Firebase
  Future<void> initFirebase() async {
    final DatabaseReference database = FirebaseDatabase.instance.ref();
    metadataRef = database.child('metadataUrl'); // Reemplaza con la ruta de la URL en Firebase
  }

  // Inicia el servicio de metadatos
  void start() async {
    await initFirebase();
    _timer = Timer.periodic(const Duration(seconds: 2), _parser);
  }

  // Detiene el servicio de metadatos
  void stop() => _timer?.cancel();

  // Parsea los metadatos desde la URL proporcionada por Firebase
  Future<void> _parser(Timer t) async {
    var metadata = ['', '', ''];
    var title = '';

    // Obtiene la URL de los metadatos desde Firebase
    final DataSnapshot snapshot = await metadataRef.get();
    final String metadataUrl = snapshot.value as String;

    // Obtiene los datos desde la URL de metadatos
    final response = await get(Uri.parse(metadataUrl));
    final content = utf8.decode(response.bodyBytes);

    try {
      var map = json.decode(content) as Map<String, dynamic>;

      map = map['now_playing']?['song'] ?? map;

      title = map['titleTag'] ?? '';
      metadata[0] = map['artist'] ?? '';
      metadata[1] = map['title'] ?? '';
      metadata[2] = map['thumb'] ?? '';
    } catch (_) {
      title = content.betweenTag('titleTag');
      metadata[0] = content.betweenTag('artist');
      metadata[1] = content.betweenTag('title');
      metadata[2] = content.betweenTag('thumb');
    }

    if (title.isNotEmpty) {
      final titleList = title.split(' - ');
      metadata[0] = titleList[0];
      metadata[1] = (titleList.length > 1) ? titleList[1] : '';
    }

    if (metadata[0].isEmpty && metadata[1].isEmpty) {
      return;
    }

    if (metadata[0].isEmpty) {
      metadata[0] = metadata[1];
      metadata[1] = '';
    }

    if (metadata[1].isEmpty) {
      metadata[1] = appNameScreen;
    }

    if (!listEquals(metadata, _previousMetadata)) {
      _previousMetadata = metadata;
      callback(metadata);
    }
  }
}