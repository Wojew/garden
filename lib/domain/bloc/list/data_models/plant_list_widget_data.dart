import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain.dart';

class PlantListWidgetData extends Equatable {
  final List<PlantListPlantWidgetData> plants;
  final bool isLoadMoreAvailable;

  const PlantListWidgetData({
    @required this.plants,
    @required this.isLoadMoreAvailable,
  }) : assert(plants != null && isLoadMoreAvailable != null);

  @override
  List<Object> get props => [
        plants,
        isLoadMoreAvailable,
      ];

  bool isPlantListNotEmpty() => plants.isNotEmpty;
}
