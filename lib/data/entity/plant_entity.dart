import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:meta/meta.dart';

import '../data.dart';

@Entity(
  tableName: 'plants',
  foreignKeys: [
    ForeignKey(
      childColumns: ['type_id'],
      parentColumns: ['id'],
      entity: PlantTypeEntity,
    ),
  ],
)
class PlantEntity extends Equatable {
  @PrimaryKey(autoGenerate: true)
  final int id;

  @ColumnInfo(nullable: false)
  final String name;

  @ColumnInfo(name: 'type_id', nullable: false)
  final int typeId;

  @ColumnInfo(name: 'planted_at_timestamp', nullable: false)
  final int plantedAtTimestamp;

  const PlantEntity({
    @required this.id,
    @required this.name,
    @required this.typeId,
    @required this.plantedAtTimestamp,
  });

  @override
  List<Object> get props => [
        id,
        name,
        typeId,
        plantedAtTimestamp,
      ];

  PlantEntity.fromPlant(Plant plant)
      : assert(plant != null && plant.type != null),
        id = plant.id,
        name = plant.name,
        typeId = plant.type.id,
        plantedAtTimestamp = plant.plantedAtTimestamp;
}
