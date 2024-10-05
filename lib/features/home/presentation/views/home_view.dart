import 'package:musix/core/utils/values_manager.dart';
import 'package:musix/features/home/presentation/views/widgets/custom_app_bar.dart';
import 'package:musix/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:musix/features/home/presentation/views/widgets/mini_player_bloc_consumer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(AppSize.s90),
          child: CustomAppBar(),
        ),
        body: HomeViewBody(),
        bottomSheet: MiniPlayerBlocConsumer(),
      ),
    );
  }
}
