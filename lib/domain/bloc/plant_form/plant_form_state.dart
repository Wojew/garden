import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain.dart';

abstract class PlantFormState extends Equatable {
  final PlantFormWidgetData widgetData;

  const PlantFormState({
    @required this.widgetData,
  }) : assert(widgetData != null);

  @override
  List<Object> get props => [widgetData];
}

class PlantFormInitial extends PlantFormState {
  const PlantFormInitial({
    PlantFormWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantFormStartingDataLoaded extends PlantFormState {
  const PlantFormStartingDataLoaded({
    PlantFormWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantFormLoading extends PlantFormState {
  const PlantFormLoading({
    PlantFormWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantFormIdle extends PlantFormState {
  const PlantFormIdle({
    PlantFormWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantFormEditing extends PlantFormState {
  const PlantFormEditing({
    PlantFormWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantFormEditingDate extends PlantFormState {
  const PlantFormEditingDate({
    PlantFormWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantFormDateUpdated extends PlantFormState {
  const PlantFormDateUpdated({
    PlantFormWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantFormSaved extends PlantFormState {
  final PlantFormOutputDto plantFormOutputDto;
  const PlantFormSaved({
    @required this.plantFormOutputDto,
    PlantFormWidgetData widgetData,
  })  : assert(plantFormOutputDto != null),
        super(
          widgetData: widgetData,
        );

  @override
  List<Object> get props => super.props + [plantFormOutputDto];
}

class PlantFormFailure extends PlantFormState {
  final String errorMessage;

  const PlantFormFailure({
    @required this.errorMessage,
    PlantFormWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );

  @override
  List<Object> get props => super.props + [errorMessage];
}
