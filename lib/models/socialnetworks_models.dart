import 'package:superdiva_radio/constants/config.dart'; // Asegúrate de importar config.dart

// Enlace a Twitter
final Uri? toTwitter = (Config.userTwitter.isNotEmpty)
    ? Uri(scheme: 'https', host: 'twitter.com', path: Config.userTwitter)
    : null;

// Enlace a Instagram
final Uri? toInstagram = (Config.userInstagram.isNotEmpty)
    ? Uri(scheme: 'https', host: 'instagram.com', path: Config.userInstagram)
    : null;

// Enlace a Facebook
final Uri? toFacebook = (Config.pageFacebook.isNotEmpty)
    ? Uri(scheme: 'https', host: 'facebook.com', path: Config.pageFacebook)
    : null;

// Enlace a YouTube
final Uri? toYoutube = (Config.userYoutube.isNotEmpty)
    ? Uri(scheme: 'https', host: 'youtube.com', path: Config.userYoutube)
    : null;

// Enlace a WhatsApp
final Uri? toWhatsapp = (Config.numWhatsapp.isNotEmpty)
    ? Uri(scheme: 'https', host: 'wa.me', path: Config.numWhatsapp)
    : null;

// Enlace al sitio web oficial
final Uri? toSite = (Config.site.isNotEmpty)
    ? Uri(scheme: 'https', host: Config.site, path: '/')
    : null;