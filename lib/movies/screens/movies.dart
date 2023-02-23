import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// States
import 'package:movies/movies/bloc/_blocs.dart';
// Services
import 'package:movies/movies/services/_services.dart';
// Models
import '../../shared/models/_models.dart';
// Widgets
import '../../shared/widgets/_widgets.dart';
import '../widgets/_widgets.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    final size = MediaQuery.of(context).size;
    MovieService.getDisplayMovies(movieBloc);
    MovieService.getPopularsMovies(movieBloc);
    MovieService.getTopRatedMovies(movieBloc);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () => showSearch(
                  context: context, delegate: MoviesSearchDelegate()),
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        _Movies(size: size),
        const _PopularMovies(),
        const _TopRatedMovies()
      ])),
    );
  }
}

class _Movies extends StatelessWidget {
  const _Movies({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.movies != []) {
          return MoviesCardSwiper(movies: state.movies);
        }
        return Loading(width: double.infinity, height: size.height * 0.5);
      },
    );
  }
}

class _TopRatedMovies extends StatelessWidget {
  const _TopRatedMovies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);

    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.popularMovies != []) {
          final data = state.popularMovies
              .map((m) => SliderCardModel(
                  id: m.id,
                  title: m.title,
                  imagePath: m.posterPath,
                  onTap: () => Navigator.pushNamed(context, "movie-detail",
                      arguments: m)))
              .toList();
          return CardSlider(
            title: "Populars",
            cardInfo: data,
            onScroll: () {
              MovieService.getPopularsMovies(movieBloc);
            },
          );
        }
        return const Loading(width: double.infinity, height: 220);
      },
    );
  }
}

class _PopularMovies extends StatelessWidget {
  const _PopularMovies({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);

    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.popularMovies != []) {
          final data = state.topRatedMovies
              .map((m) => SliderCardModel(
                  id: m.id,
                  title: m.title,
                  imagePath: m.posterPath,
                  onTap: () => Navigator.pushNamed(context, "movie-detail",
                      arguments: m)))
              .toList();
          return CardSlider(
            title: "Top rated",
            cardInfo: data,
            onScroll: () {
              MovieService.getTopRatedMovies(movieBloc);
            },
          );
        }
        return const Loading(width: double.infinity, height: 220);
      },
    );
  }
}
