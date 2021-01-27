import 'package:flutter/material.dart';

import '../../../ui.dart';

class PlantFormAppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) => BlocBuilder<PlantFormBloc, PlantFormState>(
        builder: (_, state) => Text(state.widgetData.title),
      );
}
