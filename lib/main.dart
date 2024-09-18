import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:superdiva_radio/constants/config.dart';
import 'package:superdiva_radio/models/admob_models.dart';
import 'package:superdiva_radio/models/player_models.dart';
import 'package:superdiva_radio/screens/about_screens.dart';
import 'package:superdiva_radio/screens/player_screens.dart';
import 'package:superdiva_radio/screens/sleeptimer_screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:superdiva_radio/services/config_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa Firebase
  runApp(MyApp());
}

  // Set device orientation to portrait only.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Initialize Admob service.
  await AdmobService.init();

  // Initialize player and timer view models.
  late final playerViewModel = PlayerScreenModel();
  late final timerViewModel = TimerProvider();

  // Initialize providers for dependency injection.
  final providers = [
    ChangeNotifierProvider<PlayerScreenModel>.value(value: playerViewModel),
    ChangeNotifierProxyProvider<PlayerScreenModel, TimerProvider>(
      create: (context) => timerViewModel,
      update: (context, playerViewModel, timerViewModel) =>
          timerViewModel!..onTimer = playerViewModel.pause,
    ),
  ];

  // Define routes for the app.
  final routes = {
    PlayerScreen.routeName: (_) => const PlayerScreen(),
    AboutView.routeName: (_) => const AboutView(),
    TimerView.routeName: (_) => const TimerView(),
  };

  // Fetch the link stream URL from Firebase and start the app.
  final linkStream = await ConfigService.getLinkStream();
  runApp(App(providers: providers, routes: routes, linkStream: linkStream));
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.providers,
    required this.routes,
    required this.linkStream,
  });

  final Map<String, Widget Function(dynamic)> routes;
  final List<SingleChildStatelessWidget> providers;
  final String linkStream;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Hide the debug banner.
        title: appNameScreen, // Use the app name from the config file.
        routes: routes, // Define the app routes.
      ),
    );
  }
}