import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/core/utils/color_manager.dart';
import '../core/utils/functions/setup_service_locator.dart';
import '../core/utils/routes_manager.dart';
import '../features/home/data/repos/home_repo_impl.dart';
import '../features/home/domain/usecases/fetch_all_songs_usecase.dart';
import '../features/home/domain/usecases/fetch_featured_songs_usecase.dart';
import '../features/home/presentation/manager/all_songs_cubit/all_songs_cubit.dart';
import '../features/home/presentation/manager/featured_songs_cubit/featured_songs_cubit.dart';
import '../features/home/presentation/manager/search_cubit/search_cubit.dart';
import '../features/home/presentation/manager/song_player_cubit/song_player_cubit.dart';

class Musix extends StatelessWidget {
  const Musix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedSongsCubit(FetchFeaturedSongsUseCase(
            getIt.get<HomeRepoImpl>(),
          ))..fetchFeaturedSongs(),
        ),
        BlocProvider(
          create: (context) => AllSongsCubit(FetchAllSongsUseCase(
            getIt.get<HomeRepoImpl>(),
          ))..fetchAllSongs(),
        ),
        BlocProvider(
          create: (context) => SongPlayerCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(FetchAllSongsUseCase(
            getIt.get<HomeRepoImpl>(),
          ))..fetchAllSongs(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: RoutesManager.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: ColorManager.primary,
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: ColorManager.primary)
        ),
      ),
    );
  }
}