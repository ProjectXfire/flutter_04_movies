import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
// States
import 'package:movies/movies/bloc/movie/movie_bloc.dart';
// Models
import 'package:movies/movies/models/_models.dart';

final String _apiKey = dotenv.env["MOVIEDB_API_KEY"] as String;
final String _baseUrl = dotenv.env["MOVIEDB_URL"] as String;
const String _language = "es-ES";

//String segment, [int page = 1]

class MovieService {
  static Future<String> _getJsonData(
      {required String segment, int page = 1, String? query}) async {
    if (query == null) {
      final url = Uri.https(_baseUrl, segment,
          {"api_key": _apiKey, "language": _language, "page": "$page"});
      final response = await http.get(url);
      return response.body;
    }
    final url = Uri.https(_baseUrl, segment, {
      "api_key": _apiKey,
      "language": _language,
      "page": "$page",
      "query": query
    });
    final response = await http.get(url);
    return response.body;
  }

  static getDisplayMovies(MovieBloc movieBloc) async {
    try {
      final movieJson = await _getJsonData(segment: "/3/movie/now_playing");
      final moviesRes = MoviesResponse.fromRawJson(movieJson);
      final movies = <Movie>[];
      for (var m in moviesRes.results) {
        m.heroId = "swiper-${m.id}";
        movies.add(m);
      }
      movieBloc.add(OnSetMoviesEvent(movies: movies));
    } catch (e) {
      print(e.toString());
    }
  }

  static getPopularsMovies(MovieBloc movieBloc) async {
    try {
      int page = movieBloc.state.popularPage;
      page++;
      final movieJson =
          await _getJsonData(segment: "/3/movie/popular", page: page);
      final moviesRes = PopularMoviesResponse.fromRawJson(movieJson);
      final movies = <Movie>[];
      for (var m in moviesRes.results) {
        m.heroId = "slider-${m.id}";
        movies.add(m);
      }
      movieBloc.add(OnSetPopularMoviesEvent(movies: movies));
      movieBloc.add(OnIncrementPopularPageEvent(popularPage: page));
    } catch (e) {
      print(e.toString());
    }
  }

  static getTopRatedMovies(MovieBloc movieBloc) async {
    try {
      int page = movieBloc.state.topRatedPage;
      page++;
      final movieJson =
          await _getJsonData(segment: "/3/movie/top_rated", page: page);
      final moviesRes = PopularMoviesResponse.fromRawJson(movieJson);
      final movies = <Movie>[];
      for (var m in moviesRes.results) {
        m.heroId = "slider-${m.id}";
        movies.add(m);
      }
      movieBloc.add(OnSetTopRatedMoviesEvent(movies: movies));
      movieBloc.add(OnIncrementTopRatedPageEvent(topRatedPage: page));
    } catch (e) {
      print(e.toString());
    }
  }

  static getCastMovie(MovieBloc movieBloc, int id) async {
    try {
      final castJson = await _getJsonData(segment: '/3/movie/$id/credits');
      final castResp = ActorsResponse.fromRawJson(castJson);
      movieBloc.add(OnSetCastEvent(cast: castResp.cast));
    } catch (e) {
      print(e.toString());
    }
  }

  static getSearchMovies(MovieBloc movieBloc, String query) async {
    try {
      final searchedMoviesJson =
          await _getJsonData(segment: "/3/search/movie", query: query);
      final searchedMoviesRes =
          PopularMoviesResponse.fromRawJson(searchedMoviesJson);
      movieBloc.add(OnSearchedMoviedEvent(movies: searchedMoviesRes.results));
    } catch (e) {
      print(e.toString());
    }
  }
}
