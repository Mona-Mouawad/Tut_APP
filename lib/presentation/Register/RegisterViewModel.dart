import 'package:tut_app/app/constants.dart';
import 'package:tut_app/app/functions.dart';
import 'package:tut_app/domain/usecase/register_usecase.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/freezed_data_classes.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'dart:async';
import 'dart:io';

import 'package:tut_app/presentation/resources/strings_manager.dart';

import '../common/state_renderer/state_renderer_impl.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModeInputs, RegisterViewModelOutputs {
  StreamController userNameStreamController =
      StreamController<String>.broadcast();
  StreamController mobileNumberStreamController =
      StreamController<String>.broadcast();
  StreamController emailStreamController = StreamController<String>.broadcast();
  StreamController passwordStreamController =
      StreamController<String>.broadcast();
  StreamController profilePictureStreamController =
      StreamController<File>.broadcast();
  StreamController areAllInputsValidStreamController =
      StreamController<void>.broadcast();
  StreamController isRegisterScussesStreamController = StreamController<bool>();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("", "", "", "", "", "");

  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userNameStreamController.close();
    passwordStreamController.close();
    mobileNumberStreamController.close();
    passwordStreamController.close();
    profilePictureStreamController.close();
    emailStreamController.close();
    areAllInputsValidStreamController.close();
    isRegisterScussesStreamController.close();
    super.dispose();
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => passwordStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => userNameStreamController.sink;

  @override
  // TODO: implement inputemail
  Sink get inputemail => emailStreamController.sink;

  @override
  // TODO: implement inputmobileNumber
  Sink get inputmobileNumber => mobileNumberStreamController.sink;

  @override
  // TODO: implement inputprofilePicture
  Sink get inputprofilePicture => profilePictureStreamController.sink;

  @override
  // TODO: implement inputAllInputValid
  Sink get inputAllInputValid => areAllInputsValidStreamController.sink;

  @override
  setCountryCode(String countryCode ) {
    // TODO: implement setCountryCode
    if (countryCode.isNotEmpty) {
      //  update register view object
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      // reset code value in register view object
      registerObject = registerObject.copyWith(countryMobileCode: Constants.initCountryMobileCode);
    }
    validate();
  }

  @override
  setEmail(String email) {
    // TODO: implement setEmail
    inputemail.add(email);
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    // TODO: implement setMobileNumber
    inputmobileNumber.add(mobileNumber);
    if (_MobileNumberValid(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    // TODO: implement setPassword
    inputPassword.add(password);
    if (_PasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  setProfilePicture(File profilePicture) {
    // TODO: implement setProfilePicture
    inputprofilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      registerObject =
          registerObject.copyWith(profilePicture: profilePicture.path);
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    validate();
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    inputUserName.add(userName);
    if (_userNameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
  }

// output
  @override
  // TODO: implement outputErrorEmail
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : AppStrings.userNameInvalid);

  @override
  // TODO: implement outputIsEmailValid
  Stream<bool> get outputIsEmailValid =>
      emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  // TODO: implement outputIsMobileNumberValid
  Stream<bool> get outputIsMobileNumberValid =>
      mobileNumberStreamController.stream
          .map((mobileNumber) => _MobileNumberValid(mobileNumber));

  @override
  // TODO: implement outputErrorMobileNumber
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid.map(
      (mobileNumber) => mobileNumber ? null : AppStrings.mobileNumberInvalid);

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => passwordStreamController.stream
      .map((password) => _PasswordValid(password));

  @override
  // TODO: implement outputErrorPassword
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((Password) => Password ? null : AppStrings.passwordInvalid);

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid => userNameStreamController.stream
      .map((userName) => _userNameValid(userName));

  @override
  // TODO: implement outputErrorUserName
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUserName) => isUserName ? null : AppStrings.userNameInvalid);

  @override
  // TODO: implement outputIsProfilePictureValid
  Stream<File> get outputIsProfilePictureValid =>
      profilePictureStreamController.stream.map((file) => file);

  @override
  // TODO: implement outputAllInputValid
  Stream<bool> get outputAllInputValid =>
      areAllInputsValidStreamController.stream.map((_) => _areAllInputsValid());

  bool _userNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _PasswordValid(String Password) {
    return Password.length >= 6;
  }

  bool _MobileNumberValid(String MobileNumber) {
    return MobileNumber.length == 11;
  }

  bool _areAllInputsValid() {
    if(registerObject.countryMobileCode.isEmpty) registerObject = registerObject.copyWith(countryMobileCode: Constants.initCountryMobileCode);
    return registerObject.userName.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty;
  }

  validate() {
    inputAllInputValid.add(null);
  }

  @override
  register() async {
    // TODO: implement register
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _registerUseCase.execute(RegisterUseCaseInput(
            registerObject.userName,
            registerObject.countryMobileCode,
            registerObject.email,
            registerObject.password,
            registerObject.mobileNumber,
            registerObject.profilePicture)))
        .fold(
            (failure) => inputState.add(
                ErrorState(StateRendererType.popupErrorState, failure.message)),
            (data) {
      inputState.add(ContentState());
      // navigate to main screen
      isRegisterScussesStreamController.add(true);
   //   isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }
}

abstract class RegisterViewModeInputs {
  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputemail;

  Sink get inputprofilePicture;

  Sink get inputmobileNumber;

  Sink get inputAllInputValid;

  register();

  setUserName(String userName);

  setMobileNumber(String mobileNumber);

  setCountryCode(String countryCode);

  setEmail(String email);

  setPassword(String password);

  setProfilePicture(File profilePicture);
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;

  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputAllInputValid;

  Stream<String?> get outputErrorPassword;

  Stream<File> get outputIsProfilePictureValid;
}
