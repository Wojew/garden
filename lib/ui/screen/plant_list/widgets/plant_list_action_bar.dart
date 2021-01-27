import 'package:flutter/material.dart';

import '../../../ui.dart';

class PlantListActionBar extends StatelessWidget {
  final Function(String) onChangedSearchText;
  final Function() onPressAddPlant;

  const PlantListActionBar({
    @required this.onChangedSearchText,
    @required this.onPressAddPlant,
  }) : assert(onChangedSearchText != null && onPressAddPlant != null);

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.all(Dimens.smallSpacing),
        child: Row(
          children: [
            Expanded(
              child: PlantListSearchTextField(
                onChangedSearchText: onChangedSearchText,
              ),
            ),
            HorizontalSpacing(),
            PlantFormAddButton(
              onPress: onPressAddPlant,
            ),
          ],
        ),
      );
}
