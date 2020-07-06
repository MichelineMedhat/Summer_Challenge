import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:path/path.dart' as Path;

class HouseDialog extends StatefulWidget {
  final Function onPressed;
  static TextEditingController playlistUriEditingController;
  static TextEditingController houseNameEditingController;
  static TextEditingController zoomLinkEditingController;
  static TextEditingController zoomDateEditingController;
  static TextEditingController releaseDateEditingController;
  static TextEditingController roomIdEditingController;
  static TextEditingController roomPasswordEditingController;

  static Uint8List data;
  static String extenstion;

  const HouseDialog({Key key, this.onPressed}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HouseDialogState();
}

class _HouseDialogState extends State<HouseDialog> {
  Image pickedImage;

  bool isImagePicked = false;

  pickImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    HouseDialog.extenstion = Path.extension(mediaData.fileName);
    if (mediaData != null) {
      setState(() {
        HouseDialog.data = mediaData.data;
        pickedImage = Image.memory(HouseDialog.data);
        isImagePicked = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    HouseDialog.playlistUriEditingController = TextEditingController();
    HouseDialog.houseNameEditingController = TextEditingController();
    HouseDialog.zoomLinkEditingController = TextEditingController();
    HouseDialog.zoomDateEditingController = TextEditingController();
    HouseDialog.releaseDateEditingController = TextEditingController();
    HouseDialog.roomIdEditingController = TextEditingController();
    HouseDialog.roomPasswordEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: ListTile(
        title: Text(
          'Add house',
          style: TextStyle(fontSize: 24),
        ),
        leading: Icon(
          Icons.center_focus_weak,
          size: 28,
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 200),
                    switchInCurve: Curves.easeIn,
                    child: Container(
                          width: 250,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                        color: Colors.black87,
                        size: 30.0,
                      ),
                      onPressed: () => pickImage(),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: HouseDialog.playlistUriEditingController,
                decoration: InputDecoration(hintText: 'Playlist URI'),
              ),
              TextField(
                controller: HouseDialog.houseNameEditingController,
                decoration: InputDecoration(
                  hintText: 'House Name',
                ),
              ),
              TextField(
                controller: HouseDialog.zoomLinkEditingController,
                decoration: InputDecoration(
                  hintText: 'Zoom Link',
                ),
              ),
              TextField(
                controller: HouseDialog.zoomDateEditingController,
                decoration: InputDecoration(
                  hintText: 'Zoom Date',
                ),
              ),
              TextField(
                controller: HouseDialog.releaseDateEditingController,
                decoration: InputDecoration(
                  hintText: 'Release Date',
                ),
              ),
              TextField(
                controller: HouseDialog.roomIdEditingController,
                decoration: InputDecoration(
                  hintText: 'room Id',
                ),
              ),
              TextField(
                controller: HouseDialog.roomPasswordEditingController,
                decoration: InputDecoration(
                  hintText: 'room password',
                ),
              ),
            ],
          ),
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
    HouseDialog.playlistUriEditingController.dispose();
    HouseDialog.houseNameEditingController.dispose();
    HouseDialog.zoomLinkEditingController.dispose();
    HouseDialog.zoomDateEditingController.dispose();
    HouseDialog.releaseDateEditingController.dispose();
    HouseDialog.roomIdEditingController.dispose();
    HouseDialog.roomPasswordEditingController.dispose();
    super.dispose();
  }
}
