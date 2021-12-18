class Song {
  final String title;
  final String artist;
  final String thumbnail;
  final String url;

  Song(
      {required this.title,
      required this.artist,
      required this.thumbnail,
      required this.url});

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        title: json['title'],
        artist: json['artist'],
        thumbnail: json['thumbnail'],
        url: json['url'],
      );
}
