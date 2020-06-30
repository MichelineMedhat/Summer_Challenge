import 'package:flutter/material.dart';

class ChallengeDialog extends StatefulWidget {
  final Function onPressed;
  static TextEditingController titleEditingController;
  static TextEditingController bodyEditingController;
  static TextEditingController hashtagEditingController;
  ChallengeDialog({Key key, this.onPressed}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChallengeDialogState();
}

class _ChallengeDialogState extends State<ChallengeDialog> {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0))),
      title: ListTile(
        title: Text(
          'Add Challenge',
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
              controller: ChallengeDialog.titleEditingController,
            ),
            TextField(
              controller: ChallengeDialog.bodyEditingController,
              minLines: 1,
              maxLines: 7,
            ),
            TextField(
              controller: ChallengeDialog.hashtagEditingController,
              decoration: InputDecoration(
                prefixText: '#',
              ),
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
    ChallengeDialog.titleEditingController.dispose();
    ChallengeDialog.bodyEditingController.dispose();
    ChallengeDialog.hashtagEditingController.dispose();
    super.dispose();
  }
}
