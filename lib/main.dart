import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:superdiva_radio/constants/config.dart';
import 'package:superdiva_radio/models/player_models.dart';
import 'package:superdiva_radio/screens/about_screens.dart';
import 'package:superdiva_radio/screens/player_screens.dart';
import 'package:superdiva_radio/screens/sleeptimer_screens.dart';
import 'package:superdiva_radio/services/admob_service.dart'; // Importa tu servicio de AdMob

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa Firebase
  await Firebase.initializeApp();

  // Obtiene la URL del stream desde Firebase
  await Config.fetchLinkStream();

  // Fija la orientación de la pantalla en vertical
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Inicializa el servicio de AdMob
  await AdmobService.init();

  // Inicializa los view models para el reproductor y el temporizador
  late final playerViewModel = PlayerScreenModel();
  late final timerViewModel = TimerProvider();

  // Proveedores de inyección de dependencias
  final providers = [
    ChangeNotifierProvider<PlayerScreenModel>.value(value: playerViewModel),
    ChangeNotifierProxyProvider<PlayerScreenModel, TimerProvider>(
      create: (context) => timerViewModel,
      update: (context, playerViewModel, timerViewModel) =>
          timerViewModel!..onTimer = playerViewModel.pause,
    ),
  ];

  // Define las rutas de la app
  final routes = {
    PlayerScreen.routeName: (_) => const PlayerScreen(),
    AboutView.routeName: (_) => const AboutView(),
    TimerView.routeName: (_) => const TimerView(),
  };

  runApp(App(providers: providers, routes: routes));
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.providers,
    required this.routes,
  });

  final Map<String, Widget Function(dynamic)> routes;
  final List<SingleChildStatelessWidget> providers;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Oculta el banner de debug
        title: Config.appNameScreen, // Usa el nombre de la app desde Config
        routes: routes, // Define las rutas de la aplicación
      ),
    );
  }
}