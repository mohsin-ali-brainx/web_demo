import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
    required this.matchedLocation,
  });

  final Widget child;
  final String matchedLocation;

  int _selectedIndex(String location) {
    if (location.startsWith('/app/orders')) return 1;
    if (location.startsWith('/app/products')) return 2;
    if (location.startsWith('/app/settings')) return 3;
    if (location.startsWith('/app/admin')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final wide = width >= 900;
    final selected = _selectedIndex(matchedLocation);

    void goIndex(int index) {
      if (index == 0) context.go('/app');
      if (index == 1) context.go('/app/orders?status=all');
      if (index == 2) context.go('/app/products');
      if (index == 3) context.go('/app/settings');
      if (index == 4) context.go('/app/admin');
    }

    final rail = NavigationRail(
      selectedIndex: selected,
      onDestinationSelected: goIndex,
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: Text('Dashboard'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.receipt_long_outlined),
          selectedIcon: Icon(Icons.receipt_long),
          label: Text('Orders'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.inventory_2_outlined),
          selectedIcon: Icon(Icons.inventory_2),
          label: Text('Products'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text('Settings'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.admin_panel_settings_outlined),
          selectedIcon: Icon(Icons.admin_panel_settings),
          label: Text('Admin'),
        ),
      ],
    );

    final drawer = Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) => ListTile(
                title: Text('Role: ${state.session?.role.name ?? 'none'}'),
                subtitle: const Text('ShellRoute'),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selected: selected == 0,
              onTap: () {
                Navigator.of(context).pop();
                context.go('/app');
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Orders'),
              selected: selected == 1,
              onTap: () {
                Navigator.of(context).pop();
                context.go('/app/orders?status=all');
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory_2),
              title: const Text('Products'),
              selected: selected == 2,
              onTap: () {
                Navigator.of(context).pop();
                context.go('/app/products');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              selected: selected == 3,
              onTap: () {
                Navigator.of(context).pop();
                context.go('/app/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.admin_panel_settings),
              title: const Text('Admin'),
              selected: selected == 4,
              onTap: () {
                Navigator.of(context).pop();
                context.go('/app/admin');
              },
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Shell'),
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) => Center(
              child: Text('Role: ${state.session?.role.name ?? 'none'}  '),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(const AuthLogoutRequested());
              context.go('/');
            },
            child: const Text('Logout'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: wide ? null : drawer,
      body: Row(
        children: [
          if (wide) rail,
          Expanded(child: child),
        ],
      ),
    );
  }
}




