import 'package:superdiva_radio/constants/config.dart';

// Enlace a Twitter
final Uri toTwitter = Uri(
  scheme: 'https',
  host: 'twitter.com',
  path: userTwitter.isNotEmpty ? userTwitter : null,
);

// Enlace a Instagram
final Uri toInstagram = Uri(
  scheme: 'https',
  host: 'instagram.com',
  path: userInstagram.isNotEmpty ? userInstagram : null,
);

// Enlace a Facebook
final Uri toFacebook = Uri(
  scheme: 'https',
  host: 'facebook.com',
  path: pageFacebook.isNotEmpty ? pageFacebook : null,
);

// Enlace a YouTube
final Uri toYoutube = Uri(
  scheme: 'https',
  host: 'youtube.com',
  path: userYoutube.isNotEmpty ? userYoutube : null,
);

// Enlace a WhatsApp
final Uri toWhatsapp = Uri(
  scheme: 'https',
  host: 'wa.me',
  path: numWhatsapp.isNotEmpty ? numWhatsapp : null,
);

// Enlace al sitio web oficial
final Uri toSite = Uri(
  scheme: 'https',
  host: site.isNotEmpty ? site : null,
  path: '/',
);