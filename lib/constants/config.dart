import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart'; // Importa Logger

class Config {
  static const appNameScreen = 'Superdiva Radio';
  static const appDescription = 'Tan Latina Como Tu.!!';

  // En lugar de una URL estática, obtendremos esto desde Firebase
  static String linkStream = '';

  static const linkStore =
      'https://apps.apple.com/us/app/superdiva-radio-online/id6448856659';
  static const textShare = 'Download the App!';
  static const autoplay = true;
  static const albumCover = true;

  // Redes Sociales
  static const String userTwitter = 'superdivaradio';
  static const String userInstagram = 'superdivaradio';
  static const String pageFacebook = 'superdivaradio';
  static const String userYoutube = '@superdivaradioonline4596';
  static const String numWhatsapp = '8564260201';
  static const String site = 'superdivaradio.com';

  // Admob IDs
  static const admobIosAdUnit = '';
  static const admobAndroidAdUnit = '';

  // Instancia de Logger
  static final Logger logger = Logger();

  // Obtiene la URL del stream de radio desde Firebase Firestore
  static Future<void> fetchLinkStream() async {
    try {
      // Obtiene el documento de la colección 'config' en Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('config')
          .doc('radio')
          .get();

      if (snapshot.exists) {
        // Obtiene el valor del campo 'linkStream'
        linkStream = snapshot.get('linkStream') as String;
        logger.i('linkStream fetched successfully: $linkStream');
      } else {
        logger.w('No linkStream found in Firebase');
      }
    } catch (e) {
      // Captura cualquier error que ocurra al intentar obtener la URL
      logger.e('Error fetching linkStream from Firebase', error: e);
    }
  }
}