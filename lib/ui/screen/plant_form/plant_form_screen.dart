import 'package:flutter/material.dart';

import '../../ui.dart';

class PlantFormScreen extends StatefulWidget {
  @override
  _PlantFormScreenState createState() => _PlantFormScreenState();
}

class _PlantFormScreenState extends State<PlantFormScreen> {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  PlantFormBloc _plantFormBloc;

  @override
  void initState() {
    super.initState();
    _plantFormBloc = BlocProvider.of<PlantFormBloc>(context);
  }

  @override
  Widget build(BuildContext context) => BlocListener<PlantFormBloc, PlantFormState>(
        listener: _plantFormBlocListener,
        child: Scaffold(
          appBar: AppBar(
            title: PlantFormAppBarTitle(),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(Dimens.smallSpacing),
              child: Column(
                children: [
                  PlantFormNameTextField(
                    controller: _nameController,
                  ),
                  VerticalSpacing(),
                  PlantFormTypeDropdown(
                    onChanged: _onChangeType,
                    onPress: _onPressTypeDropdown,
                  ),
                  VerticalSpacing(),
                  PlantFormDateField(
                    controller: _dateController,
                    onPress: _onPressDateField,
                  ),
                  VerticalSpacing(),
                  PlantFormSaveButton(
                    onPress: _onPressSave,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  _plantFormBlocListener(context, state) {
    if (state is PlantFormStartingDataLoaded) {
      _setInitialInfo(state.widgetData);
      _setListeners();
    } else if (state is PlantFormDateUpdated) {
      _updateDate(state.widgetData.plantedAtDate);
    } else if (state is PlantFormLoading) {
      // LoadingHelper.startLoading(context);
    } else if (state is PlantFormSaved) {
      // LoadingHelper.stopLoading(context);
      _backToList(state.plantFormOutputDto);
    } else if (state is PlantFormEditingDate) {
      _openDatePicker();
    }
  }

  _onPressSave() => _plantFormBloc.add(
        PlantFormOnPressSave(),
      );

  _onPressDateField() => _plantFormBloc.add(
        PlantFormOnPressDateField(),
      );

  _onPressTypeDropdown() => KeyboardHelper.hideKeyboard(context);

  _setListeners() {
    _nameController.addListener(_onChangeName);
  }

  _setInitialInfo(PlantFormWidgetData widgetData) {
    _nameController.text = widgetData.name;
    _updateDate(widgetData.plantedAtDate);
  }

  _updateDate(String plantedAtDate) {
    _dateController.text = plantedAtDate;
  }

  _onChangeName() => _plantFormBloc.add(
        PlantFormUpdateName(
          name: _nameController.text,
        ),
      );

  _onChangeType(PlantType plantType) => _plantFormBloc.add(
        PlantFormUpdateType(
          plantType: plantType,
        ),
      );

  _backToList(PlantFormOutputDto plantFormOutputDto) => Navigator.of(context).pop(
        plantFormOutputDto,
      );

  _openDatePicker() async {
    KeyboardHelper.hideKeyboard(context);
    final result = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2100),
    );
    _plantFormBloc.add(
      PlantFormEditingDateEnded(
        plantedAtTimestamp: result?.millisecondsSinceEpoch,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
