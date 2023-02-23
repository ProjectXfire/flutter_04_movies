part of 'movie_bloc.dart';

abstract class MovieEvent {}

class OnSetMoviesEvent extends MovieEvent {
  final List<Movie> movies;
  OnSetMoviesEvent({required this.movies});
}

class OnSetPopularMoviesEvent extends MovieEvent {
  final List<Movie> movies;
  OnSetPopularMoviesEvent({required this.movies});
}

class OnSetTopRatedMoviesEvent extends MovieEvent {
  final List<Movie> movies;
  OnSetTopRatedMoviesEvent({required this.movies});
}

class OnSetCastEvent extends MovieEvent {
  final List<Cast> cast;
  OnSetCastEvent({required this.cast});
}

class OnSearchedMoviedEvent extends MovieEvent {
  final List<Movie> movies;
  OnSearchedMoviedEvent({required this.movies});
}

class OnIncrementPopularPageEvent extends MovieEvent {
  final int popularPage;
  OnIncrementPopularPageEvent({required this.popularPage});
}

class OnIncrementTopRatedPageEvent extends MovieEvent {
  final int topRatedPage;
  OnIncrementTopRatedPageEvent({required this.topRatedPage});
}
