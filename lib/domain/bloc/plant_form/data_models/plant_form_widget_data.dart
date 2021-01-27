import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain.dart';

class PlantFormWidgetData extends Equatable {
  final bool isSaveAvailable;
  final String title;
  final String name;
  final PlantType type;
  final String plantedAtDate;
  final List<PlantType> plantTypes;

  const PlantFormWidgetData({
    @required this.isSaveAvailable,
    @required this.title,
    @required this.name,
    @required this.type,
    @required this.plantedAtDate,
    @required this.plantTypes,
  }) : assert(isSaveAvailable != null && plantTypes != null);

  @override
  List<Object> get props => [
        isSaveAvailable,
        title,
        name,
        type,
        plantedAtDate,
        plantTypes,
      ];
}
