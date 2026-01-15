import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Dashboard: protected route inside ShellRoute.'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/app/orders?status=pending'),
                child: const Text('Go to Orders (query param)'),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => context.go('/app/products/101'),
                child: const Text('Go to Product 101 (path param)'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => context.go('/does-not-exist'),
                child: const Text('Trigger 404'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




