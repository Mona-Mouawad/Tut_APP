import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/app/dependency_injection.dart';
import 'package:tut_app/presentation/Login/login_viewmodel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/constants_manager.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _preferences = instance<AppPreferences>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();

  final _form = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _userPasswordController.addListener(
        () => _viewModel.setPassword(_userPasswordController.text));
    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn)
        SchedulerBinding.instance?.addPostFrameCallback((_) {
          _preferences.setUserLoggedIn();
          Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
        });
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.white,
        bottomSheet: bottomSheet ,
        body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (BuildContext context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.login();
                  }) ??
                  _getContentWidget();
            }));
  }

  Widget _getContentWidget() {
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                  child: Image(image: AssetImage(ImageAssets.splashLogo))),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outIsUserNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _userNameController,
                      decoration: InputDecoration(
                          hintText: AppStrings.username.tr(),
                          labelText: AppStrings.username.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.usernameError.tr()),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outIPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.text,
                      controller: _userPasswordController,
                      decoration: InputDecoration(
                          hintText: AppStrings.password.tr(),
                          labelText: AppStrings.password.tr(),
                          errorText: (snapshot.data ?? true)
                              ? null
                              : AppStrings.passwordError.tr()),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                  stream: _viewModel.outputAreAllInputsValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(
                          onPressed: (snapshot.data ?? false)
                              ? () {
                            _viewModel.login();
                          }
                              : null,
                          child:  Text(AppStrings.login.tr())),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p28, vertical: AppPadding.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.forgotPasswordRoute);
                        },
                        child: Text(
                          AppStrings.forgetPassword.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.registerRoute);
                        },
                        child: Text(
                          AppStrings.registerText.tr(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
