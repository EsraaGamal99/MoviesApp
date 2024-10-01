import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../logic/movies_cubit.dart';
import 'movie_detail_dcreen.dart';
import 'top_rated_movies_screen.dart';

class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<MovieCubit>().fetchPopularMovies();

    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Popular Movies', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Center(child: Text('Movie App', style: TextStyle(color: Colors.white, fontSize: 24.sp))),
            ),
            ListTile(
              leading: Icon(Icons.movie,color: Colors.teal,),
              title: Text('Popular Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.star,color: Colors.amber,),
              title: Text('Top Rated Movies'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TopRatedMoviesScreen()));
              },
            ),
          ],
        ),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state is MovieLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieLoaded) {
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two movies per row
                childAspectRatio: 0.6, // Adjust aspect ratio for movie posters
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: state.movies.length,
              itemBuilder: (context, index) {
                final movie = state.movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movie: movie),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            height: 210.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              movie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
                          child: Text(
                             'Auther',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is MovieError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No movies available.'));
          }
        },
      ),
    );
  }
}
