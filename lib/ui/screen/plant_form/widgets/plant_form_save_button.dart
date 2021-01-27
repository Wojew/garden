import 'package:flutter/material.dart';

import '../../../ui.dart';

class PlantFormSaveButton extends StatelessWidget {
  final Function() onPress;

  const PlantFormSaveButton({
    @required this.onPress,
  }) : assert(onPress != null);

  @override
  Widget build(BuildContext context) => BlocBuilder<PlantFormBloc, PlantFormState>(
        builder: (_, state) => RaisedButton(
          onPressed: state.widgetData.isSaveAvailable ? onPress : null,
          child: Text("Save"),
        ),
      );
}
