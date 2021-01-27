import 'package:flutter/material.dart';

import '../../ui.dart';

class PlantListScreen extends StatefulWidget {
  @override
  _PlantListScreenState createState() => _PlantListScreenState();
}

class _PlantListScreenState extends State<PlantListScreen> {
  final _refreshController = RefreshController();
  PlantListBloc _plantListBloc;

  @override
  void initState() {
    super.initState();
    _plantListBloc = BlocProvider.of<PlantListBloc>(context)
      ..add(
        PlantListFetch(),
      );
  }

  @override
  Widget build(BuildContext context) => BlocListener<PlantListBloc, PlantListState>(
        listener: _plantListBlocListener,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Garden"),
          ),
          body: SafeArea(
            child: Column(
              children: [
                PlantListActionBar(
                  onChangedSearchText: _onChangedSearchText,
                  onPressAddPlant: _onPressAddPlant,
                ),
                Expanded(
                  child: PlantList(
                    onPressPlant: _onPressPlant,
                    refreshController: _refreshController,
                    onPullToRefresh: _onPullToRefresh,
                    onLoadMore: _onLoadMore,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  _onPullToRefresh() => _plantListBloc.add(
        PlantListFetch(),
      );

  _onLoadMore() => _plantListBloc.add(
        PlantListFetchMore(),
      );

  _plantListBlocListener(context, state) {
    if (state is PlantListFormEditing) {
      _goToFormScreen(state);
    } else if (state is PlantListFetchEnded) {
      _hideListLoadings();
    } else if (state is PlantListSnackbar) {
      _showNewPlantAddedSnackbar();
    }
  }

  _onPressAddPlant() => _plantListBloc.add(
        PlantListOnPressAddPlant(),
      );

  _onPressPlant(int plantId) => _plantListBloc.add(
        PlantListOnPressPlant(
          plantId: plantId,
        ),
      );

  _onChangedSearchText(String text) => _plantListBloc.add(
        PlantListOnSearchPlant(
          text: text,
        ),
      );

  _goToFormScreen(PlantListFormEditing listFormEditing) async {
    KeyboardHelper.hideKeyboard(context);
    final result = await Navigator.of(context).pushNamed(
      MainDestination.plantForm,
      arguments: listFormEditing.plantFormInputDto,
    );

    final plantFormOutputDto = result is PlantFormOutputDto ? result : null;

    _plantListBloc.add(
      PlantListFormEditingEnded(
        plantFormOutputDto: plantFormOutputDto,
      ),
    );
  }

  _hideListLoadings() {
    _refreshController
      ..loadComplete()
      ..refreshCompleted();
  }

  _showNewPlantAddedSnackbar() {
    final snackBar = SnackBar(
      content: Text('New plant added'),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
