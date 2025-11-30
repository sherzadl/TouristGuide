import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    final isDark = mode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Theme.of(context).cardColor,
            ),
            child: Row(
              children: [
                Icon(
                  isDark ? Icons.dark_mode : Icons.light_mode,
                  size: 22,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    "Dark Mode",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                Switch(
                  value: isDark,
                  onChanged: (v) =>
                      ref.read(themeModeProvider.notifier).toggle(v),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Optional system mode button
          TextButton(
            onPressed: () =>
                ref.read(themeModeProvider.notifier).setSystem(),
            child: const Text("Use system theme"),
          ),
        ],
      ),
    );
  }
}
