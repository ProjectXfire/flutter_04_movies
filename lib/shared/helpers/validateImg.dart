import 'package:flutter/material.dart';

ImageProvider<Object> getValidOriginalImage(String? posterPath) {
  if (posterPath != null) {
    return NetworkImage("https://image.tmdb.org/t/p/original$posterPath");
  }
  return const AssetImage("lib/shared/assets/no-image.jpg");
}

ImageProvider<Object> getValidW500Image(String? posterPath) {
  if (posterPath != null) {
    return NetworkImage("https://image.tmdb.org/t/p/w500$posterPath");
  }
  return const AssetImage("lib/shared/assets/no-image.jpg");
}
