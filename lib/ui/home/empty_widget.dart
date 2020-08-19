import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:watherflut/core/constants/ui_constants.dart';


class EmptyWidget extends StatelessWidget {
  final VoidCallback onAddCityTap;

  const EmptyWidget({Key key, this.onAddCityTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Positioned.fill(
          child: Image.asset("assets/welcome.jpg", fit: BoxFit.fill),
        ),
        SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: MAX_PAGE_WIDTH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/logo.png",
                    height: 70,
                    width: 70,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Hello, \nWelcome",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "What if we start adding \na new city?",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  RaisedButton(
                    onPressed: () => onAddCityTap(),
                    child: Text("Add City"),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: RichText(
                        text: TextSpan(
                          text: 'By Armando \n',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final url = 'https://github.com/ArmandoPerdomo?tab=repositories';
                              if (await canLaunch(url)) {
                                await launch(
                                  url,
                                  forceSafariVC: false,
                                );
                              }
                            },
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              shadows: [
                                Shadow(
                                    blurRadius: 4.0,
                                    offset: Offset(2.0, 3.0),
                                    color: Colors.blue
                                )
                              ]
                          ),
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}