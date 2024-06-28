import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:recetas/config/theme/app_theme.dart';
import 'package:recetas/presentation/screens/delete/delete_screen.dart';
import 'package:recetas/presentation/screens/user/user_screen.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:recetas/presentation/screens/publication/publication_screen.dart';
import 'package:recetas/presentation/screens/edit/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreenContent(),
    const PublicationScreen(),
    const EditScreen(),
    const DeleteScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App recetas',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.pushNamed(UserScreen.name);
              },
              icon: const Icon(
                Icons.account_circle,
                color: AppTheme.firstColor,
              ))
        ],
      ),
      body: _screens[_currentIndex],
      // floatingActionButton: _currentIndex == 0
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           context.pushNamed(PublicationScreen.name);
      //         },
      //         child: const Icon(
      //           Icons.add,
      //         ),
      //       )
      //     : null,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.secondColor,
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Crear',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Editar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Eliminar',
          ),
        ],
      ),
    );
  }
}

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
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
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
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
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
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
    );
  }
}
