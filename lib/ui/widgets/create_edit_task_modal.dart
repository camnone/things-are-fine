import 'package:thingsarefine/features/task/task.dart';
import 'package:thingsarefine/features/task/widgets/date_time_widget.dart';
import 'package:thingsarefine/features/task/widgets/rep_text_field_widget.dart';
import 'package:flutter/material.dart';

Future<dynamic> createEditTaskModal(
    BuildContext context,
    ThemeData theme,
    TextEditingController title,
    TextEditingController description,
    VoidCallback createTaskTap,
    VoidCallback deleteTaskTap,
    List category,
    TimeOfDay timeVal,
    DateTime dateVal) {
  return showModalBottomSheet(
    scrollControlDisabledMaxHeightRatio: 1,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) => GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            height: 550,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Divider(
                          thickness: 2,
                          color: theme.primaryColor,
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: "Add New",
                          style: TextStyle(
                              fontSize: 36, fontWeight: FontWeight.w300),
                          children: [
                            TextSpan(
                                text: "Task",
                                style: TextStyle(fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Divider(
                          thickness: 2,
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            'What are you planing?',
                            style: TextStyle(color: theme.hintColor),
                          ),
                        ),
                        RepTextField(controller: title),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 12,
                        ),
                        RepTextField(
                            controller: description, isForDescription: true),
                        DateTimeWidget(
                            dateVal: dateVal, timeVal: timeVal, isDate: false),
                        DateTimeWidget(
                          dateVal: dateVal,
                          timeVal: timeVal,
                          isDate: true,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() => activeCategoryIndex = index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: activeCategoryIndex == index
                                        ? category[index]["color"]
                                        : theme.hintColor,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1,
                                  ),
                                  width: 90,
                                  child: Center(
                                    child: Text(
                                      category[index]["name"],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 8,
                              );
                            },
                            itemCount: category.length),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: deleteTaskTap,
                      height: 50,
                      minWidth: 150,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 18,
                          ),
                          Text(
                            "Exit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: createTaskTap,
                      height: 50,
                      minWidth: 150,
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                          Text(
                            "Add Task",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
