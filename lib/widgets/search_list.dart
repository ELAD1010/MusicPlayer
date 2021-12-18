import "package:flutter/material.dart";
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:music_player/api/song_search_api.dart';
import 'package:music_player/classes/song_object.dart';
import 'package:music_player/widgets/search_bar.dart';
import 'package:music_player/widgets/song_list_item.dart';

class SongList extends StatefulWidget {
  final Function openNowPlaying;
  const SongList({Key? key, required this.openNowPlaying}) : super(key: key);
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  static const _pageSize = 5;

  final PagingController<int, Song> _pagingController =
      PagingController(firstPageKey: 0);

  String? _searchTerm;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      final newItems = await RemoteApi.getCharacterList(
        pageKey,
        _pageSize,
        searchTerm: _searchTerm,
      );

      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: <Widget>[
          CharacterSearchInputSliver(
            onChanged: _updateSearchTerm,
          ),
          PagedSliverList<int, Song>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Song>(
              itemBuilder: (context, item, index) => SongListItem(
                song: item,
                openNowPlaying: widget.openNowPlaying,
              ),
            ),
          ),
        ],
      );

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
