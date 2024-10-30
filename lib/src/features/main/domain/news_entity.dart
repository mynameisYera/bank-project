import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NewsEntity extends Equatable {
  final String desc;
  final List<String> images;

  const NewsEntity({
    required this.desc,
    required this.images,
  });

  factory NewsEntity.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final String desc = data['desc'] is String ? data['desc'] as String : '';

    final List<String> images = data['images'] is List
        ? List<String>.from(data['images'])
        : [
            'https://media.licdn.com/dms/image/v2/C4D0BAQFQWpVqplhTNw/company-logo_200_200/company-logo_200_200/0/1675919090704/jihc_logo?e=2147483647&v=beta&t=boK6D8pjWfcTNVa0nf9Xx5BXQ2zkOBLH5WiYfEeXZYI'
          ];

    return NewsEntity(
      desc: desc,
      images: images,
    );
  }

  static List<NewsEntity> fromDocumentList(List<DocumentSnapshot> items) {
    return items.map((doc) => NewsEntity.fromDocument(doc)).toList();
  }

  @override
  List<Object?> get props => [desc, images];
}
