import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder:(context, state) {
        var tasks = AppCubit.get(context).doneTasks;

        return ListView.separated(
          itemBuilder: (context, index) => taskBuildItem(tasks[index], context, 'done'),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              width: 10,
              color: Colors.grey[300],
              height: 1.0,

            ),
          ), itemCount: tasks.length,);
      },
    );
  }
}
