import 'package:flutter/material.dart';

import '../../../ui.dart';

class PlantFormDateField extends StatelessWidget {
  final TextEditingController _controller;
  final Function() onPress;

  const PlantFormDateField({
    @required TextEditingController controller,
    @required this.onPress,
  })  : assert(controller != null && onPress != null),
        _controller = controller;

  @override
  Widget build(BuildContext context) => BlocBuilder<PlantFormBloc, PlantFormState>(
        builder: (_, state) => GestureDetector(
          onTap: onPress,
          child: TextField(
            enabled: false,
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Date',
            ),
          ),
        ),
      );
}
