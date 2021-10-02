import 'package:flutter/material.dart';
import 'package:keepfit/app/common_widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
    required String assetName,
    required String text,
    Color? color,
    required Color textColor,
    required VoidCallback onPressed,
  })  : assert(assetName != null),
        assert(text != null),
        super(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(assetName),
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: 15.0),
            ),
            Opacity(
              opacity: 0.0,
              child: Image.asset(assetName),
            ),
          ],
        ),
        color: color,
        onPressed: onPressed,
      );
}
