import 'package:flutter/material.dart';
import 'package:peliculas20263/models/movie.dart';
import 'package:peliculas20263/widgets/casting_cards.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

@override
  Widget build(BuildContext context) {
    // Aquí recibimos la película completa desde los argumentos
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(movie: movie),
              _Overview(movie: movie),
              CastingCards(movieId: movie.id), // Carrusel de actores
            ]),
          )
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// 1. EL SLIVER APP BAR (La imagen grande que colapsa)
// ----------------------------------------------------
class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200, // Alto de la imagen extendida
      floating: false,
      pinned: true, // Esto hace que al subir, el título se quede fijo en el AppBar
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          color: Colors.black45, // Sombra sutil para leer el texto blanco
          child: Text(
            movie.title,
            style: const TextStyle(fontSize: 16,color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/no-image.jpeg'),
          // Usamos el backdropPath (imagen horizontal) para el fondo
          image: NetworkImage('https://image.tmdb.org/t/p/w500${movie.backdropPath}'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// 2. POSTER PEQUEÑO, TÍTULOS Y ESTRELLAS
// ----------------------------------------------------
class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpeg'),
              image: NetworkImage(movie.fullPosterImg),
              height: 150,
              width: 100, // Ancho fijo para el poster pequeño
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 20),
          
          // ConstrainedBox evita que los textos empujen la pantalla provocando error
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 160),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text(movie.originalTitle, style: textTheme.titleMedium, overflow: TextOverflow.ellipsis, maxLines: 2),
                
                // Las estrellitas
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text('${movie.voteAverage}', style: textTheme.bodySmall)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// 3. LA DESCRIPCIÓN (OVERVIEW)
// ----------------------------------------------------
class _Overview extends StatelessWidget {
  final Movie movie;
  const _Overview({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify, // Texto justificado como en un documento
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}