import '../../../domain.dart';

class PlantFormDataState {
  Plant plant;
  final List<PlantType> plantTypes;

  PlantFormDataState.fromInputDto(PlantFormInputDto plantFormInputDto)
      : assert(plantFormInputDto != null),
        plant = plantFormInputDto.plant,
        plantTypes = plantFormInputDto.plantTypes;

  PlantFormOutputDto toPlantFormOutputDto() => PlantFormOutputDto(
        plant: plant,
      );

  PlantFormWidgetData toPlantFormWidgetData() => PlantFormWidgetData(
        isSaveAvailable: _isSaveAvailable(),
        name: plant.name,
        type: _type,
        plantedAtDate: _plantedAtDate,
        title: plant.id != null ? "Update plant" : "Add plant",
        plantTypes: plantTypes,
      );

  String get _plantedAtDate {
    final plantedAtTimestamp = plant.plantedAtTimestamp;
    if (plantedAtTimestamp == null) {
      return null;
    }
    return DateHelper.format(plantedAtTimestamp);
  }

  PlantType get _type => plant.type;

  updateId(int id) {
    plant = plant.copyWith(
      id: id,
    );
  }

  updateName(String name) {
    plant = plant.copyWith(
      name: name,
    );
  }

  updateType(PlantType type) {
    plant = plant.copyWith(
      type: type,
    );
  }

  updatePlantedAtTimestamp(int plantedAtTimestamp) {
    plant = plant.copyWith(
      plantedAtTimestamp: plantedAtTimestamp,
    );
  }

  bool _isSaveAvailable() => Validator.areValid(
        [
          plant.name,
          _plantedAtDate,
          _type.toString(),
        ],
      );
}
