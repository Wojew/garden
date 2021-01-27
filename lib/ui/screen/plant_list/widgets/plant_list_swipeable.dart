import 'package:flutter/material.dart';
import '../../../ui.dart';

class PlantListSwipeable extends StatelessWidget {
  final Widget child;
  final RefreshController _controller;
  final Function() onPullToRefresh;
  final Function() onLoadMore;

  const PlantListSwipeable({
    @required this.child,
    @required RefreshController controller,
    @required this.onPullToRefresh,
    @required this.onLoadMore,
  })  : assert(
          child != null && controller != null && onPullToRefresh != null && onLoadMore != null,
        ),
        _controller = controller;

  @override
  Widget build(BuildContext context) => BlocBuilder<PlantListBloc, PlantListState>(
        builder: (_, state) => SmartRefresher(
          controller: _controller,
          onRefresh: onPullToRefresh,
          onLoading: onLoadMore,
          enablePullUp: state.widgetData.isLoadMoreAvailable,
          header: PlantListSwipeableHeader(),
          footer: PlantListSwipeableFooter(),
          child: child,
        ),
      );
}
