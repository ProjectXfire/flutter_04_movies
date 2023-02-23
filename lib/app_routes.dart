import 'package:flutter/material.dart';
// Models
import 'package:movies/shared/models/_models.dart';
// Routes
import 'movies/routes.dart';

class AppRoutes {
  static final appRoutes = <RouteModel>[
    ...MovieRoutes.routes,
  ];

  static Map<String, Widget Function(BuildContext)> generateRoutes() {
    Map<String, Widget Function(BuildContext)> routes = {};
    for (var route in appRoutes) {
      routes.addAll({route.name: (p0) => route.screen});
    }
    return routes;
  }
}
