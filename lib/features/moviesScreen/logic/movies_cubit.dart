import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/movie_model.dart';
import '../data/repos/movies_list_repo.dart';
part 'movies_state.dart';


class MovieCubit extends Cubit<MovieState> {
  final MovieService movieService;

  MovieCubit(this.movieService) : super(MovieInitial());

  Future<void> fetchPopularMovies() async {
    try {
      emit(MovieLoading());
      final movies = await movieService.getPopularMovies();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('Failed to fetch movies.'));
    }
  }

  Future<void> searchMovies(String query) async {
    try {
      emit(MovieLoading());
      final movies = await movieService.searchMovies(query);
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('Failed to search movies.'));
    }
  }

  Future<void> fetchTopRatedMovies() async {
    try {
      emit(MovieLoading());
      final movies = await movieService.getTopRatedMovies();
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError('Failed to fetch top-rated movies.'));
    }
  }
}
