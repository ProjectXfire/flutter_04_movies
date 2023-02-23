import 'package:flutter/material.dart';
// External widgets
import 'package:card_swiper/card_swiper.dart';
// Models
import 'package:movies/movies/models/_models.dart';
// Helpers
import 'package:movies/shared/helpers/_helpers.dart';

class MoviesCardSwiper extends StatelessWidget {
  const MoviesCardSwiper({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: Swiper(
          itemCount: movies.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.width * 0.9,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, "movie-detail",
                  arguments: movies[i]),
              child: Hero(
                tag: movies[i].heroId!,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                    placeholder:
                        const AssetImage("lib/shared/assets/no-image.jpg"),
                    image: getValidOriginalImage(movies[i].posterPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ));
  }
}
