import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeGreeting {
  final String greeting;
  final String subText;

  const HomeGreeting({required this.greeting, required this.subText});
}

final greetingProvider = AsyncNotifierProvider<GreetingNotifier, HomeGreeting>(
  GreetingNotifier.new,
);

class GreetingNotifier extends AsyncNotifier<HomeGreeting> {
  @override
  Future<HomeGreeting> build() async {
    final prefs = await SharedPreferences.getInstance();
    final hasShownWelcome = prefs.getBool('has_shown_welcome') ?? false;

    if (!hasShownWelcome) {
      await prefs.setBool('has_shown_welcome', true);
      return const HomeGreeting(
        greeting: 'Welcome,',
        subText: 'glad you came.',
      );
    }

    return _timeBasedGreeting();
  }

  HomeGreeting _timeBasedGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 4 && hour < 12) {
      return const HomeGreeting(
        greeting: 'Morning,',
        subText: "it's a quiet one.",
      );
    }
    return const HomeGreeting(
      greeting: 'Evening,',
      subText: 'good work today.',
    );
  }
}
