import 'package:shared_preferences/shared_preferences.dart';
import 'package:watherflut/core/models/city.dart';
import 'package:watherflut/core/repository/city/city_repository.dart';

class CityRepositoryImpl extends CityRepository{

  final _key = 'cities';

  @override
  Future<List<City>> getAll() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_key);
    if(raw == null || raw.isEmpty){
      return List<City>();
    }

    return raw.map((e) => City.fromJson(e)).toList();
  }

  @override
  Future<void> save(City city) async{
    final cities = await getAll();
    for(City item in cities){
      if(item.woeid == city.woeid) throw('Already saved');
    }
    cities.add(city);
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_key, cities.map((e) => e.toJson()).toList());
  }

  @override
  Future<void> remove(int id) async{
    final cities = await getAll();
    cities.removeWhere((city) => city.woeid == id);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(_key, cities.map((e) => e.toJson()).toList());
  }

}