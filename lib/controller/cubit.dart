import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:mysqlite/controller/states.dart';

class TodoCubit extends Cubit<TodoStates> {
  TodoCubit() : super(InitialTodoStates());

  static TodoCubit get(context) => BlocProvider.of(context);
  Database? database;
  dynamic databasesPath = getDatabasesPath();

  Future<void> createDB() async {
    await openDatabase(
      'file.db',
      version: 1,
      onCreate: (database, version) async {
        debugPrint('DB is created');
        await database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, description TEXT, status TEXT)')
            .then(
          (value) {
            debugPrint('Table is created');
          },
        ).catchError(
          (error) {
            debugPrint('An error when creating table : $error');
          },
        );
      },
      onOpen: (database) {
        debugPrint('DB File is Opened');
        gettingDataFromDB();
      },
    ).then(
      (value) {
        database = value;
        emit(CreatingTodoDBStates());
        gettingDataFromDB();
      },
    ).catchError(
      (error) {
        debugPrint('An error when opening table : $error');
      },
    );
  }

  Future<void> insertDB({
    required title,
    required date,
    required time,
    required description,
    String status = 'new',
  }) async {
    await database?.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks (title, date, time, description, status)'
              'VALUES ("$title","$date","$time","$description","$status")')
          .then((value) {
        debugPrint('$value is inserted successfully');
        gettingDataFromDB();
        emit(InsertingIntoDBState());
      }).catchError((error) {
        debugPrint('An error inserting into DB : $error');
      });
    });
  }

  List tasks = [];
  void gettingDataFromDB() async {
    emit(LoadingGetDataFromDB());
    tasks = [];
    await database?.rawQuery('SELECT * FROM tasks').then((value) {
      for (var element in value) {
        tasks.add(element);
      }
      debugPrint('Our data is appearing');
      debugPrint('$value');
      emit(GettingDataFromDBState());
    }).catchError((error) {
      debugPrint('An error when getting data from DB : $error');
    });
  }

  void updateDB({
    required String title,
    required String date,
    required String time,
    required String description,
    required int id,
  }) {
    database!
        .update(
      'tasks',
      {
        'title': title,
        'date': date,
        'time': time,
        'description': description,
      },
      where: 'id=?',
      whereArgs: [id],
    )
        .then((value) {
      debugPrint('$value updating data has successfully happened');
      gettingDataFromDB();
    }).catchError((error) {
      debugPrint('Error when updating data : $error');
    });
  }

  void deleteFromDB({
    required int id,
  }) {
    database!.rawDelete(
      'DELETE FROM tasks WHERE id = ? ',
      [id],
    ).then((value) {
      debugPrint('$value deleted successfully !');
      emit(DeletingDataFromDatabaseState());
      gettingDataFromDB();
    }).catchError((error) {
      debugPrint('An error when deleting data : $error');
    });
  }

  dynamic locale = const Locale('en', 'US');

  void changeLanguagesToArabic(BuildContext context) {
    if (EasyLocalization.of(context)!.locale == const Locale('en', 'US') ||
        EasyLocalization.of(context)!.locale == const Locale('fr', 'FR')) {
      context.locale = const Locale('ar', 'EG');
    }
    emit(ChangeLanguagesToArabic());
  }

  void changeLanguagesToEnglish(BuildContext context) {
    if (EasyLocalization.of(context)!.locale == const Locale('ar', 'EG') ||
        EasyLocalization.of(context)!.locale == const Locale('fr', 'FR')) {
      context.locale = const Locale('en', 'US');
    }
    emit(ChangeLanguagesToEnglish());
  }

  void changeLanguagesToFrench(BuildContext context) {
    if (EasyLocalization.of(context)!.locale == const Locale('en', 'US') ||
        EasyLocalization.of(context)!.locale == const Locale('ar', 'EG')) {
      context.locale = const Locale('fr', 'FR');
    }
    emit(ChangeLanguagesToFrench());
  }

  bool isDark = false;
  void changeThemeMode({bool? darkMode}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (darkMode != null) {
      isDark = darkMode;
    } else {
      isDark = !isDark;
      sharedPreferences.setBool('isDark', isDark);
    }
    emit(ChangeThemeMode());
  }
}
