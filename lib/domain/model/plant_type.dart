import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:meta/meta.dart';

import '../domain.dart';

@entity
class PlantType extends Equatable {
  @primaryKey
  final int id;
  final String name;

  const PlantType({
    @required this.id,
    @required this.name,
  }) : assert(id != null, name != null);

  @override
  List<Object> get props => [
        id,
        name,
      ];

  @override
  String toString() => name;

  PlantType.fromPlantTypeEntity(PlantTypeEntity plantTypeEntity)
      : assert(plantTypeEntity != null),
        id = plantTypeEntity.id,
        name = plantTypeEntity.name;
}
