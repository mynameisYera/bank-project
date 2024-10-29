import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NextBookEntity extends Equatable {
  final String name;
  final int page;
  final int vote;

  const NextBookEntity({
    required this.name,
    required this.page,
    required this.vote,
  });

  factory NextBookEntity.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NextBookEntity(
      name: data['name'] ?? '',
      page: data['page'] ?? 0,
      vote: data['vote'] ?? 0,
    );
  }

  static List<NextBookEntity> fromDocumentList(List<DocumentSnapshot> items) {
    return items.map((DocumentSnapshot doc) {
      return NextBookEntity.fromDocument(doc);
    }).toList();
  }

  @override
  List<Object?> get props => [name, page, vote];
}