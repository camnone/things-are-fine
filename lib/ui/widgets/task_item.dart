import 'package:thingsarefine/config/task_category.dart';
import 'package:thingsarefine/features/history/bloc/history_bloc.dart';
import 'package:thingsarefine/features/task/bloc/task_bloc.dart';
import 'package:thingsarefine/repositories/task/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.data,
  });

  final Task data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskLoaded) {
            BlocProvider.of<HistoryBloc>(context).add(LoadHistory());
          }
        },
        child: GestureDetector(
          onTap: () {
            BlocProvider.of<TaskBloc>(context)
                .add(UpdateIsDoneStatusTask(task: data));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: data.isDone
                              ? Colors.green
                              : theme.hintColor.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          size: 28,
                          color: Colors.white,
                          Icons.check,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(data.description),
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            decoration: BoxDecoration(
                                color:
                                    categoryList[int.parse(data.categoryColor)]
                                        ["color"] as Color,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              data.category,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<TaskBloc>(context)
                          .add(UpdateFavoriteStatusTask(task: data));
                    },
                    child: Icon(
                      Icons.favorite,
                      size: 32,
                      color: data.isFavorite
                          ? Colors.red
                          : theme.hintColor.withOpacity(0.2),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(data.createdAtDate),
                      Text(data.createdAtTime),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
