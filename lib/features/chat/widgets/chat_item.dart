import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.text,
    required this.isMe,
    required this.imageUrl,
  });
  final String text;
  final bool isMe;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            width: text.contains("Loading...") ? 64 : null,
            height: text.contains("Loading...") ? 64 : null,
            padding: text.contains("https://storage.googleapis.com")
                ? EdgeInsets.zero
                : const EdgeInsets.all(12),
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            decoration: BoxDecoration(
              color: !isMe ? Theme.of(context).primaryColor : null,
              gradient: isMe
                  ? LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    )
                  : null,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: Radius.circular(isMe ? 12 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 12),
              ),
            ),
            child: text.contains("Loading...")
                ? Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    height: 256,
                    width: 256,
                    child: const CircularProgressIndicator(),
                  )
                : text.contains("https://storage.googleapis.com")
                    ? GestureDetector(
                        onTap: () {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(12),
                            topRight: const Radius.circular(12),
                            bottomLeft: Radius.circular(isMe ? 12 : 0),
                            bottomRight: Radius.circular(isMe ? 0 : 12),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image(
                                image: NetworkImage(imageUrl),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Text(
                        text,
                        style: TextStyle(color: isMe ? Colors.white : null),
                      ),
          ),
          //if (isMe) const SizedBox(width: 15),
        ],
      ),
    );
  }
}
