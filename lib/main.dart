
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'app/app.dart';
import 'constants.dart';
import 'core/utils/api_service.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/functions/setup_service_locator.dart';
import 'features/home/domain/entities/song_entity.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  await ApiService.init();
  await Hive.initFlutter();
  Hive.registerAdapter(SongEntityAdapter());
  await Hive.openBox<SongEntity>(kFeaturedBox);
  await Hive.openBox<SongEntity>(kAllBox);
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  //For Dependency Injection
  setupServiceLocator();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return const Musix();
      },
    ),
  );
}


