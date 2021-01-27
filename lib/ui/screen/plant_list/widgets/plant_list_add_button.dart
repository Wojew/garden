import 'package:flutter/material.dart';

class PlantFormAddButton extends StatelessWidget {
  final Function() onPress;

  const PlantFormAddButton({
    @required this.onPress,
  }) : assert(onPress != null);

  @override
  Widget build(BuildContext context) => RaisedButton(
        onPressed: onPress,
        child: Text("+ Add plant"),
      );
}
