import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/domain/usecase/home_usecase.dart';
import 'package:tut_app/domain/usecase/storeDetails_usecase.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailViewModelInput, StoreDetailViewModelOutput {

  final _StoreDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase _storeDetailsUseCase;

  StoreDetailsViewModel(this._storeDetailsUseCase);

  @override
  void start() {
    _getStoreDetailData();
  }

  @override
  void dispose() {
    _StoreDetailsStreamController.close();
    super.dispose();
  }

// ----- input
  @override
  // TODO: implement inputStoreDetailObject
  Sink<StoreDetails> get inputStoreDetail =>
      _StoreDetailsStreamController.sink;

  @override
  // TODO: implement outputStoreDetailObject
  Stream<StoreDetails> get outputStoreDetail =>
      _StoreDetailsStreamController.stream.map((Store) => Store);

  _getStoreDetailData() async {
    // TODO: implement register
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _storeDetailsUseCase.execute(Void)).fold(
        (failure) => inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message)), (data) {
      inputState.add(ContentState());
      inputStoreDetail.add(StoreDetails(data.id, data.title, data.image, data.details, data.services,data.about));

    });
  }
}

abstract class StoreDetailViewModelInput {
  Sink<StoreDetails> get inputStoreDetail;
}

abstract class StoreDetailViewModelOutput {
  Stream<StoreDetails> get outputStoreDetail;
}


