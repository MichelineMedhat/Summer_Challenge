import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:path/path.dart' as Path;
import 'package:summer_challenge/repositories/user_repository.dart';

import '../models/user.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({Key key, this.user}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserRepository userRepository= UserRepository() ;
  String extenstion;
  bool isImagePicked = false;
  Uint8List data;

  pickImage() async {
    var mediaData = await ImagePickerWeb.getImageInfo;
    extenstion = Path.extension(mediaData.fileName);
    if (mediaData != null) {
      setState(() {
        data = mediaData.data;
        isImagePicked = true;
        userRepository.updateProfilePicture(widget.user, data, widget.user.username, extenstion);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 100,
                backgroundImage: isImagePicked
                    ? MemoryImage(data)
                    : widget.user.profilePicture == null?AssetImage('assets/pp.png') :NetworkImage(widget.user.profilePicture)),
            Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () => pickImage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
