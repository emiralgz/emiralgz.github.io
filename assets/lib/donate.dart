import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gezgin/utility/stringDict.dart';

class DonatePage extends StatelessWidget {
  final String selectedLang; // The language passed in

  const DonatePage({Key? key, required this.selectedLang}) : super(key: key);

  final String donationUrl = 'https://www.darussafaka.org/en/donation?c=donations';

  Future<void> _launchDonationUrl() async {
    final Uri url = Uri.parse(donationUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $donationUrl';
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://yt3.googleusercontent.com/bQUg_rskM5T0gOOvAboTs0L4aGZRMOVQOHJwFAmDTCkac4XZ6SbOMqaaFxCsq9JR4k0dTQOm=w2120-fcrop64=1,00005a57ffffa5a8-k-c0xffffffff-no-nd-rj',
              ),
              const SizedBox(height: 40),
              Text(stringDict[selectedLang]['donateText'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 60,
                child: ElevatedButton(
                  onPressed: _launchDonationUrl,
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(stringDict[selectedLang]['donate']),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
