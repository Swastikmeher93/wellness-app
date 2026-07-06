import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellness_app/model/greeting_model.dart';
import 'package:wellness_app/provider/checkin_provider.dart';
import 'package:wellness_app/provider/guide_provider.dart';
import 'package:wellness_app/provider/home_view_provider.dart';
import 'package:wellness_app/widgets/checkin_card.dart';
import 'package:wellness_app/widgets/guide_card.dart';
import 'package:wellness_app/widgets/review_card.dart';
import 'package:wellness_app/widgets/offline_card.dart';
import 'package:wellness_app/provider/connectivity_provider.dart';


class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  static const _firstCheckInCard = GreetingModel(
    title: 'Your first check-in.',
    description: "Five minutes. There's no wrong answer here.",
    ctaText: 'Begin',
  );

  static const _weeklyCard = GreetingModel(
    title: 'Five quiet minutes.',
    description:
        'Your weekly check-in is ready when you are. No pressure to do it now.',
    ctaText: 'Begin',
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greetingAsync = ref.watch(greetingProvider);
    final checkIn = ref.watch(checkInProvider);
    final guidesAsync = ref.watch(guideProvider);
    final isOffline = ref.watch(isOfflineProvider);


    final cardModel = switch (checkIn) {
      AsyncData(:final value) =>
        value.isFirstTime ? _firstCheckInCard : _weeklyCard,
      _ => _firstCheckInCard,
    };

    return Column(
      children: [
        if (isOffline) const OfflineCard(),
        Expanded(
          child: CustomScrollView(
            slivers: [

        // ── Scrolling AppBar ────────────────────────────────────────
        SliverAppBar(
          backgroundColor: const Color(0xFFF5F5F5),
          surfaceTintColor: Colors.transparent,
          floating: true,
          snap: true,
          elevation: 0,
          toolbarHeight: 56,
          primary: !isOffline,
          centerTitle: false,
          titleSpacing: 16,
          title: Align(
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              'assets/icons/logo.svg',
              width: 38,
              height: 16,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Center(
                    child: Text(
                      'H',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // ── Page content ────────────────────────────────────────────
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 32),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                greetingAsync.when(
                  data: (data) {
                    final isWelcome = data.greeting == 'Welcome,';
                    final greetingText = isWelcome
                        ? '${data.greeting}\nHarsh.'
                        : '${data.greeting} Harsh.';
                    final isDone = switch (checkIn) {
                      AsyncData(:final value) => value.isDone,
                      _ => false,
                    };
                    final subText = isDone ? 'good work today.' : data.subText;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          greetingText,
                          style: GoogleFonts.newsreader(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 4),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: Text(
                            subText,
                            key: ValueKey(subText),
                            style: GoogleFonts.caveat(
                              color: Colors.black54,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                ),
                const SizedBox(height: 28),

                // Section label
                Text(
                  switch (checkIn) {
                    AsyncData(:final value) =>
                      value.isFirstTime ? 'START HERE' : 'THIS WEEK',
                    _ => 'START HERE',
                  },
                  style: GoogleFonts.newsreader(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                CheckinCard(model: cardModel),

                const SizedBox(height: 32),

                // ── Guides section ────────────────────────────────────
                Text(
                  switch (checkIn) {
                    AsyncData(:final value) =>
                      value.isDone
                          ? 'PICK UP WHERE YOU LEFT OFF'
                          : "THIS WEEK'S GUIDES",
                    _ => "THIS WEEK'S GUIDES",
                  },
                  style: GoogleFonts.newsreader(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45,
                    letterSpacing: 1.2,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 10),

                guidesAsync.when(
                  data: (guides) {
                    final isDone = switch (checkIn) {
                      AsyncData(:final value) => value.isDone,
                      _ => false,
                    };
                    final displayGuides = isDone
                        ? guides.take(1).toList()
                        : guides;
                    if (displayGuides.isEmpty) return const SizedBox.shrink();

                    final firstGuide = displayGuides.first;
                    final restGuides = displayGuides.skip(1).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // First guide card
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: GuideCard(guide: firstGuide),
                        ),

                        // FROM YOUR GUIDES label + remaining cards
                        const SizedBox(height: 16),
                        if (restGuides.isNotEmpty) ...[
                          Text(
                            'FROM YOUR GUIDES',
                            style: GoogleFonts.newsreader(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.black45,
                              letterSpacing: 1.2,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...restGuides.map(
                            (guide) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: GuideCard(guide: guide),
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                  loading: () => const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: CircularProgressIndicator(strokeWidth: 1.5),
                    ),
                  ),
                  error: (e, _) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Could not load guides.',
                      style: GoogleFonts.newsreader(
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ),

                // ── Review card (post check-in only) ──────────────────
                if (switch (checkIn) {
                  AsyncData(:final value) => value.isDone,
                  _ => false,
                }) ...[  
                  const SizedBox(height: 24),
                  const ReviewCard(),
                ],
              ],
            ),
          ),
        ),
      ],
    ),
  ),
],
);
  }
}
