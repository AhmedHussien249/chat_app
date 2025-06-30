import 'package:bloc/bloc.dart';
import 'package:chat_app/constants/constatnts.dart';
import 'package:chat_app/models/messages_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  List<Message> messagesList = [];

  Future<void> sendMessage({required message, required email}) async {
    try {
      messages
          .add({kMessage: message, kCreatedAt: DateTime.now(), 'id': email});
    } on Exception catch (e) {
      // TODO
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        print('doc: $doc');
        messagesList.add(Message.fromJson(doc));
      }
      print('success');
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
