import 'package:musix/core/utils/color_manager.dart';
import 'package:musix/core/utils/font_manager.dart';
import 'package:musix/core/utils/strings_manager.dart';
import 'package:musix/core/utils/style_manager.dart';
import 'package:musix/core/utils/values_manager.dart';
import 'package:flutter/material.dart';
import 'all_songs_list_view_bloc_builder.dart';
import 'featured_songs_list_view_bloc_consumer.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FeaturedSongsListViewBlocConsumer(),
                SizedBox(
                  height: AppSize.s30,
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsManager.allSongs,
                  style: getSemiBoldStyle(
                      color: ColorManager.white, fontSize: FontSize.s20),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                const AllSongsListViewBlocBuilder(),
                const SizedBox(
                  height: AppSize.s80,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
