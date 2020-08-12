import 'package:watherflut/core/models/city.dart';

abstract class CityRepository{
  Future<void> save(City city);
  Future<List<City>> getAll();
  Future<void> remove(int id);
}

