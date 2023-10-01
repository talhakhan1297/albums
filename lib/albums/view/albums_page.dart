import 'package:flutter/material.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Albums'),
          TextButton(onPressed: () {}, child: const Text('Go to Album Photos')),
          TextButton(onPressed: () {}, child: const Text('Go Back')),
        ],
      ),
    );
  }
}
