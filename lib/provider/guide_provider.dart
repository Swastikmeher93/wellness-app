import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellness_app/model/guide_model.dart';

final guideProvider = FutureProvider<List<GuideModel>>((ref) async {
  try {
    debugPrint('🔄 Fetching guides from Firestore...');

    final snapshot = await FirebaseFirestore.instance
        .collection('guides')
        .get();

    debugPrint('📦 Raw docs count: ${snapshot.docs.length}');

    if (snapshot.docs.isEmpty) {
      debugPrint('⚠️ No documents found in the guides collection.');
      return [];
    }

    final guides = snapshot.docs
        .map((doc) => GuideModel.fromFirestore(doc))
        .toList();

    debugPrint('✅ Successfully mapped ${guides.length} guide(s)');
    return guides;
  } catch (e, stack) {
    debugPrint('❌ Error fetching guides: $e');
    debugPrint('🪲 StackTrace: $stack');
    rethrow;
  }
});