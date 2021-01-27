import 'package:garden/data/data.dart';
import 'package:test/test.dart';

void main() {
  AppDatabase appDatabase;
  PlantDao plantDao;
  PlantTypeDao plantTypeDao;

  setUp(() async {
    appDatabase = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
    plantDao = appDatabase.plantDao;
    plantTypeDao = appDatabase.plantTypeDao;
  });

  final plantEntities = generatePlantEntities();

  test('plants initially is empty', () async {
    final actual = await plantDao.findAllPlants();

    expect(actual, isEmpty);
  });

  test('plants types', () async {
    final actual = await plantTypeDao.findAllPlantTypes();

    expect(actual, isEmpty);
  });

  test(
    'insert plant types',
    () async {
      final plantTypes = generatePlantTypeEntities();
      await plantTypeDao.insertPlantTypes(plantTypes);

      final actual = await plantTypeDao.findAllPlantTypes();

      expect(actual, hasLength(plantTypes.length));
    },
  );

  test(
    'insert plant',
    () async {
      await plantDao.insertPlant(plantEntities.first);

      final actual = await plantDao.findAllPlants();

      expect(actual, hasLength(1));
    },
  );

  test(
    'update plant',
    () async {
      final plant = plantEntities[1];
      await plantDao.insertPlant(plant);
      final updatedPlant = PlantEntity(
        id: plant.id,
        name: "2222",
        typeId: plant.typeId,
        plantedAtTimestamp: plant.plantedAtTimestamp,
      );
      await plantDao.updatePlant(updatedPlant);

      final actual = await plantDao.findAllPlants();

      expect(actual.first, equals(updatedPlant));
    },
  );

  test('find plants with limit 1', () async {
    final actual = await plantDao.findPlants(1);

    expect(actual, hasLength(1));
  });

  test('find plants after id 2 with limit 10', () async {
    final actual = await plantDao.findPlantsAfter(2, 10);

    expect(actual, hasLength(1));
  });

  test('find plants with text "%1%" limit 10', () async {
    final actual = await plantDao.findPlantsWhichNameLike("%1%", 10);

    expect(actual, hasLength(1));
  });

  test('find plants with text "%2%" limit 10', () async {
    final actual = await plantDao.findPlantsWhichNameLike("%2%", 10);

    expect(actual, hasLength(1));
  });

  test('find plants with text "%3%" limit 10', () async {
    final actual = await plantDao.findPlantsWhichNameLike("%3%", 10);

    expect(actual, isEmpty);
  });

  test('find plants after id 10 with text "%1%" limit 10', () async {
    final plant = plantEntities[9];
    await plantDao.insertPlant(plant);
    final actual = await plantDao.findPlantsWhichNameLikeAndAfter("%1%", 10, 10);

    expect(actual, hasLength(1));
  });

  test('find plants after id with text "%2%" limit 10', () async {
    final actual = await plantDao.findPlantsWhichNameLikeAndAfter('%2%', 2, 10);

    expect(actual, isEmpty);
  });

  test('find plants after id with text "%3%" limit 10', () async {
    final actual = await plantDao.findPlantsWhichNameLikeAndAfter('%3%', 2, 10);

    expect(actual, isEmpty);
  });
}

List<PlantEntity> generatePlantEntities() => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    .map<PlantEntity>(
      (i) => PlantEntity(
        id: i,
        name: i.toString(),
        typeId: 2137,
        plantedAtTimestamp: i,
      ),
    )
    .toList();

List<PlantTypeEntity> generatePlantTypeEntities() => [
      PlantTypeEntity(id: 2130, name: "alpines"),
      PlantTypeEntity(id: 2131, name: "aquatic"),
      PlantTypeEntity(id: 2132, name: "bulbs"),
      PlantTypeEntity(id: 2133, name: "succulents"),
      PlantTypeEntity(id: 2134, name: "carnivorous"),
      PlantTypeEntity(id: 2135, name: "climbers"),
      PlantTypeEntity(id: 2136, name: "ferns"),
      PlantTypeEntity(id: 2137, name: "grasses"),
      PlantTypeEntity(id: 2138, name: "threes"),
    ];
