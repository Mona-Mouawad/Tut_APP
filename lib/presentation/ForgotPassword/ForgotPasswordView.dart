import 'package:flutter/material.dart';
import 'package:tut_app/app/dependency_injection.dart';
import 'package:tut_app/presentation/ForgotPassword/ForgetPasswordViewModel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/constants_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final ForgetPasswordViewModel _viewModel =
  instance<ForgetPasswordViewModel>();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
    _emailController.addListener(() {
      return _viewModel.setEmail(_emailController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.forgotPassword();
              }) ??
              _getContentWidget();
        },
      ),
      bottomSheet: bottomSheet ,
    );
  }

  Widget _getContentWidget() {
    return Container(
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.only(
          top: AppPadding.p100, left: AppPadding.p28, right: AppPadding.p28),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Image(image: AssetImage(ImageAssets.splashLogo)),
              const SizedBox(
                height: AppSize.s28,
              ),
              StreamBuilder<bool>(
                stream: _viewModel.emailOutput,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: AppStrings.emailHint,
                        labelText: AppStrings.emailHint,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : AppStrings.invalidEmail),
                  );
                },
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              StreamBuilder<bool>(
                  stream: _viewModel.outputIsAllInputValid,
                  builder: (context, snapshot) {
                    return SizedBox(
                      width: double.infinity,
                      height: AppSize.s40,
                      child: ElevatedButton(onPressed: (snapshot.data ?? false)
                          ? () => _viewModel.forgotPassword() : null,
                          child: const Text(AppStrings.resetPassword)),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
