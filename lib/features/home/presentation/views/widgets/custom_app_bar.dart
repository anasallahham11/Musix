import 'package:musix/core/utils/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:musix/core/utils/values_manager.dart';

import '../../../../../core/utils/assets_manager.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20,vertical: AppPadding.p20),
      child: Row(
        children: [
          Image.asset(AssetsManager.logo,height: AppSize.s50,),
          const Spacer(),
          IconButton(
            onPressed: (){
              GoRouter.of(context).push(RoutesManager.searchRoute);
            },
            icon: const Icon(
              FontAwesomeIcons.magnifyingGlass,
              size: AppSize.s24,
            ),
          ),
        ],
      ),
    );
  }
}