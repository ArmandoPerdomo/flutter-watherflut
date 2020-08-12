import 'package:flutter/material.dart';
import 'package:watherflut/core/constants/ui_constants.dart';

class HeaderWidget extends StatelessWidget {

  final String title;

  const HeaderWidget({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          color: PRIMARY_COLOR,
        ),
      ],
    );
  }
}
