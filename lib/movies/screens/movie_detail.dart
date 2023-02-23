import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// States
import 'package:movies/movies/bloc/_blocs.dart';
// Models
import 'package:movies/movies/models/_models.dart';
import 'package:movies/shared/models/_models.dart';
// Services
import 'package:movies/movies/services/_services.dart';
// Helpers
import 'package:movies/shared/helpers/_helpers.dart';
// Widgets
import 'package:movies/shared/widgets/_widgets.dart';

class MovieDetailScreen extends StatelessWidget {
  const MovieDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;
    final movieBloc = BlocProvider.of<MovieBloc>(context);
    MovieService.getCastMovie(movieBloc, movie.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie.title, movie.posterPath),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(movie.title, movie.originalTitle, movie.voteAverage,
                movie.posterPath, movie.heroId!),
            _Overview(movie.overview),
            BlocBuilder<MovieBloc, MovieState>(
              builder: (context, state) {
                if (state.cast != []) {
                  final data = state.cast
                      .map((c) => SliderCardModel(
                          id: c.id, title: c.name, imagePath: c.profilePath))
                      .toList();
                  return CardSlider(cardInfo: data);
                }
                return const Loading(width: double.infinity, height: 220);
              },
            )
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar(this.movieTitle, this.moviePoster);

  final String movieTitle;
  final String moviePoster;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      pinned: true,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            color: Colors.black.withOpacity(0.2),
            child: Text(
              movieTitle,
              style: const TextStyle(fontSize: 16),
            )),
        background: FadeInImage(
          placeholder: const AssetImage("lib/shared/assets/loading.gif"),
          image: getValidOriginalImage(moviePoster),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle(
      this.title, this.originalTitle, this.average, this.moviePoster, this.id);

  final String id;
  final String title;
  final String originalTitle;
  final double average;
  final String moviePoster;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Hero(
              tag: id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  height: 150,
                  placeholder:
                      const AssetImage("lib/shared/assets/no-image.jpg"),
                  image: getValidOriginalImage(moviePoster),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    originalTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_outline,
                        size: 25,
                        color: Colors.yellow,
                      ),
                      const SizedBox(width: 5),
                      Text(average.toString())
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class _Overview extends StatelessWidget {
  const _Overview(this.movieOverview);

  final String movieOverview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        movieOverview,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
