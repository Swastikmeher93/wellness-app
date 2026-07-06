import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellness_app/model/greeting_model.dart';
import 'package:wellness_app/provider/checkin_provider.dart';

class CheckinCard extends ConsumerWidget {
  final GreetingModel model;

  const CheckinCard({super.key, required this.model});

  static const _doneTitle = 'Done for the week.';
  static const _doneDescription =
      "Next one's ready Sunday.\nWe'll keep things quiet until then.";

  Future<void> _handleTap(WidgetRef ref) async {
    await ref.read(checkInProvider.notifier).markDone();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIn = ref.watch(checkInProvider);
    final isDone = switch (checkIn) {
      AsyncData(:final value) => value.isDone,
      _ => false,
    };

    return GestureDetector(
      onTap: isDone ? null : () => _handleTap(ref),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              switchInCurve: Curves.easeOut,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.06),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: isDone ? _buildDone() : _buildInitial(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDone() {
    return Column(
      key: const ValueKey('done'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.check, size: 22, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              _doneTitle,
              style: GoogleFonts.newsreader(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          _doneDescription,
          style: GoogleFonts.newsreader(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildInitial() {
    return Column(
      key: const ValueKey('initial'),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          model.title,
          style: GoogleFonts.newsreader(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          model.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.newsreader(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text(
              model.ctaText,
              style: GoogleFonts.newsreader(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.arrow_forward, size: 16, color: Colors.black),
          ],
        ),
      ],
    );
  }
}
