import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Public Home')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Public routes: /, /about, /login\nProtected shell: /app/*',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.go('/about'),
                  child: const Text('Go to About'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => context.go('/login'),
                  child: const Text('Go to Login'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () => context.go('/app'),
                  child: const Text('Go to /app (requires auth)'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => context.go('/app/admin'),
                  child: const Text('Go to /app/admin (admin only)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




