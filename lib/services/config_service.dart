import 'package:cloud_firestore/cloud_firestore.dart';

class ConfigService {
  static Future<String> getLinkStream() async {
    try {
      // Accede a la colección 'config' en Firestore
      final doc = await FirebaseFirestore.instance
          .collection('config')
          .doc('radio')
          .get();

      // Devuelve el campo 'linkStream'
      return doc['linkStream'] ?? 'Default stream link';
    } catch (e) {
      return 'Default stream link';
    }
  }
}