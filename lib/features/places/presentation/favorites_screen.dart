import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFFFFB64D),
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: const Color(0xFFFFB64D),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite, size: 96, color: Colors.white.withOpacity(.6)),
            const SizedBox(height: 12),
            Text("You don't have any\nfavorite places yet",
                style: t.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
