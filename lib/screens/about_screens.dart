import 'package:flutter/material.dart';
import 'package:superdiva_radio/constants/config.dart'; // Importa config para obtener el nombre y la descripción de la app
import 'package:superdiva_radio/constants/language.dart';
import 'package:superdiva_radio/constants/theme.dart';
import 'package:superdiva_radio/models/markdown_models.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    final spacing = MediaQuery.of(context).size.width * 0.08;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        elevation: 0.0,
        title: const Text(Language.aboutUs),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(spacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: spacing),
            _buildAbout(),
            _buildProfileContainer(),
            const SizedBox(height: 10),
            _buildDescriptionContainer(),
          ],
        ),
      ),
    );
  }

  Widget _buildAbout() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Image.asset(
        'assets/images/logo.png',
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProfileContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Column(
            children: <Widget>[
              Text(
                Config.appNameScreen, // Nombre de la app desde la configuración
                style: TextStyle(
                  color: AppTheme.aboutUsTitleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                Config.appDescription, // Descripción de la app desde la configuración
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.aboutUsDescriptionColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.aboutContainerBackgroundColor,
          ),
          child: MarkdownText(
            filename: 'assets/text/about.md', // Archivo Markdown para el contenido
            textStyle: TextStyle(
              color: AppTheme.aboutUsFontColor,
              fontSize: 16,
              height: 1.5,
              fontFamily: 'Custom', // Fuente personalizada si está disponible
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}