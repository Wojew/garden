import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain.dart';

abstract class PlantListState extends Equatable {
  final PlantListWidgetData widgetData;

  const PlantListState({
    @required this.widgetData,
  }) : assert(widgetData != null);

  @override
  List<Object> get props => [widgetData];
}

class PlantListInitial extends PlantListState {
  const PlantListInitial({
    @required PlantListWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantListLoading extends PlantListState {
  const PlantListLoading({
    @required PlantListWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantListFetchEnded extends PlantListState {
  const PlantListFetchEnded({
    @required PlantListWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantListIdle extends PlantListState {
  const PlantListIdle({
    @required PlantListWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantListFormEditing extends PlantListState {
  final PlantFormInputDto plantFormInputDto;

  const PlantListFormEditing({
    @required PlantListWidgetData widgetData,
    @required this.plantFormInputDto,
  })  : assert(plantFormInputDto != null),
        super(
          widgetData: widgetData,
        );

  @override
  List<Object> get props => super.props + [plantFormInputDto];
}

class PlantListSnackbar extends PlantListState {
  const PlantListSnackbar({
    @required PlantListWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );
}

class PlantListFailure extends PlantListState {
  final String errorMessage;

  const PlantListFailure({
    @required this.errorMessage,
    PlantListWidgetData widgetData,
  }) : super(
          widgetData: widgetData,
        );

  @override
  List<Object> get props => super.props + [errorMessage];
}
