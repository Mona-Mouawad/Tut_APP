import 'dart:async';
import 'package:tut_app/app/functions.dart';
import 'package:tut_app/domain/usecase/forgetPassword_usecase.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgetPasswordViewModel extends BaseViewModel
    with ForgetPasswordViewModelInput, ForgetPasswordViewModelOutput {
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  ForgetPasswordViewModel(this._forgetPasswordUseCase);

  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();
  var email = "";

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();
    _isAllInputValidStreamController.close();
  }

  @override
  // TODO: implement emailInput
  Sink get emailInput => _emailStreamController.sink;

  @override
  // TODO: implement inputIsAllInputValid
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  // TODO: implement emailOutput
  Stream<bool> get emailOutput =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  // TODO: implement outputIsAllInputValid
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream
          .map((isAllInputValid) => _isAllInputValid());

  bool _isAllInputValid() {
    return isEmailValid(email);
  }

  @override
  forgotPassword() async {
    // TODO: implement forgotPassword
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgetPasswordUseCase.execute(email)).fold(
        (failure) {
          inputState.add(
              ErrorState(StateRendererType.popupErrorState, failure.message));
        } ,
        (supportMessage) {
      inputState.add(SuccessState(supportMessage));
    });
  }

  @override
  setEmail(String email) {
    emailInput.add(email);
    this.email = email;
    _validate();
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }
}

abstract class ForgetPasswordViewModelInput {
  forgotPassword();

  setEmail(String email);

  Sink get emailInput;

  Sink get inputIsAllInputValid;
}

abstract class ForgetPasswordViewModelOutput {
  Stream<bool> get emailOutput;

  Stream<bool> get outputIsAllInputValid;
}
