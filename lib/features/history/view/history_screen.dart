import 'package:thingsarefine/features/history/bloc/history_bloc.dart';
import 'package:thingsarefine/features/history/widget/history_item.dart';
import 'package:thingsarefine/ui/ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    BlocProvider.of<HistoryBloc>(context).add(LoadHistory());
    super.initState();
  }

  final historyList = [];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CustomScrollView(
      slivers: [
        const CustomAppBar(title: "History"),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
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
        BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state is HistoryLoaded) {
              if (state.history.isNotEmpty) {
                return SliverList.builder(
                  itemCount: state.history.length,
                  itemBuilder: ((context, index) {
                    return BaseCardContainer(
                        child: HistoryItem(data: state.history[index]));
                  }),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Lottie.asset("assets/lottie/task_history.json",
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
            } else {
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
            }
          },
        )
        //  SliverList.builder(
        //       itemCount: historyList.length,
        //       itemBuilder: ((context, index) {
        //         return SizedBox();
        //         // return const BaseCardContainer(
        //         //   child: TaskItem(isFavorite: false, isCheck: false),
        //         // );
        //       }),
        //     )
      ],
    );
  }
}
