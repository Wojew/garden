import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain.dart';

abstract class PlantListEvent extends Equatable {
  const PlantListEvent();

  @override
  List<Object> get props => [];
}

class PlantListFetch extends PlantListEvent {}

class PlantListFetchMore extends PlantListEvent {}

class PlantListOnPressAddPlant extends PlantListEvent {}

class PlantListOnPressPlant extends PlantListEvent {
  final int plantId;
  const PlantListOnPressPlant({
    @required this.plantId,
  }) : assert(plantId != null);

  @override
  List<Object> get props => [plantId];
}

class PlantListOnSearchPlant extends PlantListEvent {
  final String text;
  const PlantListOnSearchPlant({
    @required this.text,
  }) : assert(text != null);

  @override
  List<Object> get props => [text];
}

class PlantListFormEditingEnded extends PlantListEvent {
  final PlantFormOutputDto plantFormOutputDto;
  const PlantListFormEditingEnded({
    @required this.plantFormOutputDto,
  });

  @override
  List<Object> get props => [plantFormOutputDto];
}
