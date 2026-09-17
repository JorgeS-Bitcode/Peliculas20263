import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieSlider extends StatelessWidget {
  final List<Movie> movies;
  final String? title;

  const MovieSlider({
    super.key, 
    required this.movies, 
    this.title
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Si no hay título, no muestra este widget
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title!,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          
          const SizedBox(height: 5),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (_, int index) => _MoviePoster(movie: movies[index]),
            ),
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpeg'),
            image: NetworkImage(movie.fullPosterImg), // Descarga la imagen[cite: 3]
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}