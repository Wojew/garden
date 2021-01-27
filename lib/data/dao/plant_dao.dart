import 'package:floor/floor.dart';

import '../data.dart';

@dao
abstract class PlantDao {
  @Query('SELECT * FROM plants ORDER BY id DESC')
  Future<List<PlantEntity>> findAllPlants();

  @Query('SELECT * FROM plants WHERE id < :lastId  ORDER BY id DESC LIMIT :itemsOnPage')
  Future<List<PlantEntity>> findPlantsAfter(
    int lastId,
    int itemsOnPage,
  );

  @Query('SELECT * FROM plants ORDER BY id DESC LIMIT :itemsOnPage')
  Future<List<PlantEntity>> findPlants(int itemsOnPage);

  @Query(
      'SELECT * FROM plants WHERE name LIKE :name AND id < :lastId ORDER BY id DESC LIMIT :itemsOnPage')
  Future<List<PlantEntity>> findPlantsWhichNameLikeAndAfter(
    String name,
    int lastId,
    int itemsOnPage,
  );

  @Query('SELECT * FROM plants WHERE name LIKE :name ORDER BY id DESC LIMIT :itemsOnPage')
  Future<List<PlantEntity>> findPlantsWhichNameLike(
    String name,
    int itemsOnPage,
  );

  @insert
  Future<int> insertPlant(PlantEntity plant);

  @update
  Future<void> updatePlant(PlantEntity plant);
}
