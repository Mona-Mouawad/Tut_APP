
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetwokInfo{
  Future<bool> get isConnected ;
}

class NetwokInfoImpl implements NetwokInfo {

 final InternetConnectionChecker _internetConnectionChecker ;

  NetwokInfoImpl(this._internetConnectionChecker);

  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => _internetConnectionChecker.hasConnection;


}