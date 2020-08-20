import 'package:flutter/material.dart';
import 'package:watherflut/ui/cities/bloc/cities_bloc.dart';
import 'package:watherflut/ui/cities/cities_page.dart';
import 'package:watherflut/ui/home/weather_widget.dart';

import 'empty_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void handleNavigatePress(BuildContext context) async{
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => CitiesPage(),
    ));

    bloc.refreshCitiesStore();
  }

  final CitiesBloc bloc = CitiesBloc("HomePage");

  @override
  void initState() {
    super.initState();
    bloc.refreshCitiesStore();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child) {
        return Scaffold(
            body: renderBody()
        );
      },
    );
  }

  Widget renderBody() {
    if(bloc.citiesStore.isEmpty){
      return EmptyWidget(onAddCityTap: () => handleNavigatePress(context));
    }

    bloc.validateAndUpdateCitiesStore();
    return WeatherWidget(
      cities: bloc.citiesStore,
      onAddCityTap: () => handleNavigatePress(context),
      initialCity: bloc.citiesStore[0],
    );
  }
}
