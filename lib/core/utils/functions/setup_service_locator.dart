
import 'package:get_it/get_it.dart';
import '../../../features/home/data/data_sources/home_local_data_source.dart';
import '../../../features/home/data/data_sources/home_remote_data_source.dart';
import '../../../features/home/data/repos/home_repo_impl.dart';

var getIt=GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
        homeLocalDataSource: HomeLocalDataSourceImpl(),
        homeRemoteDataSource: HomeRemoteDataSourceImpl()
    ),
  );
}