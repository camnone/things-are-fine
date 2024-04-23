import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyTasksBlock extends StatelessWidget {
  const EmptyTasksBlock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Lottie.asset("assets/lottie/task_done.json",
              animate: true, width: 200, height: 200),
          Text(
            "No task found 😞",
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            "Rather, create a new task!",
            style: theme.textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
