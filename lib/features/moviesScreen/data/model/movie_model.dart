import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final double voteAverage;

  const Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }

  @override
  List<Object> get props => [id, title, posterPath, overview, voteAverage];
}
