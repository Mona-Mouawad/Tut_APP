import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/app/dependency_injection.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/presentation/Main/Pages/home/home_page_ViewModel.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut_app/presentation/resources/color_manager.dart';
import 'package:tut_app/presentation/resources/routes_manger.dart';
import 'package:tut_app/presentation/resources/strings_manager.dart';
import 'package:tut_app/presentation/resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

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
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.start();
                }) ??
                _getContentWidget();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {

    return StreamBuilder<HomeObjectViewModel>(
        stream: _viewModel.outputHomeObject,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getBannerWidget(snapshot.data?.banners),
              _getSection(AppStrings.services),
              _getServiceWidget(snapshot.data?.services),
              _getSection(AppStrings.stores),
              _getStoresWidget(snapshot.data?.stores)
            ],
          );
        });
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     _getBannersCarousel(),
    //     _getSection(AppStrings.services),
    //     _getServices(),
    //     _getSection(AppStrings.stores),
    //     _getStores()
    //   ],
    // );
  }

  // Widget _getBannersCarousel() {
  //   return StreamBuilder<List<Banners>>(
  //       stream: _viewModel.outputBanners,
  //       builder: (context, snapshot) {
  //         return _getBannerWidget(snapshot.data);
  //       });
  // }

  Widget _getBannerWidget(List<Banners>? banner) {
    if (banner != null) {
      return CarouselSlider(
          items: banner
              .map((banner) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSize.s1_5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: BorderSide(
                              color: ColorManager.primary, width: AppSize.s1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.network(
                          banner.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              height: AppSize.s190,
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true));
    } else
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

  // Widget _getServices() {
  //   return StreamBuilder<List<Service>>(
  //       stream: _viewModel.outputServices,
  //       builder: (context, snapshot) {
  //         return _getServiceWidget(snapshot.data);
  //       });
  // }

  Widget _getServiceWidget(List<Service>? service) {
    if (service != null) {
      return Padding(
          padding: const EdgeInsets.only(
            left: AppPadding.p12,
            right: AppPadding.p12,
          ),
          child: Container(
            height: AppSize.s160,
            margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: service
                  .map((service) => Card(
                        elevation: AppSize.s4,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: AppSize.s1, color: ColorManager.white),
                            borderRadius: BorderRadius.circular(AppSize.s12)),
                        child: Column(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            child: Image.network(
                              service.image,
                              fit: BoxFit.cover,
                              width: AppSize.s120,
                              height: AppSize.s120,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: AppPadding.p8),
                            child: Align(
                              alignment: Alignment.center,
                                child: Text(
                              service.title,
                              style: Theme.of(context).textTheme.labelMedium,
                                  textAlign: TextAlign.center,
                            )),
                          )
                        ]),
                      ))
                  .toList(),
            ),
          ));
    } else
      return Container();
  }

  // Widget _getStores() {
  //   return StreamBuilder<List<Store>>(
  //       stream: _viewModel.outputStores,
  //       builder: (context, snapshot) {
  //         return _getStoresWidget(snapshot.data);
  //       });
  // }

  Widget _getStoresWidget(List<Store>? store) {
    if (store != null) {
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSize.s2,
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                  store.length,
                  (index) => InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.storeDetailsRoute);
                        },
                        child: Card(
                          elevation: AppSize.s4,
                          child: Image.network(
                            store[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )),
            ),
          ],
        ),
      );
    } else
      return Container();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
