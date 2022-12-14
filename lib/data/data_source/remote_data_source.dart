import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<ForgetPasswordResponse> forgetPassword(String email);

  Future<HomeResponse> getHomeData();
  Future<StoreDetailsResponse> getStoreDetails();
}

class RemoteDataSourceImp implements RemoteDataSource {
  final AppServiceClint _appServiceClint;

  RemoteDataSourceImp(this._appServiceClint);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClint.login(
        loginRequest.email, loginRequest.password);
  }

  Future<ForgetPasswordResponse> forgetPassword(String email) async {
    return await _appServiceClint.forgetPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClint.reqister(
        registerRequest.user_name,
        registerRequest.password,
        registerRequest.email,
        registerRequest.country_mobile_code,
        registerRequest.mobile_number,
        ""
       //    registerRequest.profile_picture
        );
  }

  @override
  Future<HomeResponse> getHomeData() {
    return _appServiceClint.gethome();
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() {
  return _appServiceClint.getStoreDetails();
  }
}

