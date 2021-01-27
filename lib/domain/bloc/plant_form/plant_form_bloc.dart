import 'dart:async';

import 'package:meta/meta.dart';

import '../../domain.dart';

class PlantFormBloc extends Bloc<PlantFormEvent, PlantFormState> {
  final PlantFormDataState _plantFormDataState;
  final PlantRepository _plantRepository;

  PlantFormBloc({
    @required PlantFormInputDto plantFormInputDto,
    @required PlantRepository plantRepository,
  })  : assert(plantFormInputDto != null && plantRepository != null),
        _plantFormDataState = PlantFormDataState.fromInputDto(plantFormInputDto),
        _plantRepository = plantRepository,
        super(
          _initialState(plantFormInputDto),
        ) {
    add(
      PlantFormLoadStartingData(),
    );
  }

  static PlantFormInitial _initialState(PlantFormInputDto plantFormInputDto) => PlantFormInitial(
        widgetData: PlantFormDataState.fromInputDto(plantFormInputDto).toPlantFormWidgetData(),
      );

  @override
  Stream<PlantFormState> mapEventToState(
    PlantFormEvent event,
  ) async* {
    if (event is PlantFormLoadStartingData) {
      yield* _mapLoadStartingDataToState();
    } else if (event is PlantFormUpdateName) {
      yield* _mapUpdateNameToState(event);
    } else if (event is PlantFormUpdateType) {
      yield* _mapUpdateTypeToState(event);
    } else if (event is PlantFormOnPressDateField) {
      yield* _mapEditingDateToState();
    } else if (event is PlantFormEditingDateEnded) {
      yield* _mapEditingDateEndedToState(event);
    } else if (event is PlantFormOnPressSave) {
      yield* _mapSavePlantToState();
    }
  }

  Stream<PlantFormState> _mapLoadStartingDataToState() async* {
    yield _startingDataLoadedState();
  }

  Stream<PlantFormState> _mapUpdateNameToState(PlantFormUpdateName plantFormUpdateName) async* {
    yield _editingState();
    _plantFormDataState.updateName(plantFormUpdateName.name);
    yield _idleState();
  }

  Stream<PlantFormState> _mapUpdateTypeToState(PlantFormUpdateType plantFormUpdateType) async* {
    yield _editingState();
    _plantFormDataState.updateType(plantFormUpdateType.plantType);
    yield _idleState();
  }

  Stream<PlantFormState> _mapEditingDateToState() async* {
    yield _editingDateState();
  }

  Stream<PlantFormState> _mapEditingDateEndedToState(
      PlantFormEditingDateEnded plantFormEditingDateEnded) async* {
    yield _editingState();
    _plantFormDataState.updatePlantedAtTimestamp(plantFormEditingDateEnded.plantedAtTimestamp);
    yield _dateUpdatedState();
    yield _idleState();
  }

  Stream<PlantFormState> _mapSavePlantToState() async* {
    yield _loadingState();
    try {
      final plant = _plantFormDataState.plant;
      if (plant.id == null) {
        final id = await _plantRepository.insertPlant(plant);
        _plantFormDataState.updateId(id);
      } else {
        await _plantRepository.updatePlant(plant);
      }
      yield _savedState();
    } on Exception {
      yield _failureState();
    }
  }

  PlantFormStartingDataLoaded _startingDataLoadedState() => PlantFormStartingDataLoaded(
        widgetData: _plantFormDataState.toPlantFormWidgetData(),
      );

  PlantFormFailure _failureState() => PlantFormFailure(
        errorMessage: "Save failed",
        widgetData: _plantFormDataState.toPlantFormWidgetData(),
      );

  PlantFormSaved _savedState() => PlantFormSaved(
        plantFormOutputDto: _plantFormDataState.toPlantFormOutputDto(),
        widgetData: _plantFormDataState.toPlantFormWidgetData(),
      );

  PlantFormLoading _loadingState() => PlantFormLoading(
        widgetData: _plantFormDataState.toPlantFormWidgetData(),
      );

  PlantFormIdle _idleState() => PlantFormIdle(
        widgetData: _plantFormDataState.toPlantFormWidgetData(),
      );

  PlantFormEditing _editingState() => PlantFormEditing(
        widgetData: _plantFormDataState.toPlantFormWidgetData(),
      );

  PlantFormEditingDate _editingDateState() => PlantFormEditingDate(
        widgetData: _plantFormDataState.toPlantFormWidgetData(),
      );

  PlantFormDateUpdated _dateUpdatedState() => PlantFormDateUpdated(
        widgetData: _plantFormDataState.toPlantFormWidgetData(),
      );
}
