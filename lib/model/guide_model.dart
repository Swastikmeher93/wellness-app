import 'package:cloud_firestore/cloud_firestore.dart';

class GuideModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdAt;
  final bool isPaid;
  final bool isActive;
  final int price;

  const GuideModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.isPaid,
    required this.isActive,
    required this.price,
  });

  factory GuideModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GuideModel(
      id: doc.id,
      title: data['title'] as String? ?? '',
      description: data['description'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isPaid: data['isPaid'] as bool? ?? false,
      isActive: data['isActive'] as bool? ?? true,
      price: (data['price'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
      'isPaid': isPaid,
      'isActive': isActive,
      'price': price,
    };
  }
}
