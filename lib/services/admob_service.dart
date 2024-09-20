import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  static Future<void> init() async {
    // Inicializa el SDK de Google Mobile Ads
    await MobileAds.instance.initialize();
  }

  // Método para mostrar un banner de ejemplo
  static final BannerAd banner = BannerAd(
    adUnitId: 'your-admob-unit-id',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  )..load();
}