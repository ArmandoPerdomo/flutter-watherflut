import 'package:flutter/material.dart';
import 'package:watherflut/core/common_ui/header_widget.dart';
import 'package:watherflut/core/constants/ui_constants.dart';
import 'package:watherflut/core/models/city.dart';
import 'package:watherflut/ui/cities/add_city_page.dart';
import 'package:watherflut/ui/cities/bloc/cities_bloc.dart';

class CitiesPage extends StatefulWidget {
  @override
  _CitiesPageState createState() => _CitiesPageState();
}

class _CitiesPageState extends State<CitiesPage> {

  final bloc = CitiesBloc("CitiesPage");

  @override
  void initState(){
    super.initState();
    bloc.refreshCitiesStore();
  }

  void handleFloatingPress(BuildContext context) async{
    await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => AddCityPage(),
        )
    );

    bloc.refreshCitiesStore();
  }

  Widget renderCitiesList() {
    if(bloc.citiesStore.isEmpty){
      return Text(
        "No tienes ciudades agregadas 😥",
        style: TextStyle(fontSize: 20),
      );
    }

    return ListView.builder(
        itemCount: bloc.citiesStore.length,
        itemBuilder: (context, index){
          final current = bloc.citiesStore[index];
          return CityItem(city: current,voidCallbackRefresh: () => bloc.refreshCitiesStore());
        }
    );
  }

  //void refresh() async { await bloc.refreshCitiesStore(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child){
        return  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => handleFloatingPress(context),
            backgroundColor: PRIMARY_COLOR,
          ),
          body: Padding(
            padding: const EdgeInsets.all(PADDING_PAGE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                HeaderWidget(title: 'Mis Ciudades'),
                Expanded(
                  child: Center(
                    child: renderCitiesList(),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

class CityItem extends StatelessWidget {

  final City city;
  final bloc = CitiesBloc("CityItem");
  final VoidCallback voidCallbackRefresh;

  CityItem({@required this.city, this.voidCallbackRefresh});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              city.title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20
              ),
            ),
            IconButton(
              icon: Icon(Icons.clear, color: Colors.red),
              onPressed: () async{
                await bloc.removeCity(city);
                voidCallbackRefresh();
              },
            )
          ],
        ),
      ),
    );
  }
}

