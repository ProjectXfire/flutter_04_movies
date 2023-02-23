part of 'movie_bloc.dart';

@immutable
class MovieState {
  const MovieState(
      {this.movies = const [],
      this.popularMovies = const [],
      this.searchedMovies = const [],
      this.topRatedMovies = const [],
      this.cast = const [],
      this.popularPage = 0,
      this.topRatedPage = 0});

  final List<Movie> movies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> searchedMovies;
  final List<Cast> cast;
  final int popularPage;
  final int topRatedPage;

  copyWith(
      {List<Movie>? movies,
      List<Movie>? popularMovies,
      List<Movie>? topRatedMovies,
      List<Movie>? searchedMovies,
      List<Cast>? cast,
      int? popularPage,
      int? topRatedPage}) {
    return MovieState(
        movies: movies ?? this.movies,
        topRatedMovies: topRatedMovies != null
            ? [...this.topRatedMovies, ...topRatedMovies]
            : this.topRatedMovies,
        popularMovies: popularMovies != null
            ? [...this.popularMovies, ...popularMovies]
            : this.popularMovies,
        popularPage: popularPage ?? this.popularPage,
        topRatedPage: topRatedPage ?? this.topRatedPage,
        searchedMovies: searchedMovies ?? this.searchedMovies,
        cast: cast ?? this.cast);
  }
}
