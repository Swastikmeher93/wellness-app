import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wellness_app/provider/tab_provider.dart';

class BottomNavbar extends ConsumerWidget {
  const BottomNavbar({super.key});

  // Icon order: 5, 1, 2, 3, 4
  static const List<String> _iconPaths = [
    'assets/icons/icon (5).svg',
    'assets/icons/icon (1).svg',
    'assets/icons/icon (2).svg',
    'assets/icons/icon (3).svg',
    'assets/icons/icon (4).svg',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedTabProvider);

    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_iconPaths.length, (index) {
          final bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => ref.read(selectedTabProvider.notifier).setTab(index),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 48,
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSlide(
                    offset: isSelected
                        ? const Offset(0, -0.15)
                        : Offset.zero,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    child: SvgPicture.asset(
                      _iconPaths[index],
                      width: 24,
                      height: 24,
                      colorFilter: isSelected
                          ? const ColorFilter.mode(
                              Color(0xFF131212),
                              BlendMode.srcIn,
                            )
                          : const ColorFilter.mode(
                              Color(0x66131212),
                              BlendMode.srcIn,
                            ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOut,
                    width: isSelected ? 4 : 0,
                    height: isSelected ? 4 : 0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFA8A151),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
