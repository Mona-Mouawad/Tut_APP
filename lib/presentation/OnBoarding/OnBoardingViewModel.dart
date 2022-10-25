import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/resources/assets_manager.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {

  final StreamController _streamController = StreamController<SliderViewObject>();
  late final List<SliderObject> _list ;
  @override
  void dispose() {
    _streamController.isClosed;
    // TODO: implement dispose
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  int goNext() {
    if (_currentIndex == _list.length - 1) _currentIndex = -1;

    return ++_currentIndex;
  }

  @override
  int goPrevious() {
    if (_currentIndex == 0) _currentIndex = _list.length;
    return --_currentIndex;
  }

  @override
  void onPageChanged(int index) {
    // TODO: implement onPageChanged

    _currentIndex = index ;
    _postDataToView();
  }

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((SliderViewObject) => SliderViewObject);

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  int _currentIndex = 0;


  List<SliderObject> _getSliderData() => [
        SliderObject(
            title: AppStrings.onBoardingTitle1.tr(),
            subTitle: AppStrings.onBoardingSubTitle1.tr(),
            image: ImageAssets.onboardingLogo1),
        SliderObject(
            title: AppStrings.onBoardingTitle2.tr(),
            subTitle: AppStrings.onBoardingSubTitle2.tr(),
            image: ImageAssets.onboardingLogo2),
        SliderObject(
            title: AppStrings.onBoardingTitle3.tr(),
            subTitle: AppStrings.onBoardingSubTitle3.tr(),
            image: ImageAssets.onboardingLogo3),
        SliderObject(
            title: AppStrings.onBoardingTitle4.tr(),
            subTitle: AppStrings.onBoardingSubTitle4.tr(),
            image: ImageAssets.onboardingLogo4),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

abstract class OnBoardingViewModelInputs {
  int goNext(); // when user clicks on right arrow or swipe left
  int goPrevious(); // when user clicks on left arrow or swipe right
  void onPageChanged(int index);

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  Stream get outputSliderViewObject;
}
