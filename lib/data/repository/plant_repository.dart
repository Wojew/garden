import '../data.dart';

class PlantRepository {
  static final PlantRepository _instance = PlantRepository._();

  factory PlantRepository() => _instance;

  PlantRepository._() : _plantDao = PlantDatabase().getPlantDao();

  final PlantDao _plantDao;

  Future<List<PlantEntity>> fetchPlantEntities({
    int lastId,
    int itemsOnPage = 10,
  }) async =>
      lastId != null
          ? await _plantDao.findPlantsAfter(lastId, itemsOnPage)
          : await _plantDao.findPlants(itemsOnPage);

  Future<List<PlantEntity>> searchPlantEntities(
    String name, {
    int lastId,
    int itemsOnPage = 10,
  }) async =>
      lastId != null
          ? await _plantDao.findPlantsWhichNameLikeAndAfter('%$name%', lastId, itemsOnPage)
          : await _plantDao.findPlantsWhichNameLike('%$name%', itemsOnPage);

  Future<int> insertPlant(
    Plant plant,
  ) async {
    final plantEntity = PlantEntity.fromPlant(plant);

    return _plantDao.insertPlant(plantEntity);
  }

  Future<void> updatePlant(
    Plant plant,
  ) async {
    final plantEntity = PlantEntity.fromPlant(plant);

    await _plantDao.updatePlant(plantEntity);
  }
}
