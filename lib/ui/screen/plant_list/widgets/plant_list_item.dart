import 'package:flutter/material.dart';

import '../../../ui.dart';

class PlantListItem extends StatelessWidget {
  final PlantListPlantWidgetData plant;
  final Function(int plantId) onPress;

  const PlantListItem({
    @required this.plant,
    @required this.onPress,
  }) : assert(plant != null && onPress != null);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onPress(plant.id),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(Dimens.smallSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(plant.firstAndLastCharacterOfName),
                VerticalSpacing(),
                Text("Name: ${plant.name}"),
                VerticalSpacing(),
                Text("Type: ${plant.type}"),
                VerticalSpacing(),
                Text("Planted at: ${plant.plantedAtDate}"),
              ],
            ),
          ),
        ),
      );
}
