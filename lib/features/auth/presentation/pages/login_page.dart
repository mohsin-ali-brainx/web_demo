import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/app_role.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.from});

  final String? from;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool admin = false;

  @override
  Widget build(BuildContext context) {
    final from = widget.from;

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(from == null ? 'Login to continue.' : 'Login to continue to:\n$from'),
                const SizedBox(height: 16),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: admin,
                  onChanged: (v) => setState(() => admin = v),
                  title: const Text('Login as admin'),
                ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          AuthLoginRequested(
                            role: admin ? AppRole.admin : AppRole.user,
                          ),
                        );
                    final target = (from != null && from.isNotEmpty) ? from : '/app';
                    context.go(target);
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




