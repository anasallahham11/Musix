import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix/core/utils/values_manager.dart';

import '../../../domain/entities/song_entity.dart';
import '../../manager/featured_songs_cubit/featured_songs_cubit.dart';
import 'custom_song_image_item.dart';

class FeaturedSongsListView extends StatefulWidget {
  const FeaturedSongsListView({Key? key, required this.songs}) : super(key: key);
  final List<SongEntity> songs;

  @override
  State<StatefulWidget> createState() => _FeaturedSongsListViewState();
}

class _FeaturedSongsListViewState extends State<FeaturedSongsListView> {
  late ScrollController _scrollController;
  var nextPage=1;
  var isLoading=false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() async{
    if (_scrollController.position.atEdge) return;
    double currentScrollPosition = _scrollController.position.pixels;
    double maxScrollExtent = _scrollController.position.maxScrollExtent;
    double scrollPercentage = currentScrollPosition / maxScrollExtent;
    if (scrollPercentage > 0.7) {
      if(!isLoading) {
        isLoading=true;
        await BlocProvider.of<FeaturedSongsCubit>(context).fetchFeaturedSongs(pageNumber: nextPage++);
        isLoading=false;
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.songs.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
            child: CustomSongImageItem(
              image: widget.songs[index].image ?? '',
            ),
          );
        },
      ),
    );
  }
}
