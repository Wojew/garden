import 'dart:async';

import 'package:meta/meta.dart';

import '../../domain.dart';

class PlantListBloc extends Bloc<PlantListEvent, PlantListState> {
  final PlantListDataState _plantListDataState;
  final PlantRepository _plantRepository;
  final PlantTypeRepository _plantTypeRepository;

  PlantListBloc({
    @required PlantRepository plantRepository,
    @required PlantTypeRepository plantTypeRepository,
  })  : assert(plantRepository != null),
        _plantListDataState = PlantListDataState.empty(),
        _plantRepository = plantRepository,
        _plantTypeRepository = plantTypeRepository,
        super(
          _initialState(),
        );

  static PlantListInitial _initialState() => PlantListInitial(
        widgetData: PlantListDataState.empty().toPlantFormWidgetData(),
      );

  @override
  Stream<PlantListState> mapEventToState(
    PlantListEvent event,
  ) async* {
    if (event is PlantListFetch) {
      yield* _mapFetchListToState();
    } else if (event is PlantListFetchMore) {
      yield* _mapFetchMoreToState();
    } else if (event is PlantListOnPressAddPlant) {
      yield* _mapAddPlantToState();
    } else if (event is PlantListOnPressPlant) {
      yield* _mapOpenPlantToState(event);
    } else if (event is PlantListOnSearchPlant) {
      yield* _mapSearchPlantToState(event);
    } else if (event is PlantListFormEditingEnded) {
      yield* _mapFormEditingEndedToState(event);
    }
  }

  Stream<PlantListState> _mapAddPlantToState() async* {
    final plantTypes = await getPlantTypes();
    yield _formEditingState(
      Plant.empty(),
      plantTypes,
    );
  }

  Stream<PlantListState> _mapOpenPlantToState(PlantListOnPressPlant listOnPressPlant) async* {
    final plant = _plantListDataState.getPlantById(listOnPressPlant.plantId);
    final plantTypes = await getPlantTypes();
    if (plant == null) {
      yield _idleState();
    } else {
      yield _formEditingState(
        plant,
        plantTypes,
      );
    }
  }

  Stream<PlantListState> _mapFetchListToState() async* {
    yield _loadingState();

    _plantListDataState.maxItemsReached = false;
    _plantListDataState.plants.clear();

    try {
      final plantEntities = _plantListDataState.isSearchTextValid
          ? await _plantRepository.searchPlantEntities(
              _plantListDataState.searchText,
            )
          : await _plantRepository.fetchPlantEntities();

      await mapPlantEntitiesToPlants(
        plantEntities,
        (plants) {
          _plantListDataState.plants = plants;
        },
      );

      yield _fetchEndedState();
      yield _idleState();
    } on Exception {
      yield _fetchEndedState();
      yield _failureState();
    }
  }

  Stream<PlantListState> _mapFetchMoreToState() async* {
    yield _loadingState();

    if (_plantListDataState.maxItemsReached) {
      yield _idleState();
      return;
    }

    try {
      final plantEntities = _plantListDataState.isSearchTextValid
          ? await _plantRepository.searchPlantEntities(
              _plantListDataState.searchText,
              lastId: _plantListDataState.lastPlantId,
            )
          : await _plantRepository.fetchPlantEntities(
              lastId: _plantListDataState.lastPlantId,
            );

      await mapPlantEntitiesToPlants(
        plantEntities,
        (plants) {
          _plantListDataState.plants.addAll(plants);
        },
      );

      yield _fetchEndedState();
      yield _idleState();
    } on Exception {
      yield _fetchEndedState();
      yield _failureState();
    }
  }

  Stream<PlantListState> _mapSearchPlantToState(PlantListOnSearchPlant listOnSearchPlant) async* {
    _plantListDataState.searchText = listOnSearchPlant.text;
    add(PlantListFetch());
  }

  Stream<PlantListState> _mapFormEditingEndedToState(
      PlantListFormEditingEnded listFormEditingEnded) async* {
    final resultPlant = listFormEditingEnded?.plantFormOutputDto?.plant;

    if (resultPlant != null) {
      yield _loadingState();
      final plantIndex = _plantListDataState.getPlantIndexById(resultPlant.id);
      if (plantIndex >= 0) {
        if (_plantListDataState.isSearchTextValid &&
            !resultPlant.name.contains(_plantListDataState.searchText)) {
          _plantListDataState.plants.removeAt(plantIndex);
        } else {
          _plantListDataState.plants[plantIndex] = resultPlant;
        }
      } else {
        yield _snackbarState();
        if (!_plantListDataState.isSearchTextValid ||
            (_plantListDataState.isSearchTextValid &&
                resultPlant.name.contains(_plantListDataState.searchText))) {
          _plantListDataState.plants.insert(
            0,
            resultPlant,
          );
        }
      }
    }

    yield _idleState();
  }

  Future<List<PlantType>> getPlantTypes() => _plantTypeRepository.fetchPlantTypes();

  Future<void> mapPlantEntitiesToPlants(
    List<PlantEntity> plantEntities,
    Function(List<Plant>) onSuccessIfNotEmpty,
  ) async {
    if (plantEntities.isEmpty) {
      _plantListDataState.maxItemsReached = true;
    } else {
      final plantTypes = await getPlantTypes();
      final plants = plantEntities
          .where(
            (plantEntity) =>
                plantTypes.indexWhere((plantType) => plantEntity.typeId == plantType.id) >= 0,
          )
          .map(
            (plantEntity) => Plant.fromPlantEntity(
              plantEntity,
              plantTypes.firstWhere((plantType) => plantEntity.typeId == plantType.id),
            ),
          )
          .toList();

      onSuccessIfNotEmpty(plants);
    }
  }

  PlantListIdle _idleState() => PlantListIdle(
        widgetData: _plantListDataState.toPlantFormWidgetData(),
      );

  PlantListLoading _loadingState() => PlantListLoading(
        widgetData: _plantListDataState.toPlantFormWidgetData(),
      );

  PlantListFetchEnded _fetchEndedState() => PlantListFetchEnded(
        widgetData: _plantListDataState.toPlantFormWidgetData(),
      );

  PlantListSnackbar _snackbarState() => PlantListSnackbar(
        widgetData: _plantListDataState.toPlantFormWidgetData(),
      );

  PlantListFormEditing _formEditingState(
    Plant plant,
    List<PlantType> planTypes,
  ) =>
      PlantListFormEditing(
        widgetData: _plantListDataState.toPlantFormWidgetData(),
        plantFormInputDto: PlantFormInputDto(
          plant: plant,
          plantTypes: planTypes,
        ),
      );

  PlantListFailure _failureState() => PlantListFailure(
        errorMessage: "Cannot fetch list",
        widgetData: _plantListDataState.toPlantFormWidgetData(),
      );
}
