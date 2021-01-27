import 'package:characters/src/extensions.dart';

import '../../../domain.dart';

class PlantListDataState {
  bool maxItemsReached;
  List<Plant> plants;
  String searchText;

  PlantListDataState.empty()
      : plants = <Plant>[],
        maxItemsReached = false;

  PlantListWidgetData toPlantFormWidgetData() => PlantListWidgetData(
        plants: plants
            .map(
              _toPlantWidgetData,
            )
            .toList(),
        isLoadMoreAvailable: isLoadMoreAvailable,
      );

  PlantListPlantWidgetData _toPlantWidgetData(Plant plant) => PlantListPlantWidgetData(
        id: plant.id,
        firstAndLastCharacterOfName: _plantFirstAndLastCharacterOfName(plant.name),
        name: plant.name,
        plantedAtDate: _plantPlantedAtDate(plant.plantedAtTimestamp),
        type: _plantType(plant.type),
      );

  String _plantFirstAndLastCharacterOfName(String name) =>
      name.characters.first + name.characters.last;

  String _plantPlantedAtDate(int plantedAtTimestamp) => DateHelper.format(plantedAtTimestamp);

  String _plantType(PlantType type) => type.toString();

  Plant getPlantById(int plantId) => plants.firstWhere(
        (plant) => plant.id == plantId,
        orElse: () => null,
      );

  int getPlantIndexById(int plantId) => plants.indexWhere((plant) => plant.id == plantId);

  int get lastPlantId => plants.isNotEmpty ? plants.last.id : null;

  bool get isLoadMoreAvailable => plants.isNotEmpty && !maxItemsReached;

  bool get isSearchTextValid => Validator.isValid(searchText);
}
