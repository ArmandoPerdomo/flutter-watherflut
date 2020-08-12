import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:watherflut/core/models/city.dart';

class WeatherDetailsWidget extends StatelessWidget {

  final City city;

  const WeatherDetailsWidget({Key key, this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Text(
                'Pronóstico de ${city.consolidatedWeather.length} Días',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: city.consolidatedWeather.length,
                  itemBuilder: (context, index) {
                    final format = DateFormat('EEEE');
                    final weather = city.consolidatedWeather[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 45.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        '${format.format(weather.applicableDate)}',
                                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)
                                      ),
                                    ),
                                    SvgPicture.asset('assets/icon_states/${weather.weatherStateAbbr}.svg')
                                  ],
                                ),
                                Text('${weather.theTemp.toInt().toString()}°C ', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Column(
                              children: [
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(child: Text('Viento', textAlign: TextAlign.center)),
                                    Expanded(child: Text('Presión de Aire', textAlign: TextAlign.center)),
                                    Expanded(child: Text('Humedad', textAlign: TextAlign.center))
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(child: Text('${weather.windSpeed.toStringAsFixed(2)} mph', textAlign: TextAlign.center)),
                                    Expanded(child: Text('${weather.airPressure.toStringAsFixed(1)} mbar', textAlign: TextAlign.center)),
                                    Expanded(child: Text('${weather.humidity}%', textAlign: TextAlign.center))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
