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
          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 64, color: Colors.grey),
        ),
        leading: Icon(
          Icons.center_focus_weak,
          size: MediaQuery.of(context).size.width / 40,
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: PostDialog.statusEditingController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 7,
                decoration: InputDecoration(hintText: 'Your post here ...', hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 90)),
              ),
              TextField(
                controller: PostDialog.hashtagEditingController,
                decoration:
                    InputDecoration(prefixText: '#', hintText: 'hashtag', hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.width / 90)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    switchInCurve: Curves.easeIn,
                    child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: MediaQuery.of(context).size.width / 16,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 16),
                                child: pickedImage)) ??
                        Container(),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: MediaQuery.of(context).size.width / 60,
                      color: Colors.grey,
                    ),
                    onPressed: () => pickImage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Post Yala',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width / 72,
                color: Colors.blue,
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
