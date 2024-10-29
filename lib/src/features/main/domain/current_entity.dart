import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CurrentEntity extends Equatable {
  final String bookName;
  final String image;
  final int page;

  const CurrentEntity({
    required this.image,
    required this.page,
    required this.bookName,
  });

  factory CurrentEntity.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CurrentEntity(
      bookName: data['bookName'] ?? '',
      image: data['image'] ?? '',
      page: data['page'] ?? 0,
    );
  }

  static List<CurrentEntity> fromDocumentList(List<DocumentSnapshot> items) {
    return items.map((DocumentSnapshot doc) {
      return CurrentEntity.fromDocument(doc);
    }).toList();
  }

  @override
  List<Object?> get props => [bookName, image];
}
