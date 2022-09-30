
import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure.dart';
import 'package:tut_app/data/network/requests.dart';
import 'package:tut_app/domain/models.dart';

abstract class Repository
{
  Future <Either<Failure,Authentication>> login(LoginRequest loginRequest);
  Future <Either<Failure,Authentication>> reqister(ReqisterRequest reqisterRequest);
  Future <Either<Failure,String>> forgotPassword(String email);


}