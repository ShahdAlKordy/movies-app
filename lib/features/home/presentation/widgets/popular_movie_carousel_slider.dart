import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/features/home/presentation/manager/popular_cubit/popular_cubit.dart';
import 'package:movie_app/features/home/presentation/widgets/popular_movie_widget.dart';
import 'package:movie_app/features/movie_details/presentation/pages/movie_details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/movie_model.dart';

class PopularMovieCarouselSlider extends StatelessWidget {
  const PopularMovieCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.h,
      child: BlocBuilder<PopularCubit, PopularState>(
        builder: (context, state) {
          if (state is PopularSuccessState) {
            return CarouselSlider.builder(
              itemCount: state.popularMoviesList.length,
              itemBuilder: (context, index, realIndex) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(
                            movieId: state.popularMoviesList[index].id!),
                      ),
                    );
                  },
                  child: PopularMovieCarouselItem(
                      movie: state.popularMoviesList[index]),
                );
              },
              options: CarouselOptions(
                enlargeCenterPage: true,
                pageSnapping: false,

                padEnds: false,
                viewportFraction: 1,
                scrollPhysics: const PageScrollPhysics(),
                // enlargeFactor: 0.5,
                clipBehavior: Clip.none,
                height: 200.h,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                scrollDirection: Axis.horizontal,
              ),
            );
          } else if (state is PopularFailureState) {
            return Center(
              child: Text(state.errorMessage),
            );
          } else {
            return Skeletonizer(
              child: ListView.builder(
                  itemCount: movies.length,
                  itemBuilder: (context, i) {
                    return PopularMovieCarouselItem(movie: movies[i]);
                  }),
            );
          }
        },
      ),
    );
  }
}
