import 'package:flutter/material.dart';
import 'package:gezgin/utility/stringDict.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  final String selectedLang;

  const AboutPage({required this.selectedLang, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16), // rounded corners
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.network(
                  "https://pbs.twimg.com/profile_images/1920410241713238016/ETDZYSgg_400x400.jpg",
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      width: 150,
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),
            Text(
              stringDict[selectedLang]["aboutText"] ?? 'No content',
              style: const TextStyle(fontSize: 18),
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _launchUrl(
                          Uri.parse('https://www.youtube.com/@ifkoparan'),
                        );
                      },
                      icon: Icon(Icons.play_arrow),
                      label: Text('Youtube'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _launchUrl(
                          Uri.parse('https://www.instagram.com/ifkoparan/'),
                        );
                      },
                      icon: Icon(Icons.camera_alt),
                      label: Text('Instagram'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _launchUrl(Uri.parse('https://x.com/ifkoparan'));
                      },
                      icon: Icon(Icons.chat),
                      label: Text('X (Twitter)'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _launchUrl(Uri.parse('https://www.tiktok.com/@ifkoparan'));
                      },
                      icon: Icon(Icons.music_note_outlined),
                      label: Text('TikTok'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl(Uri _url) async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
