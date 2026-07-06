import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckInState {
  final bool isFirstTime; // has never checked in before
  final bool isDone;      // checked in within last 7 days

  const CheckInState({required this.isFirstTime, required this.isDone});
}

class CheckInNotifier extends AsyncNotifier<CheckInState> {
  static const _lastCheckInKey = 'last_checkin_date';
  static const _hasEverCheckedInKey = 'has_ever_checked_in';

  @override
  Future<CheckInState> build() async {
    final prefs = await SharedPreferences.getInstance();
    final hasEver = prefs.getBool(_hasEverCheckedInKey) ?? false;

    if (!hasEver) {
      return const CheckInState(isFirstTime: true, isDone: false);
    }

    final saved = prefs.getString(_lastCheckInKey);
    if (saved == null) {
      return const CheckInState(isFirstTime: false, isDone: false);
    }

    final lastDate = DateTime.parse(saved);
    final daysSince = DateTime.now().difference(lastDate).inDays;
    final isDone = daysSince < 7;

    return CheckInState(isFirstTime: false, isDone: isDone);
  }

  Future<void> markDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasEverCheckedInKey, true);
    await prefs.setString(_lastCheckInKey, DateTime.now().toIso8601String());
    state = const AsyncData(CheckInState(isFirstTime: false, isDone: true));
  }
}

final checkInProvider =
    AsyncNotifierProvider<CheckInNotifier, CheckInState>(CheckInNotifier.new);
