import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String textKey;
  final VoidCallback onPressed;
  final bool outlined;

  RoundedButton({
    this.textKey,
    this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      splashColor: Theme.of(context).primaryColorLight,
      minWidth: 180.0,
      child: RaisedButton(
        color: outlined
            ? Theme.of(context).backgroundColor
            : Theme.of(context).primaryColor,
        textColor: Colors.white,
        textTheme: ButtonTextTheme.accent,
        elevation: 0,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          side: outlined
              ? BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2.5,
                  style: BorderStyle.solid,
                )
              : BorderSide.none,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 16.0,
          ),
          child: Text(
            textKey.toUpperCase(),
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: outlined
                    ? Theme.of(context).textTheme.button.color
                    : Colors.white),
          ),
        ),
      ),
    );
  }
}