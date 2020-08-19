import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:watherflut/core/models/city.dart';
import 'package:watherflut/ui/home/weather_details_widget.dart';

class WeatherWidget extends StatefulWidget {
  final List<City> cities;
  final VoidCallback onAddCityTap;
  City currentCity;
  ValueNotifier _currentPageNotifier;

  WeatherWidget(this.cities, this.onAddCityTap){
    currentCity = cities[0];
    _currentPageNotifier = ValueNotifier<int>(0);
  }

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Image.asset(
                'assets/background_states/${widget.currentCity.consolidatedWeather.first.weatherStateAbbr}.jpg',
                fit: BoxFit.fill
            )
        ),
        SafeArea(
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 370.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.add, color: Colors.white),
                          onPressed: () => widget.onAddCityTap()
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: (i){
                        setState((){
                          widget.currentCity = widget.cities[i];
                          widget._currentPageNotifier.value = i;
                        });
                      },
                      itemCount: widget.cities.length,
                      itemBuilder: (context, index) {
                        DateFormat format = DateFormat('EEEE dd MMMM yyyy');
                        final city = widget.cities[index];
                        final first = city.consolidatedWeather.first;
                        return Column(
                          children: <Widget>[
                            Text(
                              "${city.title}, ${city.parent.title}",
                              style: _getCommonTextStyle(35.0),
                              textAlign: TextAlign.center,
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
                            ),
                            Divider(color: Colors.white, height: 25),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Min Temp ❄', style: _getCommonTextStyle(15.0)),
                                    Text('${first.minTemp.toStringAsFixed(2)}°C', style: _getCommonTextStyle(15.0))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Max Temp 🌞', style: _getCommonTextStyle(15.0)),
                                    Text('${first.maxTemp.toStringAsFixed(2)}°C', style: _getCommonTextStyle(15.0))
                                  ],
                                ),
                              ].map((e) => Expanded(child: e)).toList(),
                            ),
                            const SizedBox(height: 50),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Text('Wind Dir', style: _getCommonTextStyle(15.0)),
                                    Text('${first.windDirection.toStringAsFixed(2)}°', style: _getCommonTextStyle(15.0))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Wind Dir Comp', style: _getCommonTextStyle(15.0)),
                                    Text('${first.windDirectionCompass}', style: _getCommonTextStyle(15.0))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text('Visibility', style: _getCommonTextStyle(15.0)),
                                    Text('${first.visibility.toStringAsFixed(2)} mi', style: _getCommonTextStyle(15.0))
                                  ],
                                ),
                              ].map((e) => Expanded(child: e)).toList(),
                            )
                          ],
                        );
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: AnimatedSmoothIndicator(
                      activeIndex: widget._currentPageNotifier.value,
                      count: widget.cities.length,
                      effect: WormEffect(
                        dotColor: Colors.white,
                        activeDotColor: Colors.black38
                      ),
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}