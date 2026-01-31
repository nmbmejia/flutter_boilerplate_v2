import 'package:flutter/material.dart';

/// Centered loading indicator for reuse across features.
class CommonLoading extends StatelessWidget {
  const CommonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
