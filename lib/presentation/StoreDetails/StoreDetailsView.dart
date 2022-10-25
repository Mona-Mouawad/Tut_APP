import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/dependency_injection.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/StoreDetails/storeDetails_ViewModel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final StoreDetailsViewModel _viewModel = instance<StoreDetailsViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.storeDetails.tr()),
        elevation: AppSize.s0,
        iconTheme: IconThemeData(
          //back button
          color: ColorManager.white,
        ),
        backgroundColor: ColorManager.primary,
        centerTitle: true,
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data
                  ?.getScreenWidget(context, _getContentWidget(), () {
                _viewModel.start();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Container(
      constraints: BoxConstraints.expand(),
      color: ColorManager.white,
      child: SingleChildScrollView(
        child: StreamBuilder<StoreDetails>(
            stream: _viewModel.outputStoreDetail,
            builder: (context, snapshot) {
              return _getItems(snapshot.data);
            }),
      ),
    );
  }

  Widget _getItems(StoreDetails? storeDetails) {
    if (storeDetails != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Image.network(
            storeDetails.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: AppSize.s250,
          )),
          _getSection(AppStrings.details.tr()),
          _getInfoText(storeDetails.details),
          _getSection(AppStrings.services.tr()),
          _getInfoText(storeDetails.services),
          _getSection(AppStrings.about.tr()),
          _getInfoText(storeDetails.about)
        ],
      );
    }
    return Container();
  }

  Widget _getSection(String text) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppPadding.p12,
          left: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p2),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  Widget _getInfoText(String info) {
    return Padding(
      padding: const EdgeInsets.all(AppSize.s12),
      child: Text(info, style: Theme.of(context).textTheme.bodySmall),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
