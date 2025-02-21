import 'package:image_picker/image_picker.dart';
import 'package:logger/web.dart';

//Function    :getImageFromGallery
//Description : This function will get the image from the gallery
Future<XFile?> getImageFromGallery() async
{
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  try {
    image = await _picker.pickImage(source: ImageSource.gallery);
  } catch (e) {
    Logger().e('Error getting image: $e');
  }
  return image!;
}