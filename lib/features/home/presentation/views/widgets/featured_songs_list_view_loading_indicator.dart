import 'package:musix/core/utils/values_manager.dart';
import 'package:musix/core/widgets/custom_fading_widget.dart';
import 'package:musix/features/home/presentation/views/widgets/custom_song_image_item_loading_indicator.dart';
import 'package:flutter/material.dart';

class FeaturedSongsListViewLoadingIndicator extends StatelessWidget {
  const FeaturedSongsListViewLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFadingWidget(
      childWidget: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
              child: CustomSongImageItemLoadingIndicator(),
            );
          },
        ),
      ),
    );
  }
}
