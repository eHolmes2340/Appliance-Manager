import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';

//Function    :getImageFromGallery
//Description : This function will get the image from the gallery
Future<XFile?> getImageFromGallery() async {
  final ImagePicker _picker = ImagePicker();
  try {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      Logger().w('User canceled image selection');
    }
    return image;
  } catch (e) {
    Logger().e('Error getting image: $e');
    return null; // Explicitly return null on error
  }
}
