import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/data/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<ForgetPasswordResponse> forgetPassword(String email);
}

class RemoteDataSourceImp implements RemoteDataSource {
  final AppServiceClint _appServiceClint;

  RemoteDataSourceImp(this._appServiceClint);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await
        _appServiceClint.login(loginRequest.email, loginRequest.password);
  }

  Future<ForgetPasswordResponse> forgetPassword(String email) async {
    return await
    _appServiceClint.forgetPassword(email);
  }
}
