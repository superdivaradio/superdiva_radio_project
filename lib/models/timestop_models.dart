import 'dart:async';

import 'package:flutter/foundation.dart';

class SmartstopService {
  SmartstopService({
    required this.callback,
    required this.duration,
  });

  final VoidCallback callback;
  final Duration duration;
  Duration _elapsedTime = Duration.zero;
  final _tickInterval = const Duration(seconds: 1);
  Timer? _timer;

  /// Inicia el temporizador con un intervalo de 1 segundo.
  void start() {
    _timer?.cancel(); // Asegura que no haya un temporizador anterior activo.
    _timer = Timer.periodic(_tickInterval, _onTick);
  }

  /// Detiene el temporizador si está en ejecución.
  void stop() {
    _timer?.cancel();
    _elapsedTime = Duration.zero; // Reinicia el contador.
  }

  /// Controla los ticks del temporizador.
  void _onTick(Timer timer) {
    _elapsedTime += _tickInterval;

    // Cuando el tiempo transcurrido alcanza o supera la duración, ejecuta el callback y reinicia.
    if (_elapsedTime >= duration) {
      _elapsedTime = Duration.zero;
      timer.cancel();
      callback(); // Ejecuta la función pasada como callback.
    }
  }
}