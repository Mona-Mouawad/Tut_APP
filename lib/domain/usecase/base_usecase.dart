 // البوابه بين data layer و presentation layer

 import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';

abstract class BaseUseCase<Input, Output> {
  Future<Either<Failure,Output>> execute (Input input);
 }