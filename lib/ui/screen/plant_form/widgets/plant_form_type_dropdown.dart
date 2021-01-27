import 'package:flutter/material.dart';

import '../../../ui.dart';

class PlantFormTypeDropdown extends StatelessWidget {
  final Function(PlantType) onChanged;
  final Function() onPress;

  const PlantFormTypeDropdown({
    @required this.onChanged,
    @required this.onPress,
  }) : assert(onChanged != null && onPress != null);

  @override
  Widget build(BuildContext context) => BlocBuilder<PlantFormBloc, PlantFormState>(
        builder: (_, state) => DropdownButtonFormField<PlantType>(
          value: state.widgetData.type,
          items: state.widgetData.plantTypes
              .map<DropdownMenuItem<PlantType>>(
                (value) => DropdownMenuItem<PlantType>(
                  value: value,
                  child: Text(
                    value.toString(),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          onTap: onPress,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Type',
          ),
        ),
      );
}
