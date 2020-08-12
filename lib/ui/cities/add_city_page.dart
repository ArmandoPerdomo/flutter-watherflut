import 'package:flutter/material.dart';
import 'package:watherflut/core/common_ui/header_widget.dart';
import 'package:watherflut/core/common_ui/loader-widget.dart';
import 'package:watherflut/core/constants/ui_constants.dart';
import 'package:watherflut/core/models/base_city.dart';

import 'bloc/cities_bloc.dart';

class AddCityPage extends StatefulWidget {
  @override
  _AddCityPageState createState() => _AddCityPageState();
}

class _AddCityPageState extends State<AddCityPage> {
  final CitiesBloc bloc = CitiesBloc("AddCity");


  @override
  void initState() {
    super.initState();
    bloc.refreshCitiesStore();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: bloc,
      builder: (context, child){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(PADDING_PAGE),
            child: Column(
              children: <Widget>[
                HeaderWidget(title: 'Agregar Ciudad'),
                const SizedBox(height: 50),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: TextField(
                    onChanged: bloc.onChangedText,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[200],
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Buscar Ciudad'
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                if(bloc.citiesResult.isEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "No existen resultados 😅",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          "Prueba escribiendo el nombre de una ciudad",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                        itemCount: bloc.citiesResult.length,
                        itemBuilder: (context, index){
                          final city = bloc.citiesResult[index];
                          return ListTile(
                            title: Text(
                              city.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20
                              ),
                            ),
                            trailing: renderTrailingCityIcon(city),
                          );
                        }
                    ),
                  ),
                if(bloc.loading)
                  Center(
                    child: LoaderWidget(),
                  )
              ],
            ),
          ),
        );
      }
    );
  }

  IconButton renderTrailingCityIcon(BaseCity city) {
    bool contains = bloc.containsCity(city);
    if(!contains){
      return IconButton(
        icon: Icon(Icons.add, color: PRIMARY_COLOR),
        onPressed: () {
          bloc.addCity(city);
        },
      );
    }

    return IconButton(
      icon: Icon(Icons.check, color: Colors.green),
      onPressed: () {
        bloc.removeBaseCity(city);
      },
    );
  }
}
