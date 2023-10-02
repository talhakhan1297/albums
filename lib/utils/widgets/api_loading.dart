import 'package:flutter/material.dart';

class APILoading extends StatelessWidget {
  const APILoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator.adaptive());
  }
}
