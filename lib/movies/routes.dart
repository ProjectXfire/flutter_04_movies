// Models
import 'package:movies/shared/models/_models.dart';
// Screens
import 'package:movies/movies/screens/_screens.dart';

class MovieRoutes {
  static final routes = <RouteModel>[
    RouteModel(name: "movies", screen: const MoviesScreen()),
    RouteModel(name: "movie-detail", screen: const MovieDetailScreen())
  ];
}
