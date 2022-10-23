import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/domain/models.dart';
import 'package:tut_app/domain/repository.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, Home> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, Home>> execute(
      void input) async {
    return await _repository.gethomedata();
  }
}

