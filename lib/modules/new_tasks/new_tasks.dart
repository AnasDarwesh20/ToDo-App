import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class NewTasksScreen extends StatefulWidget {

  @override
  State<NewTasksScreen> createState() => _NewTasksScreenState();
}

class _NewTasksScreenState extends State<NewTasksScreen> {
  @override
  Widget build(BuildContext context)
  {

    return BlocConsumer<AppCubit , AppStates>(
      listener: (context , state){},
      builder: (context , state)
        {
          var tasks = AppCubit.get(context).newTasks ;
          return tasksBuilder(tasks: tasks) ;
        },
    );
  }
}
