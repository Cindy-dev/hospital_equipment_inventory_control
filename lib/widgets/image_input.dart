import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final ValueChanged<String> onSelectImage;
  ImageInput({Key key, this.onSelectImage}) : super(key: key);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  Future<void> _showImageDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Change photo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Avenir',
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                          onPressed: () {
                            _pickImage(ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Take photo',
                            style:
                                TextStyle(fontFamily: 'Avenir', fontSize: 15),
                          ))),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: FlatButton(
                          onPressed: () {
                            _pickImage(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Choose photo',
                            style:
                                TextStyle(fontFamily: 'Avenir', fontSize: 15),
                          ))),
                  Container(
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                        onPressed: Navigator.of(context).pop,
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: Colors.deepOrangeAccent,
                              fontFamily: 'Avenir',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }

  Uint8List _bytesImage;
  File _storedImage;
  String storeBase64;
  Future _pickImage(ImageSource source) async {
    var imageFile = await ImagePicker.pickImage(source: source);

    List<int> imageBytes = imageFile.readAsBytesSync();
    print(imageBytes);
    final base64Image = base64Encode(imageBytes);
    print('String is');
    print(base64Image);
    setState(() {
      storeBase64 = base64Image;
      widget.onSelectImage(base64Image);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: CircleAvatar(
          backgroundColor: Colors.deepOrangeAccent,
          radius: 30,
          child: storeBase64 != null
              ? Image.memory(
                  base64Decode(storeBase64),
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Icon(
                  Icons.camera_enhance,
                  color: Colors.white,
                ),
        ),
        onTap: _showImageDialog,
      ),
    );
  }
}
