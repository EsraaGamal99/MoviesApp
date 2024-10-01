import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/movie_model.dart';

class MovieService {
  final Dio dio = Dio();
  final String apiKey = '6c4cd92a18ad64a0f7ad60074eb39925';
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> getPopularMovies() async {
    final response = await dio.get(
      '$baseUrl/movie/popular',
      queryParameters: {'api_key': apiKey},
    );

    if (response.statusCode == 200) {
      final List results = response.data['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await dio.get(
      '$baseUrl/search/movie',
      queryParameters: {
        'api_key': apiKey,
        'query': query,
      },
    );

    if (response.statusCode == 200) {
      final List results = response.data['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to search movies');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    final response = await dio.get(
      '$baseUrl/movie/top_rated',
      queryParameters: {'api_key': apiKey},
    );

    if (response.statusCode == 200) {
      final List results = response.data['results'];
      return results.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load top-rated movies');
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    final response = await dio.get(
      '$baseUrl/movie/$movieId',
      queryParameters: {'api_key': apiKey},
    );

    if (response.statusCode == 200) {
      return Movie.fromJson(response.data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}
