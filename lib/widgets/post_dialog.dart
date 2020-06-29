import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:path/path.dart' as Path;

class PostDialog extends StatefulWidget {
  final Function onPressed;
  static TextEditingController statusEditingController;
  static TextEditingController hashtagEditingController;
  static String extenstion;
  static Uint8List data;

  PostDialog({Key key, this.onPressed}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostDialogState();
}

class _PostDialogState extends State<PostDialog> {
  Image pickedImage;

  bool isImagePicked = false;

  pickImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    PostDialog.extenstion = Path.extension(mediaData.fileName);
    if (mediaData != null) {
      setState(() {
        PostDialog.data = mediaData.data;
        pickedImage = Image.memory(PostDialog.data);
        isImagePicked = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    PostDialog.statusEditingController = new TextEditingController();
    PostDialog.hashtagEditingController = new TextEditingController();
    pickedImage = Image.asset('assets/pp.png');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: ListTile(
        title: Text(
          'Add Post',
          style: TextStyle(fontSize: 24),
        ),
        leading: Icon(
          Icons.center_focus_weak,
          size: 28,
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: PostDialog.statusEditingController,
              minLines: 1,
              maxLines: 7,
            ),
            TextField(
              controller: PostDialog.hashtagEditingController,
              decoration: InputDecoration(
                prefixText: '#',
              ),
            ),
            Row(
              children: [
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 100,
                        child: Container(
                          child: pickedImage,
                        ),
                      ) ??
                      Container(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: 30.0,
                    ),
                    onPressed: () => pickImage(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Post Yala',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
              )),
          onPressed: widget.onPressed,
        ),
      ],
    );
  }

  @override
  void dispose() {
    PostDialog.statusEditingController.dispose();
    PostDialog.hashtagEditingController.dispose();
    PostDialog.data = null;

    super.dispose();
  }
}
