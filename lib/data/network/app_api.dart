import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tut_app/app/constants.dart';
import 'package:tut_app/data/response/responses.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClint {
  factory AppServiceClint(Dio dio, {String baseUrl}) = _AppServiceClint;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);

  @POST("/customers/forgetPassword")
  Future<ForgetPasswordResponse> forgetPassword(@Field("email") String email);


  @POST("/customers/reqister")
  Future<AuthenticationResponse> reqister(
      @Field("user_name") String userName, @Field("password") String password,
      @Field("email") String email, @Field("country_mobile_code") String countryMobileCode,
      @Field("mobile_number") String mobileNumber, @Field("profile_picture") String profilePicture);

  @GET("/home")
  Future<HomeResponse> gethome();


}


////flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs
