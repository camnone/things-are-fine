import 'package:flutter/cupertino.dart';
import 'package:thingsarefine/config/task_category.dart';
import 'package:thingsarefine/features/task/bloc/task_bloc.dart';
import 'package:thingsarefine/features/task/widgets/empty_task_block.dart';
import 'package:thingsarefine/features/task/widgets/favorites_task_list.dart';
import 'package:thingsarefine/repositories/task/models/task.dart';
import 'package:thingsarefine/ui/snack_bar.dart';
import 'package:thingsarefine/ui/ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';

import 'package:uuid/uuid.dart';

int activeCategoryIndex = 0;

@RoutePage()
class TaskScreen extends StatefulWidget {
  const TaskScreen({
    super.key,
  });

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  // late BannerAd _bannerAd;

  bool _isAdLoaded = false;

  // _initBanner() {
  //   _bannerAd = BannerAd(
  //     size: AdSize.banner,
  //     adUnitId: "ca-app-pub-3940256099942544/5354046379",
  //     listener: BannerAdListener(
  //       onAdLoaded: (ad) {
  //         setState(() {
  //           _isAdLoaded = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, error) {},
  //     ),
  //     request: AdRequest(),
  //   );
  //   _bannerAd.load();
  // }

  @override
  void initState() {
    // _initBanner();
    BlocProvider.of<TaskBloc>(context).add(LoadTasks());
    super.initState();
  }

  final titleTaskController = TextEditingController();
  final descriptionsTaskController = TextEditingController();
  final TimeOfDay timeVal = TimeOfDay.fromDateTime(DateTime.now());
  final DateTime dateVal = DateTime.now();
  var formatter = DateFormat('yyyy:MM:dd');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.linear,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                createEditTaskModal(context, theme, titleTaskController,
                    descriptionsTaskController, () async {
                  if (titleTaskController.text.isNotEmpty &&
                      descriptionsTaskController.text.isNotEmpty) {
                    SnackBarService(context,
                        message: "The task has been successfully created",
                        error: false);
                    BlocProvider.of<TaskBloc>(context).add(
                      SetTask(
                        task: Task(
                          const Uuid().v4(),
                          titleTaskController.text,
                          descriptionsTaskController.text,
                          timeVal.format(context),
                          formatter.format(dateVal),
                          false,
                          false,
                          categoryList[activeCategoryIndex]["name"].toString(),
                          activeCategoryIndex.toString(),
                        ),
                      ),
                    );

                    titleTaskController.clear();
                    descriptionsTaskController.clear();
                    Navigator.pop(context);
                  }
                }, () {
                  titleTaskController.clear();
                  descriptionsTaskController.clear();
                  Navigator.pop(context);
                }, categoryList, timeVal, dateVal);
              },
              backgroundColor: Color(0xFFfdba00),
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 32,
              ),
            ),
            body: CustomScrollView(
              slivers: [
                const CustomAppBar(title: "Tasks"),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
                if (state is TaskLoaded) ...[
                  Builder(builder: (context) {
                    final status =
                        state.tasks.where((e) => e.isFavorite == true).toList();

                    return status.isNotEmpty
                        ? FavoriteTaskList(data: status)
                        : const SliverToBoxAdapter(
                            child: SizedBox(),
                          );
                  }),
                  SliverToBoxAdapter(
                    child: Builder(builder: (context) {
                      final status =
                          state.tasks.where((e) => e.isFavorite == true);
                      return SizedBox(
                        height: status.isNotEmpty ? 16 : 0,
                      );
                    }),
                  ),
                ] else
                  const SliverToBoxAdapter(
                    child: SizedBox(),
                  ),
                SliverToBoxAdapter(
                  child: BaseContainer(
                    settings: true,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    height: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image(
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 150,
                        image: AssetImage('assets/big_logo.jpg'),
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                    child: SizedBox(
                  height: 16,
                )),
                if (state is TaskLoaded)
                  if (state.tasks.isNotEmpty)
                    SliverList.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: ((context, index) {
                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            BlocProvider.of<TaskBloc>(context)
                                .add(DeleteTask(task: state.tasks[index]));
                          },
                          key: Key(
                            state.tasks[index].id,
                          ),
                          child: BaseCardContainer(
                              child: TaskItem(
                            data: state.tasks[index],
                          )),
                        );
                      }),
                    )
                  else
                    const EmptyTasksBlock()
                else
                  const SliverToBoxAdapter(
                    child: SizedBox(),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
