import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas/config/theme/app_theme.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:recetas/presentation/screens/publication/publication_screen.dart';

class HomeScreen extends StatelessWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas Publicadas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(PublicationScreen.name);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('recetas')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay recetas publicadas.'));
          }

          final recetas = snapshot.data!.docs;

          return ListView.builder(
            itemCount: recetas.length,
            itemBuilder: (context, index) {
              final receta = recetas[index];
              final videoUrl = receta['videoUrl'] as String;
              final videoId = YoutubePlayerController.convertUrlToId(videoUrl);

              return index != recetas.length - 1
                  ? Card(
                      color: AppTheme.unselectedColor,
                      margin: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              receta['nombre'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (videoId != null)
                            YoutubePlayerIFrame(
                              controller: YoutubePlayerController(
                                initialVideoId: videoId,
                                params: const YoutubePlayerParams(
                                  showControls: true,
                                  showFullscreenButton: true,
                                ),
                              ),
                              aspectRatio: 16 / 9,
                            ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(receta['descripcion']),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 250),
                      child: Card(
                        color: AppTheme.unselectedColor,
                        margin: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                receta['nombre'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            if (videoId != null)
                              YoutubePlayerIFrame(
                                controller: YoutubePlayerController(
                                  initialVideoId: videoId,
                                  params: const YoutubePlayerParams(
                                    showControls: true,
                                    showFullscreenButton: true,
                                  ),
                                ),
                                aspectRatio: 16 / 9,
                              ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(receta['descripcion']),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
