import 'package:image/image.dart' as im;
import 'dart:typed_data';

int HD_SIZE = 720;
int THUMBNAIL_SIZE = 60;

Uint8List compressImage(List<int> og, int size) {
  im.Image image = im.decodeImage(og);

  im.Image resizedImage = im.copyResize(image, size);

  return im.encodeJpg(resizedImage);
}