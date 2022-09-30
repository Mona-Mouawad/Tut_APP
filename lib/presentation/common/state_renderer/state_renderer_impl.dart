import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/constants.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState(
      {required this.stateRendererType, this.message = AppStrings.loading});

  @override
  String getMessage() {
    return AppStrings.loading;
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getStateRendererType() {
    return stateRendererType;
  }
}

class SuccessState extends FlowState {

  String message;

  SuccessState(this.message);

  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.popupSuccess;
  }
}


class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() {
    return Constants.empty;
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.contentState;
  }
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() {
    return message;
  }

  @override
  StateRendererType getStateRendererType() {
    return StateRendererType.fullScreenEmptyState;
  }
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          DismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            // show popup loading
            showPopup(context, getStateRendererType(), getMessage());
            // show content ui of the screen
            return contentScreenWidget;
          }
          else {
            return StateRenderer(stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction, message: getMessage(),);
          }
        }
      case SuccessState:
        {
          DismissDialog(context);
          // show popup error
          showPopup(context, StateRendererType.popupSuccess, getMessage(),title: AppStrings.success );
          // show content ui of the screen
          return contentScreenWidget;
        }
      case ErrorState:
        {
          DismissDialog(context);
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            // show popup error
            showPopup(context, getStateRendererType(), getMessage());
            // show content ui of the screen
            return contentScreenWidget;
          }
          else {
            return StateRenderer(stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction, message: getMessage(),);
          }
        }
      case EmptyState:
        {
          DismissDialog(context);
          return StateRenderer(stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction, message: getMessage(),);
        }
      case ContentState:
        {
          DismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          DismissDialog(context);
          return contentScreenWidget;
        }
    }
  }
}

showPopup(BuildContext context, StateRendererType stateRendererType,
    String message, {String title = Constants.empty}) {
  WidgetsBinding.instance?.addPostFrameCallback((_) =>
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              StateRenderer(
                  stateRendererType: stateRendererType,
                  message: message,
                  title: title,
                  retryActionFunction: () {})));
}

_isCurrentDialogShowing(context) =>
    ModalRoute
        .of(context)
        ?.isCurrent != true;

DismissDialog(BuildContext context) {
  if (_isCurrentDialogShowing(context)) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}
