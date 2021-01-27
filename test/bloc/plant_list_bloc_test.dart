import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/domain/domain.dart';
import 'package:mockito/mockito.dart';

class MockPlantRepository extends Mock implements PlantRepository {}

class MockPlantTypeRepository extends Mock implements PlantTypeRepository {}

void main() {
  blocTest(
    'Emits [PlantListLoading, PlantListFetchEnded, PlantListIdle] when PlantListFetch called and list isEmpty',
    build: () {
      final mockPlantRepository = MockPlantRepository();
      when(mockPlantRepository.fetchPlantEntities()).thenAnswer(
        (_) async => generateEmptyPlantEntities(),
      );

      final mockPlantTypeRepository = MockPlantTypeRepository();
      when(mockPlantTypeRepository.fetchPlantTypes()).thenAnswer(
        (_) async => generatePlantTypes(),
      );
      return generatePlantListBloc(
        plantRepository: mockPlantRepository,
        plantTypeRepository: mockPlantTypeRepository,
      );
    },
    act: (bloc) => bloc.add(
      PlantListFetch(),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plants.isEmpty, true);
    },
    expect: [
      isA<PlantListLoading>(),
      isA<PlantListFetchEnded>(),
      isA<PlantListIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantListLoading, PlantListFetchEnded, PlantListIdle] when PlantListFetch called and list isNotEmpty',
    build: () {
      final mockPlantRepository = MockPlantRepository();
      when(mockPlantRepository.fetchPlantEntities()).thenAnswer(
        (_) async => generatePlantEntitiesForPage(),
      );

      final mockPlantTypeRepository = MockPlantTypeRepository();
      when(mockPlantTypeRepository.fetchPlantTypes()).thenAnswer(
        (_) async => generatePlantTypes(),
      );
      return generatePlantListBloc(
        plantRepository: mockPlantRepository,
        plantTypeRepository: mockPlantTypeRepository,
      );
    },
    act: (bloc) => bloc.add(
      PlantListFetch(),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plants.isNotEmpty, true);
    },
    expect: [
      isA<PlantListLoading>(),
      isA<PlantListFetchEnded>(),
      isA<PlantListIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantListLoading, PlantListFetchEnded, PlantListIdle] when PlantListFetchMore called and list isNotEmpty',
    build: () {
      final mockPlantRepository = MockPlantRepository();
      when(mockPlantRepository.fetchPlantEntities()).thenAnswer(
        (_) async => generatePlantEntitiesForPage(page: 2),
      );

      final mockPlantTypeRepository = MockPlantTypeRepository();
      when(mockPlantTypeRepository.fetchPlantTypes()).thenAnswer(
        (_) async => generatePlantTypes(),
      );
      return generatePlantListBloc(
        plantRepository: mockPlantRepository,
        plantTypeRepository: mockPlantTypeRepository,
      );
    },
    act: (bloc) => bloc.add(
      PlantListFetchMore(),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plants.isNotEmpty, true);
    },
    expect: [
      isA<PlantListLoading>(),
      isA<PlantListFetchEnded>(),
      isA<PlantListIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantListLoading, PlantListFetchEnded, PlantListIdle, PlantListLoading, PlantListFetchEnded, PlantListIdle] when PlantListFetch and then PlantListFetchMore were called and list length = 20',
    build: () {
      final mockPlantRepository = MockPlantRepository();
      when(mockPlantRepository.fetchPlantEntities()).thenAnswer(
        (_) async => generatePlantEntitiesForPage(),
      );
      when(mockPlantRepository.fetchPlantEntities(lastId: 10)).thenAnswer(
        (_) async => generatePlantEntitiesForPage(page: 2),
      );

      final mockPlantTypeRepository = MockPlantTypeRepository();
      when(mockPlantTypeRepository.fetchPlantTypes()).thenAnswer(
        (_) async => generatePlantTypes(),
      );
      return generatePlantListBloc(
        plantRepository: mockPlantRepository,
        plantTypeRepository: mockPlantTypeRepository,
      );
    },
    act: (bloc) => bloc
      ..add(
        PlantListFetch(),
      )
      ..add(
        PlantListFetchMore(),
      ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plants.length, 20);
    },
    expect: [
      isA<PlantListLoading>(),
      isA<PlantListFetchEnded>(),
      isA<PlantListIdle>(),
      isA<PlantListLoading>(),
      isA<PlantListFetchEnded>(),
      isA<PlantListIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantListLoading, PlantListFetchEnded, PlantListIdle, PlantListLoading, PlantListFetchEnded, PlantListIdle] when PlantListFetch and then PlantListFetchMore called and first page list length = 10, second page list length = 0, then isLoadMoreAvailable should be false',
    build: () {
      final mockPlantRepository = MockPlantRepository();
      when(mockPlantRepository.fetchPlantEntities()).thenAnswer(
        (_) async => generatePlantEntitiesForPage(),
      );
      when(mockPlantRepository.fetchPlantEntities(lastId: 10)).thenAnswer(
        (_) async => generateEmptyPlantEntities(),
      );

      final mockPlantTypeRepository = MockPlantTypeRepository();
      when(mockPlantTypeRepository.fetchPlantTypes()).thenAnswer(
        (_) async => generatePlantTypes(),
      );
      return generatePlantListBloc(
        plantRepository: mockPlantRepository,
        plantTypeRepository: mockPlantTypeRepository,
      );
    },
    act: (bloc) => bloc
      ..add(
        PlantListFetch(),
      )
      ..add(
        PlantListFetchMore(),
      ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plants.length, 10);
      expect(bloc.state.widgetData.isLoadMoreAvailable, false);
    },
    expect: [
      isA<PlantListLoading>(),
      isA<PlantListFetchEnded>(),
      isA<PlantListIdle>(),
      isA<PlantListLoading>(),
      isA<PlantListFetchEnded>(),
      isA<PlantListIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantListFormEditing] when PlantListOnPressAddPlant called, then plant and planTypes should be not null',
    build: () {
      final mockPlantTypeRepository = MockPlantTypeRepository();
      when(mockPlantTypeRepository.fetchPlantTypes()).thenAnswer(
        (_) async => generatePlantTypes(),
      );
      return generatePlantListBloc(
        plantTypeRepository: mockPlantTypeRepository,
      );
    },
    act: (bloc) => bloc.add(
      PlantListOnPressAddPlant(),
    ),
    verify: (bloc) {
      expect(bloc.state.plantFormInputDto.plant != null, true);
      expect(bloc.state.plantFormInputDto.plantTypes != null, true);
    },
    expect: [
      isA<PlantListFormEditing>(),
    ],
  );

  blocTest(
    'Emits [PlantListLoading, PlantListFetchEnded, PlantListIdle, PlantListFormEditing] when PlantListFetch and then PlantListOnPressPlant called, then plant and planTypes should be not null, list should be not empty',
    build: () {
      final mockPlantRepository = MockPlantRepository();
      when(mockPlantRepository.fetchPlantEntities()).thenAnswer(
        (_) async => generatePlantEntitiesForPage(),
      );

      final mockPlantTypeRepository = MockPlantTypeRepository();
      when(mockPlantTypeRepository.fetchPlantTypes()).thenAnswer(
        (_) async => generatePlantTypes(),
      );
      return generatePlantListBloc(
        plantRepository: mockPlantRepository,
        plantTypeRepository: mockPlantTypeRepository,
      );
    },
    act: (bloc) => bloc
      ..add(
        PlantListFetch(),
      )
      ..add(
        PlantListOnPressPlant(plantId: 1),
      ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plants.isNotEmpty, true);
      expect(bloc.state.plantFormInputDto.plant != null, true);
      expect(bloc.state.plantFormInputDto.plantTypes != null, true);
    },
    expect: [
      isA<PlantListLoading>(),
      isA<PlantListFetchEnded>(),
      isA<PlantListIdle>(),
      isA<PlantListFormEditing>(),
    ],
  );

  blocTest(
    'Emits [PlantListLoading, PlantListFetchEnded, PlantListIdle] when PlantListOnSearchPlant called and list length = 2',
    build: () {
      final mockPlantRepository = MockPlantRepository();
      when(mockPlantRepository.searchPlantEntities("1")).thenAnswer(
        (_) async => generateSearchPlantEntitiesForPage("1"),
      );

      final mockPlantTypeRepository = MockPlantTypeRepository();
      when(mockPlantTypeRepository.fetchPlantTypes()).thenAnswer(
        (_) async => generatePlantTypes(),
      );
      return generatePlantListBloc(
        plantRepository: mockPlantRepository,
        plantTypeRepository: mockPlantTypeRepository,
      );
    },
    act: (bloc) => bloc.add(
      PlantListOnSearchPlant(text: "1"),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plants.length, 2);
    },
    expect: [
      isA<PlantListLoading>(),
      isA<PlantListFetchEnded>(),
      isA<PlantListIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantListLoading, PlantListFetchEnded, PlantListIdle] when PlantListOnSearchPlant called and list is empty and isLoadMoreAvailable is false',
    build: () {
      final mockPlantRepository = MockPlantRepository();
      when(mockPlantRepository.searchPlantEntities("11")).thenAnswer(
        (_) async => generateSearchPlantEntitiesForPage("11"),
      );

      final mockPlantTypeRepository = MockPlantTypeRepository();
      when(mockPlantTypeRepository.fetchPlantTypes()).thenAnswer(
        (_) async => generatePlantTypes(),
      );
      return generatePlantListBloc(
        plantRepository: mockPlantRepository,
        plantTypeRepository: mockPlantTypeRepository,
      );
    },
    act: (bloc) => bloc.add(
      PlantListOnSearchPlant(text: "11"),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plants.isEmpty, true);
      expect(bloc.state.widgetData.isLoadMoreAvailable, false);
    },
    expect: [
      isA<PlantListLoading>(),
      isA<PlantListFetchEnded>(),
      isA<PlantListIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantListIdle] when PlantListFormEditingEnded called, when result plant is null',
    build: generatePlantListBloc,
    act: (bloc) => bloc.add(
      PlantListFormEditingEnded(
        plantFormOutputDto: null,
      ),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plants.isEmpty, true);
    },
    expect: [
      isA<PlantListIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantListLoading, PlantListSnackbar, PlantListIdle] when PlantListFormEditingEnded called with new plant',
    build: generatePlantListBloc,
    act: (bloc) => bloc.add(
      PlantListFormEditingEnded(
        plantFormOutputDto: PlantFormOutputDto(
          plant: Plant(
            id: 1,
            name: "1",
            type: PlantType(id: 2130, name: "alpines"),
            plantedAtTimestamp: 1,
          ),
        ),
      ),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plants.isNotEmpty, true);
    },
    expect: [
      isA<PlantListLoading>(),
      isA<PlantListSnackbar>(),
      isA<PlantListIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantListLoading, PlantListFetchEnded, PlantListIdle, PlantListLoading, PlantListSnackbar, PlantListIdle] when PlantListFormEditingEnded called with existing plant',
    build: () {
      final mockPlantRepository = MockPlantRepository();
      when(mockPlantRepository.fetchPlantEntities()).thenAnswer(
        (_) async => generatePlantEntitiesForPage(),
      );

      final mockPlantTypeRepository = MockPlantTypeRepository();
      when(mockPlantTypeRepository.fetchPlantTypes()).thenAnswer(
        (_) async => generatePlantTypes(),
      );
      return generatePlantListBloc(
        plantRepository: mockPlantRepository,
        plantTypeRepository: mockPlantTypeRepository,
      );
    },
    act: (bloc) => bloc
      ..add(
        PlantListFetch(),
      )
      ..add(
        PlantListFormEditingEnded(
          plantFormOutputDto: PlantFormOutputDto(
            plant: Plant(
              id: 1,
              name: "2",
              type: PlantType(id: 2130, name: "alpines"),
              plantedAtTimestamp: 2,
            ),
          ),
        ),
      ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plants[0].name, "2");
      expect(bloc.state.widgetData.plants[1].name, "2");
    },
    expect: [
      isA<PlantListLoading>(),
      isA<PlantListFetchEnded>(),
      isA<PlantListIdle>(),
      isA<PlantListLoading>(),
      isA<PlantListIdle>(),
    ],
  );
}

