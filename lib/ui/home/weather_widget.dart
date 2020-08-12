import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:watherflut/core/models/city.dart';
import 'package:watherflut/ui/home/weather_details_widget.dart';

class WeatherWidget extends StatelessWidget {

  void handleArrowPressed(BuildContext context, City city){
    showBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(45.0))
      ),
      context: context,
      builder: (_) {
        return WeatherDetailsWidget(city: city);
      }
    );
  }

  final List<City> cities;
  final VoidCallback onAddCityTap;

  WeatherWidget(this.cities, this.onAddCityTap);

  List<BoxShadow> _shadows = [
    BoxShadow(
        color: Colors.black38,
        offset: Offset(1.0, 1.0),
        blurRadius: 7.0,
        spreadRadius: 5.0
    )
  ];

  _getCommonTextStyle(double fontSize){
    return TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        shadows: _shadows
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          DateFormat format = DateFormat('HH:mm, EEEE dd MMMM yyyy');
          final city = cities[index];
          final first = city.consolidatedWeather.first;
          return Stack(
            children: <Widget>[
              Positioned.fill(
                  child: Image.asset(
                      'assets/background_states/${first.weatherStateAbbr}.jpg',
                      fit: BoxFit.fill
                  )
              ),
              SafeArea(
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 370.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: () => onAddCityTap()
                            ),
                            IconButton(
                                icon: Icon(Icons.more_vert, color: Colors.white),
                                onPressed: () {}
                            ),
                          ],
                        ),
                        const SizedBox(height: 80.0),
                        Text(
                          "${city.title}, ${city.parent.title}",
                          style: _getCommonTextStyle(35.0),
                        ),
                        Text(
                          format.format(first.applicableDate),
                          style: _getCommonTextStyle(15.0),
                        ),
                        const SizedBox(height: 80.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              first.theTemp.toInt().toString(),
                              style: _getCommonTextStyle(80.0),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "°C",
                                style: _getCommonTextStyle(25.0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Text(
                          first.weatherStateName,
                          style: _getCommonTextStyle(25.0),
                        ),
                        const SizedBox(height: 25),
                        IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.white,
                            size: 40,
                          ),
                          onPressed: () => handleArrowPressed(context, city),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        }
    );
  }
}