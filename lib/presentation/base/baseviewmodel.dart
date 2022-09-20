import 'dart:async';

import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final StreamController _inputStreamController =
      StreamController<FlowState>.broadcast();



  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStreamController.close();

  }

}

abstract class BaseViewModelInputs {
  Sink get inputState;

  void start(); // start view model job

  void dispose(); // will be called when view model dies
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
