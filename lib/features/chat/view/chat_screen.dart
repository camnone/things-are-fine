import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

import 'package:thingsarefine/features/chat/widgets/chat_input.dart';
import 'package:thingsarefine/features/chat/widgets/chat_item.dart';
import 'package:thingsarefine/repositories/app/app_repository.dart';
import 'package:thingsarefine/repositories/chat/chat_repository.dart';

import 'package:thingsarefine/ui/ui.dart';

@RoutePage()
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appRepository = GetIt.I<AppRepository>();
    final chatRepository = GetIt.I<ChatRepository>();

    return CustomScrollView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        const CustomAppBar(title: "Assistant", chatScreen: true),
        SliverFillRemaining(
          child: Column(children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("chats")
                    .where("userID",
                        isEqualTo: appRepository.getValue(appRepository.uidKey))
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data?.docs;

                    data!.sort((a, b) {
                      return ((b.data()["timestamp"]) as Timestamp).seconds -
                          ((a.data()["timestamp"]) as Timestamp).seconds;
                    });

                    return Expanded(
                      child: snapshot.data!.docs.isNotEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.only(bottom: 0, top: 8),
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return _buildMessageItem(data[index]);
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.asset("assets/lottie/assistant.json",
                                    animate: true, width: 200),
                                Text(
                                  "Hi! It's an Taskon!",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text("He will help you make a list of tasks!",
                                    style:
                                        Theme.of(context).textTheme.bodySmall)
                              ],
                            ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Lottie.asset("assets/lottie/assistant.json",
                              animate: true, width: 200),
                          Text(
                            "Hi! It's an Taskon!",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text("Error",
                              style: Theme.of(context).textTheme.bodySmall)
                        ],
                      ),
                    );
                  }

                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lottie/assistant.json",
                            animate: true, width: 200),
                        Text(
                          "Hi! It's an Taskon!",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text("Loading...",
                            style: Theme.of(context).textTheme.bodySmall)
                      ],
                    ),
                  );
                }),
            FieldChat(
                controller: chatController,
                sendMessage: () async {
                  if (chatController.text.isNotEmpty) {
                    final message = chatController.text;
                    chatController.clear();
                    await chatRepository.sendUserMessage(message);
                    await chatRepository.sendBotMessage(message);
                  }
                })
          ]),
        ),
      ],
    );
  }

  Widget _buildMessageItem(
    document,
  ) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    bool botMessage = true;
    if (data['isUser'] == true) {
      botMessage = true;
    } else {
      botMessage = false;
    }

    var alignment = (data['isUser'] == false)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ChatItem(
            text: data['message'],
            isMe: botMessage,
            imageUrl:
                "https://w.forfun.com/fetch/94/94cb9ddc5a283a2f72cc0d9573845240.jpeg"),
      ),
    );
  }
}
