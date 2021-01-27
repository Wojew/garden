import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:meta/meta.dart';

import '../data.dart';

@Entity(tableName: 'plant_types')
class PlantTypeEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(nullable: false)
  final String name;

  const PlantTypeEntity({
    @required this.id,
    @required this.name,
  });

  @override
  List<Object> get props => [
        id,
        name,
      ];

  const PlantTypeEntity.withName(this.name) : id = null;

  PlantTypeEntity.fromPlant(PlantType plantType)
      : assert(plantType != null),
        id = plantType.id,
        name = plantType.name;
}
