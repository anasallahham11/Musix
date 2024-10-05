import 'package:musix/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:musix/core/utils/strings_manager.dart';
import 'package:musix/core/utils/values_manager.dart';
import 'package:musix/features/home/presentation/views/widgets/search_result_list_view_bloc_builder.dart';
import '../../../../../core/utils/color_manager.dart';
import '../../../../../core/utils/style_manager.dart';
import 'custom_search_text_field.dart';
import 'mini_player_bloc_consumer.dart';
import 'search_result_list_view.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s20,),
            CustomSearchTextField(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
              child: Text(
                StringsManager.searchResults,
                style: getSemiBoldStyle(
                    color: ColorManager.white, fontSize: FontSize.s20),
              ),
            ),
            const Expanded(child: SearchResultListViewBlocBuilder()),
          ],
        ),
      ),
      bottomSheet: const MiniPlayerBlocConsumer(),
    );
  }
}
