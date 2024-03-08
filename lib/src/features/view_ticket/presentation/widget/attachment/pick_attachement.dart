import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

final fileProvider = Provider<Attachment>((ref) {
  return Attachment();
});

class Attachment {
  Future<String> addAttachment() async {
    try {
      //TODO: Change ti image gallery
      FilePickerResult? file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'png', 'jpeg'],
        allowCompression: false,
        withData: true,
        withReadStream: true,
      );

      if (file == null) {
        return "";
      }
      final pickedFile = File(file.files.single.path!);
      final appDir = await path_provider.getApplicationDocumentsDirectory();
      final localPath = path.join(appDir.path, pickedFile.path);
      return localPath;
    } on PlatformException catch (e) {
      throw e.toString();
    }
  }

  Future<String> pickImageFromGallery() async {
    final imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    try {
      log('image path ${image!.path}');
      return image.path;
    } catch (e) {
      log('error occur when picking from gallery ${e}');
      throw e.toString();
    }
  }
}
