import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PlantListPlantWidgetData extends Equatable {
  final int id;
  final String firstAndLastCharacterOfName;
  final String name;
  final String type;
  final String plantedAtDate;

  const PlantListPlantWidgetData({
    @required this.id,
    @required this.firstAndLastCharacterOfName,
    @required this.name,
    @required this.type,
    @required this.plantedAtDate,
  }) : assert(
          id != null &&
              firstAndLastCharacterOfName != null &&
              name != null &&
              type != null &&
              plantedAtDate != null,
        );

  @override
  List<Object> get props => [
        id,
        firstAndLastCharacterOfName,
        name,
        type,
        plantedAtDate,
      ];
}
