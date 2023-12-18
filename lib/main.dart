import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mysqlite/controller/states.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mysqlite/controller/cubit.dart';
import 'package:mysqlite/shared/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:mysqlite/view/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isDark = sharedPreferences.getBool('isDark') ?? false;
  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'EG'),
        Locale('fr', 'FR'),
      ],
      fallbackLocale: const Locale('en', 'US'),
      saveLocale: false,
      child: MyApp(
        isDark: isDark,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isDark});

  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => TodoCubit()
              ..createDB()
              ..changeThemeMode(darkMode: isDark))
      ],
      child: BlocConsumer<TodoCubit, TodoStates>(
        listener: (context, state) {},
        builder: (context, state) {
          dynamic cubit = TodoCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: 'SQLite DB',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: AnimatedSplashScreen(
              splash: SizedBox(
                height: 60,
                width: 60,
                child: Image.asset(
                  'assets/images/todologo.png',
                ),
              ),
              nextScreen: const HomePage(),
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.fade,
              backgroundColor: Colors.transparent,
              duration: 1000,
            ),
          );
        },
      ),
    );
  }
}
