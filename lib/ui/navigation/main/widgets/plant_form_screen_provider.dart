import 'package:flutter/material.dart';

import '../../../ui.dart';

class PlantFormScreenProvider extends StatelessWidget {
  final PlantFormInputDto plantFormInputDto;

  const PlantFormScreenProvider({
    @required this.plantFormInputDto,
  }) : assert(plantFormInputDto != null && plantFormInputDto is PlantFormInputDto);

  @override
  Widget build(BuildContext context) => BlocProvider<PlantFormBloc>(
        create: (context) => PlantFormBloc(
          plantFormInputDto: plantFormInputDto,
          plantRepository: PlantRepository(),
        ),
        child: PlantFormScreen(),
      );
}
