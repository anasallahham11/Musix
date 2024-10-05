import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:musix/core/utils/strings_manager.dart';
import 'package:musix/core/utils/values_manager.dart';

import '../../../../../core/utils/color_manager.dart';
import '../../manager/search_cubit/search_cubit.dart';

class CustomSearchTextField extends StatelessWidget {
  CustomSearchTextField({Key? key}) : super(key: key);

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return TextField(
            onChanged: (value) {
              context.read<SearchCubit>().searchSongs(value);
            },
            controller: searchController,
            decoration: InputDecoration(
              enabledBorder: buildOutlineInputBorder(),
              focusedBorder: buildOutlineInputBorder(),
              hintText: StringsManager.search,
              suffixIcon: IconButton(
                onPressed: () {
                  context
                      .read<SearchCubit>()
                      .searchSongs(searchController.text);
                },
                icon: const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: AppSize.s24,
                ),
              ),
            ),
          );
        });
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: ColorManager.grey),
      borderRadius: BorderRadius.circular(AppSize.s12),
    );
  }
}
