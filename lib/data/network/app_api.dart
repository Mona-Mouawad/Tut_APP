
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tut_app/app/constants.dart';
import 'package:tut_app/data/response/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClint{

  factory AppServiceClint(Dio dio ,{String baseUrl}) = _AppServiceClint;

@POST("/customers/login")
  Future<AuthenticationResponse> login (@Field("email") String email , @Field("password") String password);

  @POST("/customers/forgetPassword")
  Future<ForgetPasswordResponse> forgetPassword (@Field("email") String email);

}

