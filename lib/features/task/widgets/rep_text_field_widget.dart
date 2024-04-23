import 'package:flutter/material.dart';

class RepTextField extends StatelessWidget {
  const RepTextField({
    super.key,
    required this.controller,
    this.isForDescription = false,
  });

  final TextEditingController controller;
  final bool isForDescription;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      child: ListTile(
        title: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: isForDescription ? InputBorder.none : null,
            hintText: isForDescription ? "Add Note" : "Add Title",
            hintStyle: const TextStyle(color: Colors.white),
            prefixIcon: isForDescription
                ? Icon(
                    Icons.bookmark,
                    color: theme.hintColor.withOpacity(0.2),
                  )
                : Icon(
                    Icons.title,
                    color: theme.hintColor.withOpacity(0.2),
                  ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: theme.hintColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: theme.hintColor),
            ),
          ),
          onFieldSubmitted: (value) {},
          onChanged: (value) {},
        ),
      ),
    );
  }
}
