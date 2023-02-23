import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// States
import 'package:movies/movies/bloc/_blocs.dart';
import 'package:movies/movies/models/movie.dart';
// Services
import 'package:movies/movies/services/_services.dart';
import 'package:movies/shared/helpers/_helpers.dart';

class MoviesSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Search movies";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () => query = "", icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text("Results");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final movieBloc = BlocProvider.of<MovieBloc>(context);

    if (query.isEmpty) {
      return const _EmptyList();
    }

    movieBloc.getSuggestionByQuery(query);

    return StreamBuilder(
      stream: movieBloc.suggestionStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData) return const _EmptyList();
        final term = snapshot.data!;
        MovieService.getSearchMovies(movieBloc, term);
        return BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state.searchedMovies.isNotEmpty) {
              final movies = state.searchedMovies;
              return ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, i) => _MoviesList(movie: movies[i]));
            }
            return const _EmptyList();
          },
        );
      },
    );
  }
}

class _MoviesList extends StatelessWidget {
  const _MoviesList({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: FadeInImage(
            width: 50,
            fit: BoxFit.cover,
            placeholder: const AssetImage("lib/shared/assets/no-image.jpg"),
            image: getValidOriginalImage(movie.posterPath)),
        title: Text(movie.title, overflow: TextOverflow.ellipsis),
        subtitle: Text(movie.originalTitle),
        onTap: () =>
            Navigator.pushNamed(context, "movie-detail", arguments: movie));
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        child: Center(
            child: Icon(
      Icons.movie_creation_outlined,
      color: Colors.green,
      size: 100,
    )));
  }
}

/*
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state.searchedMovies.isNotEmpty) {
          final movies = state.searchedMovies;
          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, i) => _MoviesList(movie: movies[i]));
        }
        return const _EmptyList();
      },
    );
 */