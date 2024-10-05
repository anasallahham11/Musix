import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musix/core/utils/values_manager.dart';
class CustomSongImageItem extends StatelessWidget {
  const CustomSongImageItem({Key? key, required this.image}) : super(key: key);

  final String image;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSize.s16),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
          ),
      ),
    );
  }
}