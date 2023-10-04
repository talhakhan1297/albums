import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget(this.errorMessage, {required this.onTryAgain, super.key});

  final String? errorMessage;
  final void Function()? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning, color: Colors.redAccent),
                const SizedBox(width: 8),
                Flexible(child: Text(errorMessage ?? 'Something went wrong!')),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onTryAgain,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
