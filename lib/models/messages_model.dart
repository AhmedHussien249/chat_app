import 'package:chat_app/constants/constatnts.dart';

class Message {
  String message;
  String id;

  Message({required this.message, required this.id});

  factory Message.fromJson(json) {
    return Message(message: json[kMessage], id: json['id']);
  }
}
