import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FieldChat extends StatefulWidget {
  const FieldChat({
    super.key,
    required this.controller,
    required this.sendMessage,
  });
  final TextEditingController controller;

  final VoidCallback sendMessage;

  @override
  State<FieldChat> createState() => _FieldChatState();
}

class _FieldChatState extends State<FieldChat> {
  bool sendButtonPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                right: 14,
                left: 14,
                top: 8),
            child: Row(
              children: [
                const SizedBox(width: 4),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Message...',
                      hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).hoverColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      sendButtonPressed = true;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      sendButtonPressed = false;
                    });
                  },
                  onTapUp: (details) async {
                    HapticFeedback.lightImpact();
                    setState(() {
                      sendButtonPressed = false;
                    });
                    widget.sendMessage();
                  },
                  child: AnimatedOpacity(
                    opacity: sendButtonPressed ? .7 : 1,
                    curve: Curves.linear,
                    duration: const Duration(milliseconds: 200),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.grey, Colors.black54],
                                begin: Alignment.bottomLeft,
                                end: Alignment.centerRight,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.send,
                              color: Theme.of(context).primaryColor,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const MarginBottom(),
        ],
      ),
    );
  }
}

class MarginBottom extends StatelessWidget {
  const MarginBottom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: false,
      minimum: EdgeInsets.only(bottom: 8),
      child: SizedBox(),
    );
  }
}
