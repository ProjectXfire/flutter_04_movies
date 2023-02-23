import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// States
import 'package:flutter_bloc/flutter_bloc.dart';
// Routes
import 'package:movies/app_routes.dart';
import 'package:movies/movies/bloc/_blocs.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => MovieBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.light()
            .copyWith(appBarTheme: const AppBarTheme(color: Colors.green)),
        initialRoute: "movies",
        routes: AppRoutes.generateRoutes(),
      ),
    );
  }
}
