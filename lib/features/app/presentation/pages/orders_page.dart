import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key, required this.status});

  final String? status;

  @override
  Widget build(BuildContext context) {
    final s = status ?? 'none';

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Orders\nstatus=$s'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/app/orders?status=all'),
                child: const Text('status=all'),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => context.go('/app/orders?status=pending'),
                child: const Text('status=pending'),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () => context.go('/app/orders?status=completed'),
                child: const Text('status=completed'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




