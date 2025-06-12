import 'package:translator/translator.dart';

class TranslatorService {
  static final GoogleTranslator _translator = GoogleTranslator();

  /// Translates [text] into the [targetLangCode] (e.g. 'tr', 'en', 'es')
  static Future<String> translateText(String text, String targetLangCode) async {
    try {
      final translation = await _translator.translate(text, to: targetLangCode);
      return translation.text;
    } catch (e) {
      return "Translation failed: $e";
    }
  }
}
