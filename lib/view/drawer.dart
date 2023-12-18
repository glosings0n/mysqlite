import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:mysqlite/controller/cubit.dart';
import 'package:mysqlite/controller/states.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        dynamic cubit = TodoCubit.get(context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Language'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            GestureDetector(
              onTap: () => cubit.changeLanguagesToArabic(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.translate),
                  Text(
                    'Arabic'.tr(),
                    style: const TextStyle(color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => cubit.changeLanguagesToFrench(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.g_translate),
                  Text(
                    'French'.tr(),
                    style: const TextStyle(color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => cubit.changeLanguagesToEnglish(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.language),
                  Text(
                    'English'.tr(),
                    style: const TextStyle(color: Colors.deepOrange),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'ToDo App'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
