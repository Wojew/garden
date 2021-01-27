import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garden/domain/domain.dart';
import 'package:mockito/mockito.dart';

class MockPlantRepository extends Mock implements PlantRepository {}

void main() {
  blocTest(
    'Emits [PlantFormStartingDataLoaded] when PlantFormLoadStartingData called when creating new plant, isSaveAvailable should be false, title should be "Add plant"',
    build: () => generatePlantFormBloc(
      plant: Plant.empty(),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.isSaveAvailable, false);
      expect(bloc.state.widgetData.title, "Add plant");
    },
    expect: [
      isA<PlantFormStartingDataLoaded>(),
    ],
  );

  blocTest(
    'Emits [PlantFormStartingDataLoaded] when PlantFormLoadStartingData called when opening existing plant, isSaveAvailable should be true, title should be "Update plant"',
    build: () => generatePlantFormBloc(
      plant: generatePlant(),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.isSaveAvailable, true);
      expect(bloc.state.widgetData.title, "Update plant");
    },
    expect: [
      isA<PlantFormStartingDataLoaded>(),
    ],
  );

  blocTest(
    'Emits [PlantFormStartingDataLoaded, PlantFormEditing, PlantFormIdle] when PlantFormUpdateName called - new plant, then updated name - isSaveAvailable should be false',
    build: () => generatePlantFormBloc(
      plant: Plant.empty(),
    ),
    act: (bloc) => bloc.add(
      PlantFormUpdateName(name: "name"),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.name, "name");
      expect(bloc.state.widgetData.isSaveAvailable, false);
    },
    expect: [
      isA<PlantFormStartingDataLoaded>(),
      isA<PlantFormEditing>(),
      isA<PlantFormIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantFormStartingDataLoaded, PlantFormEditing, PlantFormIdle] when PlantFormUpdateName called - editing plant, then removed name - isSaveAvailable should be false',
    build: () => generatePlantFormBloc(
      plant: generatePlant(),
    ),
    act: (bloc) => bloc.add(
      PlantFormUpdateName(name: ""),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.name, "");
      expect(bloc.state.widgetData.isSaveAvailable, false);
    },
    expect: [
      isA<PlantFormStartingDataLoaded>(),
      isA<PlantFormEditing>(),
      isA<PlantFormIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantFormStartingDataLoaded, PlantFormEditing, PlantFormIdle] when PlantFormUpdateType called - new plant, then updated type - isSaveAvailable should be false',
    build: () => generatePlantFormBloc(
      plant: Plant.empty(),
    ),
    act: (bloc) => bloc.add(
      PlantFormUpdateType(
        plantType: generatePlantType(),
      ),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.type.id, generatePlantType().id);
      expect(bloc.state.widgetData.isSaveAvailable, false);
    },
    expect: [
      isA<PlantFormStartingDataLoaded>(),
      isA<PlantFormEditing>(),
      isA<PlantFormIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantFormStartingDataLoaded, PlantFormEditing, PlantFormIdle] when PlantFormUpdateType called - editing plant, then changed type - isSaveAvailable should be true',
    build: () => generatePlantFormBloc(
      plant: generatePlant(),
    ),
    act: (bloc) => bloc.add(
      PlantFormUpdateType(
        plantType: generatePlantType(),
      ),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.type.id, generatePlantType().id);
      expect(bloc.state.widgetData.isSaveAvailable, true);
    },
    expect: [
      isA<PlantFormStartingDataLoaded>(),
      isA<PlantFormEditing>(),
      isA<PlantFormIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantFormStartingDataLoaded, PlantFormEditing, PlantFormDateUpdated, PlantFormIdle] when PlantFormEditingDateEnded called - new plant, then updated date - isSaveAvailable should be false',
    build: () => generatePlantFormBloc(
      plant: Plant.empty(),
    ),
    act: (bloc) => bloc.add(
      PlantFormEditingDateEnded(
        plantedAtTimestamp: 1,
      ),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plantedAtDate, DateHelper.format(1));
      expect(bloc.state.widgetData.isSaveAvailable, false);
    },
    expect: [
      isA<PlantFormStartingDataLoaded>(),
      isA<PlantFormEditing>(),
      isA<PlantFormDateUpdated>(),
      isA<PlantFormIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantFormStartingDataLoaded, PlantFormEditing, PlantFormDateUpdated, PlantFormIdle] when PlantFormEditingDateEnded called - existing plant, then updated date - isSaveAvailable should be true',
    build: () => generatePlantFormBloc(
      plant: generatePlant(),
    ),
    act: (bloc) => bloc.add(
      PlantFormEditingDateEnded(
        plantedAtTimestamp: 2,
      ),
    ),
    verify: (bloc) {
      expect(bloc.state.widgetData.plantedAtDate, DateHelper.format(2));
      expect(bloc.state.widgetData.isSaveAvailable, true);
    },
    expect: [
      isA<PlantFormStartingDataLoaded>(),
      isA<PlantFormEditing>(),
      isA<PlantFormDateUpdated>(),
      isA<PlantFormIdle>(),
    ],
  );

  blocTest(
    'Emits [PlantFormStartingDataLoaded, PlantFormEditingDate] when PlantFormOnPressDateField called',
    build: () => generatePlantFormBloc(
      plant: Plant.empty(),
    ),
    act: (bloc) => bloc.add(
      PlantFormOnPressDateField(),
    ),
    expect: [
      isA<PlantFormStartingDataLoaded>(),
      isA<PlantFormEditingDate>(),
    ],
  );

  blocTest(
    'Emits [PlantFormStartingDataLoaded, PlantFormLoading, PlantFormSaved] when PlantFormOnPressSave called, new plant saved',
    build: () {
      final mockPlantRepository = MockPlantRepository();
      when(mockPlantRepository.insertPlant(any)).thenAnswer(
        (_) async => 1,
      );
      return generatePlantFormBloc(
        plant: generatePlant(id: null),
        plantRepository: mockPlantRepository,
      );
    },
    act: (bloc) => bloc.add(
      PlantFormOnPressSave(),
    ),
    verify: (bloc) {
      expect(bloc.state.plantFormOutputDto.plant != null, true);
      expect(bloc.state.widgetData.isSaveAvailable, true);
    },
    expect: [
      isA<PlantFormStartingDataLoaded>(),
      isA<PlantFormLoading>(),
      isA<PlantFormSaved>(),
    ],
  );

  blocTest(
    'Emits [PlantFormStartingDataLoaded, PlantFormLoading, PlantFormSaved] when PlantFormOnPressSave called, existing plant saved',
    build: () {
      final mockPlantRepository = MockPlantRepository();
      when(mockPlantRepository.updatePlant(any)).thenAnswer(
        (_) async => Future,
      );
      return generatePlantFormBloc(
        plant: generatePlant(),
        plantRepository: mockPlantRepository,
      );
    },
    act: (bloc) => bloc.add(
      PlantFormOnPressSave(),
    ),
    verify: (bloc) {
      expect(bloc.state.plantFormOutputDto.plant != null, true);
      expect(bloc.state.widgetData.isSaveAvailable, true);
    },
    expect: [
      isA<PlantFormStartingDataLoaded>(),
      isA<PlantFormLoading>(),
      isA<PlantFormSaved>(),
    ],
  );
}

Plant generatePlant({int id = 1}) => Plant(
      id: id,
      name: "2",
      type: PlantType(id: 2130, name: "alpines"),
      plantedAtTimestamp: 2,
    );

PlantType generatePlantType() => PlantType(id: 2131, name: "aquatic");

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

PlantFormBloc generatePlantFormBloc({
  PlantRepository plantRepository,
  Plant plant,
}) =>
    PlantFormBloc(
      plantRepository: plantRepository ?? MockPlantRepository(),
      plantFormInputDto: PlantFormInputDto(
        plant: plant,
        plantTypes: generatePlantTypes(),
      ),
    );
