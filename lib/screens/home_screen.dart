import 'package:flutter/material.dart';
import 'package:peliculas20263/widgets/MovieSlider.dart';
import 'package:peliculas20263/widgets/card_swiper.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Películas en cines'),
      ),
      body: movieProvider.onDisplayMovies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Tarjetas principales
                  CardSwiper(movies: movieProvider.onDisplayMovies),
                
                  // Slider de películas populares
                  MovieSlider(
                    movies: movieProvider.popularMovies,
                    title: 'Mas populares', // Aquí va el título
                  ),
                ],
              ),
            ),
    );
  }
}