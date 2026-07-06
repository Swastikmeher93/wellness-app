import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider that listens to connectivity changes, seeded with the current state.
final connectivityProvider = StreamProvider<List<ConnectivityResult>>((ref) async* {
  // Fetch and emit the current connectivity immediately to avoid AsyncLoading glitches
  final initial = await Connectivity().checkConnectivity();
  yield initial;

  // Delegate to the stream of connectivity changes
  yield* Connectivity().onConnectivityChanged;
});

/// A boolean provider returning true if the device has no active internet interface.
final isOfflineProvider = Provider<bool>((ref) {
  final connectivityAsync = ref.watch(connectivityProvider);
  return connectivityAsync.maybeWhen(
    data: (results) {
      // In connectivity_plus 6.x, if results contain only 'none', or if the list is empty, we are offline.
      return results.isEmpty || results.contains(ConnectivityResult.none);
    },
    orElse: () => false, // Default to online while loading initial state
  );
});
