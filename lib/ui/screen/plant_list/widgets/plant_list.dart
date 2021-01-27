import 'package:flutter/material.dart';
import '../../../ui.dart';

class PlantList extends StatelessWidget {
  final Function(int plantId) onPressPlant;
  final RefreshController _refreshController;
  final Function() onPullToRefresh;
  final Function() onLoadMore;

  const PlantList({
    @required this.onPressPlant,
    @required RefreshController refreshController,
    @required this.onPullToRefresh,
    @required this.onLoadMore,
  })  : assert(
          onPressPlant != null &&
              refreshController != null &&
              onPullToRefresh != null &&
              onLoadMore != null,
        ),
        _refreshController = refreshController;

  @override
  Widget build(BuildContext context) => BlocBuilder<PlantListBloc, PlantListState>(
        builder: (_, state) => state.widgetData.isPlantListNotEmpty()
            ? _buildListView(state.widgetData.plants)
            : _buildPlaceholder(),
      );

  _buildPlaceholder() => _buildSwipeableView(
        PlantListPlaceholder(),
      );

  _buildSwipeableView(Widget child) => PlantListSwipeable(
        controller: _refreshController,
        onPullToRefresh: onPullToRefresh,
        onLoadMore: onLoadMore,
        child: child,
      );

  _buildListView(List<PlantListPlantWidgetData> plants) => _buildSwipeableView(
        ListView.builder(
          itemCount: plants.length,
          itemBuilder: (context, index) => PlantListItem(
            plant: plants[index],
            onPress: onPressPlant,
          ),
        ),
      );
}
