import 'package:flutter/cupertino.dart';
import 'package:tut_app/app/constants.dart';
import 'package:tut_app/data/response/responses.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/app/extensions.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
        this?.id.orEmpty() ?? Constants.empty,
        this?.name.orEmpty() ?? Constants.empty,
        this?.numOfNotification.orZero() ?? Constants.zero);
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
        this?.email.orEmpty() ?? Constants.empty,
        this?.phone.orEmpty() ?? Constants.empty,
        this?.link.orEmpty() ?? Constants.empty);
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contacts.toDomain());
  }
}

extension ForgotPasswordResponseMapper on ForgetPasswordResponse? {
  String toDomain() {
    return this?.support.orEmpty() ?? Constants.empty;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      this?.id.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension BannerResponseMapper on BannersResponse? {
  Banners toDomain() {
    return Banners(
      this?.id?.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  Home toDomain() {
    List<Service> service = (this
                ?.data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();

    List<Banners> banners = (this
        ?.data
        ?.banners
        ?.map((bannersResponse) => bannersResponse.toDomain()) ??
        const Iterable.empty())
        .cast<Banners>()
        .toList();
    List<Store> stores = (this
        ?.data
        ?.stores
        ?.map((storesResponse) => storesResponse.toDomain()) ??
        const Iterable.empty())
        .cast<Store>()
        .toList();

    var data = HomeData(service, banners, stores);
    return Home(data) ;
  }
}

extension StoreDetailsMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
      this?.id?.orZero() ?? Constants.zero,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
      this?.details.orEmpty() ?? Constants.empty,
      this?.services.orEmpty() ?? Constants.empty,
      this?.about.orEmpty() ?? Constants.empty,
    );
  }
}
