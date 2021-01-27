import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../domain.dart';

class Plant extends Equatable {
  final int id;
  final String name;
  final PlantType type;
  final int plantedAtTimestamp;

  const Plant({
    @required this.id,
    @required this.name,
    @required this.type,
    @required this.plantedAtTimestamp,
  });

  const Plant.empty()
      : id = null,
        name = null,
        type = null,
        plantedAtTimestamp = null;

  Plant.fromPlantEntity(PlantEntity plantEntity, this.type)
      : assert(plantEntity != null && type != null),
        id = plantEntity.id,
        name = plantEntity.name,
        plantedAtTimestamp = plantEntity.plantedAtTimestamp;

  @override
  List<Object> get props => [
        id,
        name,
        type,
        plantedAtTimestamp,
      ];

  Plant copyWith({
    int id,
    String name,
    PlantType type,
    int plantedAtTimestamp,
  }) =>
      Plant(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        plantedAtTimestamp: plantedAtTimestamp ?? this.plantedAtTimestamp,
      );
}
