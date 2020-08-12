import 'package:flutter/material.dart';
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
                    "Hola, \nBienvenido",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "¿Que te parece si agregamos \n una nueva ciudad?",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  RaisedButton(
                    onPressed: () => onAddCityTap(),
                    child: Text("Agregar Ciudad"),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}