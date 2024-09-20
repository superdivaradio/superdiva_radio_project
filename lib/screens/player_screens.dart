
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:superdiva_radio/constants/theme.dart';
import 'package:superdiva_radio/models/player_models.dart';
import 'package:superdiva_radio/models/socialnetworks_models.dart';
import 'package:superdiva_radio/screens/sleeptimer_screens.dart';
import 'package:superdiva_radio/widgets/sidebar.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  PlayerScreenState createState() => PlayerScreenState();
}

class PlayerScreenState extends State<PlayerScreen> {
  late final viewModel = Provider.of<PlayerScreenModel>(context, listen: true);
  double get padding => MediaQuery.of(context).size.width * 0.08;

  // Future para lanzar URLs en el navegador


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.barsStaggered,
                size: 35.0,
                color: AppTheme.iconSideBar,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.snooze,
              size: 35.0,
              color: AppTheme.iconSideBar,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TimerView()),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: const NavDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: <Widget>[
                    const Spacer(flex: 2),
                    _buildStreamCover(),
                    const SizedBox(height: 30),
                    Row(
                      children: <Widget>[
                        _buildStreamTitle(),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _buildVolumeSlider(),
                    const SizedBox(height: 20),
                    _socialNetwork(), // Rediseñado para corregir errores
                    const SizedBox(height: 30),
                    _buildControlButton(),
                    const SizedBox(height: 10),
                    // Aquí puedes añadir tu banner de anuncios, si lo tienes configurado.
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Imagen de la portada
  Widget _buildStreamCover() {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 250,
          maxWidth: 250,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: const [
            BoxShadow(
              color: AppTheme.artworkShadowColor,
              offset: AppTheme.artworkShadowOffset,
              blurRadius: AppTheme.artworkShadowRadius,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: viewModel.artwork ??
                Image.asset(
                  'assets/images/logo.png',
                  key: const ValueKey(1),
                  fit: BoxFit.cover,
                ),
          ),
        ),
      ),
    );
  }

  // Título y artista
  Widget _buildStreamTitle() {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              viewModel.artist,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppTheme.metadataColor,
              ),
            ),
            Text(
              viewModel.track,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.metadataColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Botón de control (Play/Pause)
  Widget _buildControlButton() {
    return ClipOval(
      child: Material(
        color: AppTheme.buttonPlay,
        child: InkWell(
          splashColor: AppTheme.buttonSplashColor,
          child: SizedBox(
            width: 80,
            height: 80,
            child: Icon(
              viewModel.isPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              size: 38,
              color: AppTheme.foregroundColor,
            ),
          ),
          onTap: () {
            viewModel.isPlaying ? viewModel.pause() : viewModel.play();
          },
        ),
      ),
    );
  }

  // Control de volumen
  Widget _buildVolumeSlider() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.volume_mute,
            color: AppTheme.iconVolume,
            size: 30,
          ),
          Flexible(
            child: SliderTheme(
              data: const SliderThemeData(
                thumbColor: AppTheme.thumbColor,
                activeTrackColor: AppTheme.activeColor,
                inactiveTrackColor: AppTheme.inactiveColor,
              ),
              child: Slider(
                value: viewModel.volume,
                min: 0,
                max: 100,
                divisions: 100,
                label: viewModel.volume.round().toString(),
                onChanged: (double value) {
                  viewModel.setVolume(value);
                },
              ),
            ),
          ),
          const Icon(
            Icons.volume_up,
            color: AppTheme.iconVolume,
            size: 30,
          ),
        ],
      ),
    );
  }

  // Redes sociales
  Widget _socialNetwork() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (toYoutube != null)
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.youtube,
                size: 35.0, color: AppTheme.socialColor),
            onPressed: () => setState(() {
            }),
          ),
        const SizedBox(width: 10),
        if (toInstagram != null)
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.instagram,
                size: 40.0, color: AppTheme.socialColor),
            onPressed: () => setState(() {
            }),
          ),
        const SizedBox(width: 10),
        if (toTwitter != null)
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.twitter,
                size: 40.0, color: AppTheme.socialColor),
            onPressed: () => setState(() {
            }),
          ),
        const SizedBox(width: 10),
        if (toFacebook != null)
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.facebook,
                size: 40.0, color: AppTheme.socialColor),
            onPressed: () => setState(() {
            }),
          ),
        const SizedBox(width: 10),
        if (toSite != null)
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.globe,
                size: 39.0, color: AppTheme.socialColor),
            onPressed: () => setState(() {
            }),
          ),
        const SizedBox(width: 10),
        if (toWhatsapp != null)
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.whatsapp,
                size: 40.0, color: AppTheme.socialColor),
            onPressed: () => setState(() {
            }),
          ),
      ],
    );
  }
}