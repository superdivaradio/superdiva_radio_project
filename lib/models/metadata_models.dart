import 'dart:async';
import 'dart:convert';

import 'package:dart_common_utils/dart_common_utils.dart';
import 'package:firebase_database/firebase_database.dart'; // Firebase para la URL
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http; // Asegúrate de importar como http para evitar conflictos con otras librerías

// Configuración local
class MetadataService {
  MetadataService({
    required this.callback,
  });

  final Function(List<String>) callback;
  List<String>? _previousMetadata;
  Timer? _timer;
  late DatabaseReference metadataRef;

  // Inicializa Firebase para obtener la URL de metadatos desde Firebase Realtime Database
  Future<void> initFirebase() async {
    final DatabaseReference database = FirebaseDatabase.instance.ref();
    metadataRef = database.child('metadataUrl'); // Reemplaza con la ruta de la URL en Firebase
  }

  // Inicia el servicio de metadatos
  Future<void> start() async {
    await initFirebase();
    _timer = Timer.periodic(const Duration(seconds: 2), _parser);
  }

  // Detiene el servicio de metadatos
  void stop() => _timer?.cancel();

  // Parsea los metadatos desde la URL proporcionada por Firebase
  Future<void> _parser(Timer t) async {
    List<String> metadata = ['', '', ''];
    String title = '';

    try {
      // Obtiene la URL de los metadatos desde Firebase
      final DataSnapshot snapshot = await metadataRef.get();
      final String metadataUrl = snapshot.value as String;

      // Obtiene los datos desde la URL de metadatos
      final http.Response response = await http.get(Uri.parse(metadataUrl));
      if (response.statusCode == 200) {
        final content = utf8.decode(response.bodyBytes);

        // Intenta decodificar los datos JSON y extraer la información
        try {
          var map = json.decode(content) as Map<String, dynamic>;
          map = map['now_playing']?['song'] ?? map;

          title = map['titleTag'] ?? '';
          metadata[0] = map['artist'] ?? '';
          metadata[1] = map['title'] ?? '';
          metadata[2] = map['thumb'] ?? '';
        } catch (_) {
          // En caso de que el JSON no sea válido, intenta extraer con las etiquetas
          title = content.betweenTag('titleTag');
          metadata[0] = content.betweenTag('artist');
          metadata[1] = content.betweenTag('title');
          metadata[2] = content.betweenTag('thumb');
        }

        // Divide el título si está en formato "Artista - Canción"
        if (title.isNotEmpty) {
          final titleList = title.split(' - ');
          metadata[0] = titleList[0];
          metadata[1] = (titleList.length > 1) ? titleList[1] : '';
        }

        // Si ambos campos están vacíos, no realiza cambios
        if (metadata[0].isEmpty && metadata[1].isEmpty) {
          return;
        }

        // Si no hay artista, asigna el nombre de la canción al campo del artista
        if (metadata[0].isEmpty) {
          metadata[0] = metadata[1];
          metadata[1] = '';
        }

        // Si no hay título de canción, asigna el nombre de la app como título
        if (metadata[1].isEmpty) {
          metadata[1] = 'Superdiva Radio'; // Usa el nombre de tu app
        }

        // Solo actualiza los metadatos si han cambiado
        if (!listEquals(metadata, _previousMetadata)) {
          _previousMetadata = metadata;
          callback(metadata); // Llama al callback con los nuevos metadatos
        }
      } else {
        // ignore: avoid_print
        print('Error al obtener los metadatos: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error al procesar los metadatos: $e');
    }
  }
}