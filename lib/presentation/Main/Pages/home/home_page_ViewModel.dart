import 'dart:async';
import 'dart:ffi';
import 'package:rxdart/rxdart.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/domain/usecase/home_usecase.dart';
import 'package:tut_app/presentation/base/baseviewmodel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  // final StreamController _BannersStreamController =
  //     BehaviorSubject<List<Banners>>();
  // final StreamController _ServiceStreamController =
  //     BehaviorSubject<List<Service>>();
  // final StreamController _StoreStreamController =
  // BehaviorSubject<List<Store>>();

  final _HomeObjectStreamController = BehaviorSubject<HomeObjectViewModel>();

  HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    // _BannersStreamController.close();
    // _ServiceStreamController.close();
    // _StoreStreamController.close();
    _HomeObjectStreamController.close();
    super.dispose();
  }

// ----- input
  @override
  // TODO: implement inputHomeObject
  Sink<HomeObjectViewModel> get inputHomeObject =>
      _HomeObjectStreamController.sink;

//   @override
//   Sink get inputBanners => _BannersStreamController.sink;
//
//   @override
//   Sink get inputServices => _ServiceStreamController.sink;
//
//   @override
//   Sink get inputStores => _StoreStreamController.sink;

  // ----- output
  @override
  // TODO: implement outputHomeObject
  Stream<HomeObjectViewModel> get outputHomeObject =>
      _HomeObjectStreamController.stream.map((HomeObject) => HomeObject);

  // @override
  // Stream<List<Banners>> get outputBanners => _BannersStreamController.stream.map((Banners) => Banners);
  //
  // @override
  // Stream<List<Service>> get outputServices => _ServiceStreamController.stream.map((Service) => Service);
  //
  // @override
  // Stream<List<Store>> get outputStores => _StoreStreamController.stream.map((Store) => Store);

  _getHomeData() async {
    // TODO: implement register
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    (await _homeUseCase.execute(Void)).fold(
        (failure) => inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message)), (home) {
      inputState.add(ContentState());
      inputHomeObject.add(HomeObjectViewModel(
          home.data.banners, home.data.services, home.data.stores));
      // inputBanners.add(home.data?.banners);
      // inputServices.add(home.data?.services);
      // inputStores.add(home.data?.stores);
    });
  }
}

abstract class HomeViewModelInput {
  // Sink get inputStores;
  //
  // Sink get inputServices;
  //
  // Sink get inputBanners;

  Sink<HomeObjectViewModel> get inputHomeObject;
}

abstract class HomeViewModelOutput {
  // Stream <List<Store>> get outputStores;
  //
  // Stream <List<Service>> get outputServices;
  //
  // Stream <List<Banners>> get outputBanners;
  Stream<HomeObjectViewModel> get outputHomeObject;
}

class HomeObjectViewModel {
  List<Store> stores;

  List<Service> services;

  List<Banners> banners;

  HomeObjectViewModel(this.banners, this.services, this.stores);
}
