import 'package:cloud_firestore/cloud_firestore.dart';

class Config {
  static const appNameScreen = 'Superdiva Radio';
  static const appDescription = 'Mucic Radio Theme';
  
  // Instead of a static URL, we will fetch this from Firebase
  static String linkStream = '';

  static const linkStore =
      'https://apps.apple.com/us/app/superdiva-radio-online/id6448856659';
  static const textShare = 'Download the App!';
  static const autoplay = true;
  static const albumCover = true;

  static const userInstagram = 'superdivaradio';
  static const pageFacebook = 'superdivaradio';
  static const userTwitter = 'superdivaradio';
  static const userYoutube = '@superdivaradioonline4596';
  static const site = 'superdivaradio.com';
  static const numWhatsapp = '8564260201';

  static const admobIosAdUnit = '';
  static const admobAndroidAdUnit = '';

  // Fetch the radio stream URL from Firebase Firestore
  static Future<void> fetchLinkStream() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('config')
          .doc('radio')
          .get();
      if (snapshot.exists) {
        linkStream = snapshot.get('linkStream') as String;
      } else {
        print('No linkStream found in Firebase');
      }
    } catch (e) {
      print('Error fetching linkStream from Firebase: $e');
    }
  }
}