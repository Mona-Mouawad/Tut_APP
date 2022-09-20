import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/app/app_prefs.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/network/app_api.dart';
import 'package:tut_app/data/network/dio_factory.dart';
import 'package:tut_app/data/network/network_info.dart';
import 'package:tut_app/data/repository/repository_impl.dart';
import 'package:tut_app/domain/repository.dart';
import 'package:tut_app/domain/usecase/forgetPassword_usecase.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/presentation/ForgotPassword/ForgetPasswordViewModel.dart';
import 'package:tut_app/presentation/Login/login_viewmodel.dart';

final instance = GetIt.instance;

Future initAppModule() async {
  // app module, its a module where we ***** put all generic dependencies
  // app prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(instance<SharedPreferences>()));

  // network info
  instance.registerLazySingleton<NetwokInfo>(
      () => NetwokInfoImpl(InternetConnectionChecker()));
  // dio factory     //app service client
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  Dio dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClint>(() => AppServiceClint(dio));
// repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(instance()));
}

 initLoginModule() {
  if(!GetIt.I.isRegistered<LoginUseCase>())
    {
      instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
      instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
    }
}

initForgotPasswordModule ()
{
  if(!GetIt.I.isRegistered<ForgetPasswordUseCase>())
    {
      instance.registerFactory<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(instance()));
      instance.registerFactory<ForgetPasswordViewModel>(() => ForgetPasswordViewModel(instance()));

    }
}
