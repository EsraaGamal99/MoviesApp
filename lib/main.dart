import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/moviesScreen/data/repos/movies_list_repo.dart';
import 'features/moviesScreen/logic/movies_cubit.dart';
import 'features/moviesScreen/ui/movie_list_screen.dart';


void main() {
  final movieService = MovieService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovieCubit(movieService),  // Provide the cubit
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        home: MovieListScreen(),
      ),
    );
  }
}
