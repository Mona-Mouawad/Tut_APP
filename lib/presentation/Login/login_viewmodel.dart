import 'dart:async';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModeInputs, LoginViewModelOutputs {
  final StreamController _userNamestreamController =
      StreamController<String>.broadcast();

  final StreamController _passwordtreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  var loginObject = LoginObject("", "");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    super.dispose();
    _userNamestreamController.close();
    _areAllInputsValidStreamController.close();
    _passwordtreamController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.userName, loginObject.password)))
        .fold(
            (failure) => inputState.add(
                ErrorState(StateRendererType.popupErrorState, failure.message)),
            (data) {
              inputState.add(ContentState());
              // navigate to main screen
              isUserLoggedInSuccessfullyStreamController.add(true);
            });
  }

  @override
  // TODO: implement outIsUserNameValid
  Stream<bool> get outIsUserNameValid => _userNamestreamController.stream
      .map((userName) => _isUserNameValid(userName));

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  @override
  // TODO: implement outIPasswordValid
  Stream<bool> get outIPasswordValid => _passwordtreamController.stream
      .map((password) => _isPasswordValid(password));

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllInputsValid.add(null);
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordtreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNamestreamController.sink;

  @override
  // TODO: implement inputAreAllInputsValid
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  // TODO: implement outputAreAllInputsValid
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  bool _areAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }
}

abstract class LoginViewModeInputs {
  setUserName(String userName);

  setPassword(String password);

  login();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIPasswordValid;

  Stream<bool> get outputAreAllInputsValid;
}
