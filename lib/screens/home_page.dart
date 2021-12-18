import "package:flutter/material.dart";
import 'package:music_player/classes/song_object.dart';
import 'package:music_player/screens/music_player.dart';
import 'package:music_player/screens/search_screen.dart';
import 'package:music_player/screens/home_screen.dart';
import 'package:music_player/utils/save_audio.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> screens = <Widget>[];

  void initState() {
    super.initState();
    screens = <Widget>[
      const HomeScreen(),
      SearchScreen(
        openNowPlaying: openNowPlaying,
      ),
      const MusicPlayer(),
    ];
  }

  void _onItemTapped(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void openNowPlaying(Song song) {
    screens.removeAt(2);
    screens.add(MusicPlayer(
      song: song,
    ));
    setState(() {
      _selectedIndex = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.play_circle), label: "Now Playing"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
