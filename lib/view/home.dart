import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysqlite/controller/cubit.dart';
import 'package:mysqlite/controller/states.dart';
import 'package:mysqlite/view/add.task.dart';
import 'package:mysqlite/view/drawer.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:mysqlite/view/update.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        dynamic cubit = TodoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('My task'.tr()),
            elevation: 1,
            actions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<TodoCubit>(context).changeThemeMode();
                },
                icon: Icon(
                  BlocProvider.of<TodoCubit>(context).isDark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
              ),
            ],
          ),
          drawer: const Drawer(
            child: DrawerPage(),
          ),
          body: ConditionalBuilder(
            condition: state is! LoadingGetDataFromDB,
            fallback: (BuildContext context) => const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange),
            ),
            builder: (BuildContext context) {
              return (cubit.tasks.isNotEmpty)
                  ? ListView.builder(
                      itemCount: cubit.tasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return UpdateTaskScreen(
                                    id: cubit.tasks[index]['id'],
                                    title: cubit.tasks[index]['title'],
                                    date: cubit.tasks[index]['date'],
                                    time: cubit.tasks[index]['time'],
                                    des: cubit.tasks[index]['description'],
                                  );
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          cubit.tasks[index]['time'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cubit.tasks[index]['title'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                color: Colors.black,
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  cubit.deleteFromDB(
                                                    id: cubit.tasks[index]
                                                        ['id'],
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          cubit.tasks[index]['description'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.hourglass_empty),
                          Text(
                            'There is no tasks here'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.deepOrange),
                          ),
                        ],
                      ),
                    );
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.endContained,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 10,
            ),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTask()));
              },
              mini: true,
              child: const Icon(Icons.add_task),
            ),
          ),
        );
      },
    );
  }
}
