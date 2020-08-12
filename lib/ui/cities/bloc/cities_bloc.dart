import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:watherflut/core/constants/data_constants.dart';
import 'package:watherflut/core/models/base_city.dart';
import 'package:watherflut/core/models/city.dart';
import 'package:watherflut/core/repository/city/city_repository_impl.dart';
import 'package:watherflut/core/util/debouncer.dart';

class CitiesBloc extends ChangeNotifier{
  final debouncer = Debouncer();
  List<BaseCity> citiesResult = [];
  List<City> citiesStore = [];
  bool loading = false;
  final repository = CityRepositoryImpl();
  String errorMessage;
  String instance;

  CitiesBloc(this.instance);

  void onChangedText(String text){
    debouncer.run(() {
      if(text.isNotEmpty){
        requestSearch(text);
      }
      else{
        citiesResult = [];
        notifyListeners();
      }
    });
  }

  void requestSearch(String text) async{
    loading = true;
    notifyListeners();

    final response = await get("$api/search/?query=$text");
    final data = jsonDecode(response.body) as List;
    citiesResult = data.map((e) => BaseCity.fromJson(e)).toList();
    loading = false;
    notifyListeners();
  }

  void addCity(BaseCity baseCity) async{
    loading = true;
    notifyListeners();

    final response = await get("$api/${baseCity.id}");
    final city = City.fromJson(response.body);

    try{
      errorMessage = null;
      await repository.save(city);
    }catch(ex){
      errorMessage = ex.toString();
      print(ex.toString());
    }

    loading = false;
    await refreshCitiesStore();
    notifyListeners();
  }

  Future<void> refreshCitiesStore() async{
    citiesStore = await repository.getAll();
    notifyListeners();
  }

  Future<void> removeBaseCity(BaseCity city) async{
    await repository.remove(city.id);
    await refreshCitiesStore();
    notifyListeners();
  }

  Future<void> removeCity(City city) async{
    await repository.remove(city.woeid);
    await refreshCitiesStore();
    notifyListeners();
  }

  bool containsCity(BaseCity city){
    for(City item in citiesStore){
      if(item.woeid == city.id) return true;
    }

    return false;
  }
}