import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String messages;
  final String username;

  const MessageEntity({
    required this.username,
    required this.messages,
  });

  factory MessageEntity.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageEntity(
      messages: data['message'] ?? '',
      username: data['username'] ?? '',
    );
  }

  static List<MessageEntity> fromDocumentList(List<DocumentSnapshot> items) {
    return items.map((DocumentSnapshot doc) {
      return MessageEntity.fromDocument(doc);
    }).toList();
  }

  @override
  List<Object?> get props => [messages, username];
}
