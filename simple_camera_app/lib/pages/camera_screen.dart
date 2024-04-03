import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

//create camera library page as stateful widget
class ImageLibraryPage extends StatefulWidget {
  const ImageLibraryPage({Key? key});

  @override
  State<ImageLibraryPage> createState() => _ImageLibraryPageState();
}

class _ImageLibraryPageState extends State<ImageLibraryPage> {
  //the library images are stored in the list bellow
  List<File> images = [];
  //initialize and load images from local storage
  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    //ask the OS for the directory assignes to this app
    final Directory appDir = await getApplicationDocumentsDirectory();
    final Directory imageDir = Directory('${appDir.path}/images');
    //check if image directory exists, else create
    if (!await imageDir.exists()) {
      //create images folder
      imageDir.createSync(recursive: true);
    }
    setState(() {
      //load images from folder
      images = imageDir.listSync().map((file) => File(file.path)).toList();
    });
  }
  //Used to take photos from camera and store them
  Future<void> _getImageFromCamera() async {
    final picker = ImagePicker();
    //open up camera and take picture, stored in the variable below
    final takenImage = await picker.pickImage(source: ImageSource.camera);
    if (takenImage == null) return;
    final File imageFile = File(takenImage.path);
    final Directory appDir = await getApplicationDocumentsDirectory();
    //define image name and storage directory
    final String imagePath =
        '${appDir.path}/images/${DateTime.now().millisecondsSinceEpoch}.png';
     //store image in the images folder
    imageFile.copySync(imagePath);
    setState(() {
      images.add(imageFile);
    });
  }
  //Delete image
  Future<void> _deleteImage(int index) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this image?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                //delete has been confirmed, delete image
                _deleteConfirmed(index);
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }
  //called after delete has been confirmed, deletes indicated image
  Future<void> _deleteConfirmed(int index) async {
    await images[index].delete();
    setState(() {
      //clear screen from deleted image
      images.removeAt(index);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Library'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: images.length,
        //check for taps and long presses on displayed image
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showFullScreenImage(index);
            },
            onLongPress: () {
                  _showOptions(index);
                },
            child: Hero(
              tag: 'image_$index',
              child: Image.file(images[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getImageFromCamera,
        tooltip: 'Take Picture',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
  //display popup menu with options 
  void _showOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet first
                _deleteImage(index); // Then call delete method
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel),
              title: const Text('Cancel'),
              onTap: () {               
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
  //display fullscreen image
  void _showFullScreenImage(int index) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(),
        body: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Hero(
              tag: 'image_$index',
              child: Image.file(images[index]),
            ),
          ),
        ),
      ),
    ),
  );
}
}
