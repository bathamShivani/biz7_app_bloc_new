import 'package:biz_app_bloc/app/bloc/app_bloc.dart';
import 'package:biz_app_bloc/core/cache_client.dart';
import 'api/api_client.dart';
import 'api/api_helper.dart';
import 'cache/cache_helper.dart';

abstract class DataHelper {
  set setApiHelper(ApiHelper apiHelper);

  ApiHelper get apiHelper;

  CacheHelper get cacheHelper;

  AppBloc get appBloc;
}

class DataHelperImpl implements DataHelper {
  DataHelperImpl._internal() {
    _appBloc = AppBloc();
    _apiHelper = ApiHelperImpl(
      ApiClient()
    );
    _cacheHelper = CacheHelperImpl(CacheClient());
  }

  static final DataHelperImpl _singleton = DataHelperImpl._internal();
  late ApiHelper _apiHelper;
  late CacheHelper _cacheHelper;
  late AppBloc _appBloc;

  static DataHelperImpl get instance => _singleton;

  @override
  set setApiHelper(ApiHelper apiHelper) {
    _apiHelper = apiHelper;
  }

  @override
  ApiHelper get apiHelper => _apiHelper;

  @override
  CacheHelper get cacheHelper => _cacheHelper;

  @override
  AppBloc get appBloc => _appBloc;
}
