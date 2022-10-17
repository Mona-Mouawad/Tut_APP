import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/domain/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

 RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.user_name,
        input.country_mobile_code,
        input.email,
        input.password,
        input.mobile_number,
        input.profile_picture));
  }
}

class RegisterUseCaseInput {
  String user_name;
  String country_mobile_code;
  String email;
  String password;
  String mobile_number;
  String profile_picture;

  RegisterUseCaseInput(this.user_name, this.country_mobile_code, this.email,
      this.password, this.mobile_number, this.profile_picture);
}
