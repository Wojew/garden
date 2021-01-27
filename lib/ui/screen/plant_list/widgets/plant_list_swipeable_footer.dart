import 'package:flutter/material.dart';
import '../../../ui.dart';

class PlantListSwipeableFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) => CustomFooter(
        builder: (_, mode) => mode != LoadStatus.idle
            ? Center(
                child: Padding(
                  padding: EdgeInsets.all(Dimens.smallSpacing),
                  child: CircularProgressIndicator(),
                ),
              )
            : SizedBox.shrink(),
      );
}
