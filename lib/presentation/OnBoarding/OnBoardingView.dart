import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/OnBoarding/OnBoardingViewModel.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/constants_manager.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

import '../../app/dependency_injection.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final PageController _pageController = PageController();
  final AppPreferences _preferences = instance<AppPreferences>();

  _bind() {
    _preferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else
      return Scaffold(

        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark),
        ),
        body: PageView.builder(
            controller: _pageController,
            itemCount: sliderViewObject.numOfSlides,
            onPageChanged: (index) {
              _viewModel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return _items(index, sliderViewObject.sliderObject);
            }),
        bottomSheet:
            Container(
              color: ColorManager.white,
              height: AppSize.s120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, Routes.loginRoute);
                      },
                      child: Text(
                        AppStrings.skip.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  _getBottomSheetWidget(sliderViewObject),
                //  bottomSheet ,
                ],
              ),
            ),
      );
  }

  Widget _items(index, SliderObject sliderObject) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(sliderObject.title,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(sliderObject.subTitle,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(sliderObject.image)
      ],
    );
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.leftArrowIc)),
            ),
          ),
          Spacer(),
          for (int i = 0; i < sliderViewObject.numOfSlides; i++)
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: SizedBox(
                  width: AppSize.s10,
                  height: AppSize.s10,
                  child: _getProperCircle(i, sliderViewObject)),
            ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
              child: SizedBox(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  child: SvgPicture.asset(ImageAssets.rightArrowIc)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, SliderViewObject sliderViewObject) {
    if (index == sliderViewObject.currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIc);
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
