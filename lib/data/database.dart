import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'data.dart';

part 'database.g.dart';

@Database(version: 1, entities: [PlantEntity, PlantTypeEntity])
abstract class AppDatabase extends FloorDatabase {
  PlantDao get plantDao;
  PlantTypeDao get plantTypeDao;
}

class PlantDatabase {
  AppDatabase database;

  static final PlantDatabase _instance = PlantDatabase._();

  factory PlantDatabase() => _instance;

  PlantDatabase._();

  Future<void> setup() async {
    database = await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
    final plantTypes = await getPlantTypeDao().findAllPlantTypes();
    final plantTypesToInsert = [
      "alpines",
      "aquatic",
      "bulbs",
      "succulents",
      "carnivorous",
      "climbers",
      "ferns",
      "grasses",
      "threes",
    ].where(
      (plantName) => plantTypes.indexWhere((plantType) => plantType.name == plantName) == -1,
    );
    await getPlantTypeDao().insertPlantTypes(
      plantTypesToInsert
          .map<PlantTypeEntity>(
            (name) => PlantTypeEntity.withName(name),
          )
          .toList(),
    );
  }

  PlantDao getPlantDao() {
    assert(database != null);
    return database.plantDao;
  }

  PlantTypeDao getPlantTypeDao() {
    assert(database != null);
    return database.plantTypeDao;
  }
}