List<PlantEntity> generatePlantEntitiesForPage({
  int page = 1,
}) =>
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        .map<PlantEntity>(
          (i) => PlantEntity(
            id: i * page,
            name: "${i * page}",
            typeId: 2137,
            plantedAtTimestamp: i * page,
          ),
        )
        .toList();

List<PlantEntity> generateSearchPlantEntitiesForPage(
  String name, {
  int page = 1,
}) =>
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        .where((i) => i.toString().contains(name))
        .map<PlantEntity>(
          (i) => PlantEntity(
            id: i * page,
            name: "${i * page}",
            typeId: 2137,
            plantedAtTimestamp: i * page,
          ),
        )
        .toList();

List<PlantEntity> generateEmptyPlantEntities() => <PlantEntity>[];

List<PlantType> generatePlantTypes() => [
      PlantTypeEntity(id: 2130, name: "alpines"),
      PlantTypeEntity(id: 2131, name: "aquatic"),
      PlantTypeEntity(id: 2132, name: "bulbs"),
      PlantTypeEntity(id: 2133, name: "succulents"),
      PlantTypeEntity(id: 2134, name: "carnivorous"),
      PlantTypeEntity(id: 2135, name: "climbers"),
      PlantTypeEntity(id: 2136, name: "ferns"),
      PlantTypeEntity(id: 2137, name: "grasses"),
      PlantTypeEntity(id: 2138, name: "threes"),
    ].map((e) => PlantType.fromPlantTypeEntity(e)).toList();

PlantListBloc generatePlantListBloc({
  PlantRepository plantRepository,
  PlantTypeRepository plantTypeRepository,
}) =>
    PlantListBloc(
      plantRepository: plantRepository ?? MockPlantRepository(),
      plantTypeRepository: plantTypeRepository ?? MockPlantTypeRepository(),
    );
