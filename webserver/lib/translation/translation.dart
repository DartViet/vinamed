import 'dart:convert';
import 'package:http/http.dart' as http;

class Translation {
  // Private constructor
  Translation._();

  // Static instance variable
  static final Translation _instance = Translation._();

  // Public accessor for the singleton instance
  static Translation get instance => _instance;

  Future<String> translateStringWithHttp(String textToTranslate, String targetLanguage) async {
    final apiKey = "AIzaSyDTzgqjonqwl9CUNtxjIo54Wm-9fspOyPI"; // Replace with your actual API key
    final sourceLanguage = "en"; // English
    final url = Uri.parse(
      'https://translation.googleapis.com/language/translate/v2?key=$apiKey&source=$sourceLanguage&target=$targetLanguage&q=${Uri.encodeComponent(textToTranslate)}',
    );

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final translatedText = jsonResponse['data']['translations'][0]['translatedText'];
        return translatedText;
      } else {
        print("HTTP error: ${response.statusCode}");
        throw Exception("Failed to translate text: ${response.statusCode}");
      }
    } catch (e) {
      print("Request error: $e");
      throw Exception("Failed to translate text");
    }
  }
}
