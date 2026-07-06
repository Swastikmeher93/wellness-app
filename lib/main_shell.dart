import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellness_app/home_view.dart';
import 'package:wellness_app/provider/tab_provider.dart';
import 'package:wellness_app/screens/coming_soon_screen.dart';
import 'package:wellness_app/widgets/bottom_navbar.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedTabProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: selectedIndex == 0
            ? const HomeView(key: ValueKey('home'))
            : const ComingSoonScreen(key: ValueKey('coming_soon')),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
