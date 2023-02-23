import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// Models
import 'package:movies/movies/models/_models.dart';
// Helpers
import 'package:movies/shared/helpers/_helpers.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final StreamController<String> _streamController =
      StreamController.broadcast();
  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  MovieBloc() : super(const MovieState()) {
    // Listeners
    on<OnSetMoviesEvent>((event, emit) {
      emit(state.copyWith(movies: event.movies));
    });
    on<OnSetPopularMoviesEvent>((event, emit) {
      emit(state.copyWith(popularMovies: event.movies));
    });
    on<OnSetTopRatedMoviesEvent>((event, emit) {
      emit(state.copyWith(topRatedMovies: event.movies));
    });
    on<OnSetCastEvent>((event, emit) {
      emit(state.copyWith(cast: event.cast));
    });
    on<OnSearchedMoviedEvent>((event, emit) {
      emit(state.copyWith(searchedMovies: event.movies));
    });
    on<OnIncrementPopularPageEvent>((event, emit) {
      emit(state.copyWith(popularPage: event.popularPage));
    });
    on<OnIncrementTopRatedPageEvent>((event, emit) {
      emit(state.copyWith(topRatedPage: event.topRatedPage));
    });
  }

  Stream<String> get suggestionStream => _streamController.stream;

  getSuggestionByQuery(String searchTerm) {
    debouncer.value = searchTerm;
    debouncer.onValue = (value) {
      _streamController.add(value);
    };
  }
}
