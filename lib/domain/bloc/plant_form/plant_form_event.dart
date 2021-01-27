import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain.dart';

abstract class PlantFormEvent extends Equatable {
  const PlantFormEvent();

  @override
  List<Object> get props => [];
}

class PlantFormLoadStartingData extends PlantFormEvent {}

class PlantFormUpdateName extends PlantFormEvent {
  final String name;

  const PlantFormUpdateName({
    @required this.name,
  }) : assert(name != null);

  @override
  List<Object> get props => super.props + [name];
}

class PlantFormUpdateType extends PlantFormEvent {
  final PlantType plantType;

  const PlantFormUpdateType({
    @required this.plantType,
  }) : assert(plantType != null);

  @override
  List<Object> get props => super.props + [plantType];
}

class PlantFormOnPressSave extends PlantFormEvent {}

class PlantFormOnPressDateField extends PlantFormEvent {}

class PlantFormEditingDateEnded extends PlantFormEvent {
  final int plantedAtTimestamp;

  const PlantFormEditingDateEnded({
    @required this.plantedAtTimestamp,
  });

  @override
  List<Object> get props => super.props + [plantedAtTimestamp];
}
