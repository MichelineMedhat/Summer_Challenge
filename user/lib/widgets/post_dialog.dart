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
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: ListTile(
        title: Text(
          'Add Post',
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width > 576
                  ? MediaQuery.of(context).size.width / 64
                  : MediaQuery.of(context).size.width / 20,
              color: Colors.white),
        ),
        leading: Icon(
          Icons.center_focus_weak,
          size: MediaQuery.of(context).size.width > 576
              ? MediaQuery.of(context).size.width / 40
              : MediaQuery.of(context).size.width / 10,
          color: Colors.white,
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                  style: TextStyle(color: Colors.white),
                  controller: PostDialog.statusEditingController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 7,
                  decoration: InputDecoration(
                    hintText: 'Your post here ...',
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: MediaQuery.of(context).size.width > 576
                          ? MediaQuery.of(context).size.width / 90
                          : MediaQuery.of(context).size.width / 25,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  )),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: PostDialog.hashtagEditingController,
                decoration: InputDecoration(
                  prefixText: '#',
                  hintText: 'hashtag',
                  hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: MediaQuery.of(context).size.width > 576
                          ? MediaQuery.of(context).size.width / 90
                          : MediaQuery.of(context).size.width / 25),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
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
                            radius: MediaQuery.of(context).size.width > 576
                                ? MediaQuery.of(context).size.width / 16
                                : MediaQuery.of(context).size.width / 5,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width / 16),
                                child: pickedImage)) ??
                        Container(),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: MediaQuery.of(context).size.width > 576
                          ? MediaQuery.of(context).size.width / 60
                          : MediaQuery.of(context).size.width / 15,
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
                fontSize: MediaQuery.of(context).size.width > 576
                    ? MediaQuery.of(context).size.width / 72
                    : MediaQuery.of(context).size.width / 20,
                color: Colors.orange,
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
