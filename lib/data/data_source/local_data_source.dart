import 'package:tut_app/data/network/error_handler.dart';
import 'package:tut_app/data/response/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000;  // 1 minue cache in millis

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<void> saveHomeToCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData()async {
    CachedItem? cachedItem =cacheMap[CACHE_HOME_KEY];
    if(cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)){
      // return the response from cache
      return cachedItem.data ;
    }
    else{
      // return an error that cache is not there or its not valid
      throw ErrorHandeler.handle(DataSourceError.CACHE_ERROR);
    }

  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY]=CachedItem(homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
}
}

class CachedItem {
  dynamic data;

  int chaceTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeIMillis)
  {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTimeInMillis - chaceTime <= expirationTimeIMillis;

    print("isValid $isValid");

    // expirationTimeInMillis -> 60 sec
    // currentTimeInMillis -> 1:00:00
    // cacheTime -> 12:59:30
    // valid -> till 1:00:30
    return isValid;
  }
}
