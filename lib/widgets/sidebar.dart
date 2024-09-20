import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:superdiva_radio/constants/config.dart'; // Asegúrate de importar config.dart
import 'package:superdiva_radio/constants/language.dart';
import 'package:superdiva_radio/screens/about_screens.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/theme.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.only(
          top: 50,
        ),
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Image.asset(
              'assets/images/logo.png',
              width: 120,
              height: 120,
            ),
          ),
          const Divider(color: Colors.black54),
          const Divider(),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.circleInfo,
              color: AppTheme.headerColor,
            ),
            title: const Text(
              Language.aboutUs,
              style: TextStyle(fontSize: 17, color: AppTheme.headerColor),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AboutView()),
            ),
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.star,
              color: AppTheme.headerColor,
            ),
            title: const Text(
              Language.rateUs,
              style: TextStyle(fontSize: 17, color: AppTheme.headerColor),
            ),
            onTap: () {
              _launchURL(Config.linkStore); // Aquí usamos el linkStore de config.dart
            },
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.shareNodes,
              color: AppTheme.headerColor,
            ),
            title: const Text(
              Language.share,
              style: TextStyle(fontSize: 17, color: AppTheme.headerColor),
            ),
            onTap: () {
              Navigator.pop(context);
              Share.share('${Config.textShare}, ${Config.appNameScreen}, \n ${Config.linkStore}');
            },
          ),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.fileLines,
              color: AppTheme.headerColor,
            ),
            title: const Text(
              Language.privacyPolicy,
              style: TextStyle(fontSize: 17, color: AppTheme.headerColor),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const Markdown(
                    filename: 'assets/text/privacy_policy.md',
                  );
                },
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: const Text(
              Language.moreInformation,
              style: TextStyle(color: AppTheme.headerColor),
            ),
          ),
          const ListTile(
            leading: FaIcon(
              FontAwesomeIcons.whatsapp,
              color: AppTheme.headerColor,
            ),
            title: Text(
              Language.versonApp,
              style: TextStyle(fontSize: 15, color: AppTheme.headerColor),
            ),
            subtitle: Text(
              Config.numWhatsapp, // WhatsApp desde config.dart
              style: TextStyle(fontSize: 14, color: AppTheme.headerColor),
            ),
          ),
          const SizedBox(),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: const Text(
              '♥️ Developed by iHOSTcast Ltd',
              style: TextStyle(color: AppTheme.headerColor),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}