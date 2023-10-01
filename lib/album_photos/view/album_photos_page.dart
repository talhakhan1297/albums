import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AlbumPhotosPage extends StatelessWidget {
  const AlbumPhotosPage({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Album Photos'),
            TextButton(
              onPressed: () {
                context.router.pop();
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
