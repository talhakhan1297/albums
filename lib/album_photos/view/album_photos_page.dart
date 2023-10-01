import 'package:flutter/material.dart';

class AlbumPhotosPage extends StatelessWidget {
  const AlbumPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Album Photos'),
          TextButton(onPressed: () {}, child: const Text('Go Back')),
        ],
      ),
    );
  }
}
