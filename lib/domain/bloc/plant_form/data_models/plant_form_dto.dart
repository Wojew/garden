import 'package:meta/meta.dart';

import '../../../domain.dart';

class PlantFormDto {
  final Plant plant;

  const PlantFormDto({
    @required this.plant,
  }) : assert(plant != null);

  String get plantName => plant?.name;
}

class PlantFormInputDto extends PlantFormDto {
  final List<PlantType> plantTypes;

  const PlantFormInputDto({
    @required Plant plant,
    @required this.plantTypes,
  })  : assert(plantTypes != null),
        super(
          plant: plant,
        );
}

class PlantFormOutputDto extends PlantFormDto {
  const PlantFormOutputDto({
    @required Plant plant,
  }) : super(
          plant: plant,
        );
}
