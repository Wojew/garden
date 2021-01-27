import 'package:floor/floor.dart';

import '../data.dart';

@dao
abstract class PlantTypeDao {
  @Query('SELECT * FROM plant_types')
  Future<List<PlantTypeEntity>> findAllPlantTypes();

  @insert
  Future<void> insertPlantTypes(List<PlantTypeEntity> plantTypes);
}
