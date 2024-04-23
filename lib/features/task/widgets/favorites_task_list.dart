import 'package:thingsarefine/repositories/task/models/task.dart';
import 'package:thingsarefine/ui/ui.dart';
import 'package:flutter/material.dart';

class FavoriteTaskList extends StatelessWidget {
  const FavoriteTaskList({
    super.key,
    required this.data,
  });

  final List<Task> data;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110,
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            width: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return BaseContainer(
              width: 350,
              child: TaskItem(data: data[index]),
            );
          },
        ),
      ),
    );
  }
}
