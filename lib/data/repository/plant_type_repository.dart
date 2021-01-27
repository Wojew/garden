import '../data.dart';

class PlantTypeRepository {
  static final PlantTypeRepository _instance = PlantTypeRepository._();

  factory PlantTypeRepository() => _instance;

  PlantTypeRepository._() : _plantTypeDao = PlantDatabase().getPlantTypeDao();

  final PlantTypeDao _plantTypeDao;

  Future<List<PlantType>> fetchPlantTypes() async {
    final plantTypeEntities = await _plantTypeDao.findAllPlantTypes();

    return plantTypeEntities
        .map(
          (plantTypeEntity) => PlantType.fromPlantTypeEntity(plantTypeEntity),
        )
        .toList();
  }

  Future<void> insertPlantTypes(
    List<PlantType> plantTypes,
  ) async {
    final plantTypeEntities = plantTypes
        .map(
          (plantType) => PlantTypeEntity.fromPlant(plantType),
        )
        .toList();

    return _plantTypeDao.insertPlantTypes(plantTypeEntities);
  }
}
