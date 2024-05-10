// lib/utils/text_recognition_utils.dart
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

// Example mapping for brands
const Map<String, String> brandMapping = {
  'nike': 'Nike',
  'adidas': 'Adidas',
  'puma': 'Puma',
  'gucci': 'Gucci',
  'zara': 'Zara',
  'under armour': 'Under Armour',
  // Add more brands as necessary
};

Future<String> detectBrandFromText(XFile image) async {
  final InputImage inputImage = InputImage.fromFilePath(image.path);
  final TextRecognizer textRecognizer = TextRecognizer();

  final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
  textRecognizer.close();

  final List<String> detectedWords = [];
  for (TextBlock block in recognizedText.blocks) {
    for (TextLine line in block.lines) {
      detectedWords.add(line.text.toLowerCase());
    }
  }

  for (String word in detectedWords) {
    for (String keyword in brandMapping.keys) {
      if (word.contains(keyword)) {
        return brandMapping[keyword]!;
      }
    }
  }

  return '';
}
