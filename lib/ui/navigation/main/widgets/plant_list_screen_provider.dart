import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ui.dart';

class PlantListScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocProvider<PlantListBloc>(
        create: (context) => PlantListBloc(
          plantRepository: PlantRepository(),
          plantTypeRepository: PlantTypeRepository(),
        ),
        child: PlantListScreen(),
      );
}
