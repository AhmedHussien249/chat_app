import 'package:chat_app/pages/cubits/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  //List<Message> messagesList = [];
  static String id = 'ChatPage';

  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png', height: 40),
            const Text('Scholar Chat'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) =>
                      messagesList[index].id == email
                          ? ChatBubble(
                              message: messagesList[index],
                            )
                          : ChatBubbleFromFriend(
                              message: messagesList[index],
                            ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).sendMessage(
                  message: data,
                  email: email,
                );
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.easeIn,
                );
                // a el fr2 b2a bean el animate to w el jump to
                // el jump to msh bta5od duration wla curve
                // hya btt7rk mra w7da le el 7aga el nta m7dhha
              },
              decoration: InputDecoration(
                  hintText: 'Type a message',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      BlocProvider.of<ChatCubit>(context).sendMessage(
                        message: controller.text,
                        email: email,
                      );
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: const Duration(milliseconds: 1),
                        curve: Curves.easeIn,
                      );
                    },
                  )),
            ),
          )
        ],
      ),
    );
  }
}
  


// future builder 5od balk mn 7aga enha msh htbny el ui 8er lma tla2y el baynat
// aw el shar el nta m7ddo y3ni
// fa hya mmkn tbny el widget mrten mra w hya btnfz el el shart el mfesh f el
// el baynat w mra lma el baynat tegy
