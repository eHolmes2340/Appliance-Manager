import "package:firebase_storage/firebase_storage.dart";
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:logger/logger.dart';

//Function    : uploadImageToFirebaseStorage
//Description : This function uploads the image to firebase storage and returns the download URL
Future<String> uploadImageToFirebaseStorage(XFile imageFile) async{
  try
  {
      File file=File(imageFile.path);
      //Create a reference to firebase Storage
      FirebaseStorage storage=FirebaseStorage.instance;
      Reference ref=storage.ref().child("appliance_images/${DateTime.now().millisecondsSinceEpoch}");
 
    //upload Image 
    UploadTask uploadTask=ref.putFile(file);

    //Wait for the upload to complete and get the URL 

    TaskSnapshot taskSnapshot=await uploadTask;
    String downloadUrl=await taskSnapshot.ref.getDownloadURL();

    Logger().i('The download URL got sent to firebase: $downloadUrl'); 

    return downloadUrl; //This will be stored in the MySQL database. 
  }
  catch(e)
  {
    Logger().e(e); 
    return ''; 
  }
}