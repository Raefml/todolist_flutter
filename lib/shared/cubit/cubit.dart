
import 'package:bloc/bloc.dart';
import 'package:fa/shared/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';


import '../../modules/archived_tasks/archived_tasks.dart';
import '../../modules/done_tasks/done_tasks.dart';
import '../../modules/new_tasks/new_tasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool fabOpened = false;
  IconData fabIcon = Icons.edit;

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeCurrentIndexState(int index)
  {
    currentIndex = index;
    emit(ChangeBottomNavBarIndex());
  }

  void createDatabase(){
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          database.execute('CREATE TABLE todo (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, date TEXT, time TEXT, status TEXT)').then((value) {
            print('Database Created');
          });
        },

        onOpen: (database) {
           getFromDatabase(database);
        }
    ).then((value) {
      database = value;
      emit(createDatabaseState());
    });

  }

  void getFromDatabase(database) async
  {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    database.rawQuery('SELECT * FROM todo').then((tasks) {
      tasks.forEach((element) {
        if(element['status'] == 'new')
          newTasks.add(element);
        else if(element['status'] == 'done')
          doneTasks.add(element);
        else
          archivedTasks.add(element);
      });
      emit(getDatabaseState());
    });
  }

  void insertToDatabase(String title, String date, String time) {
    database.transaction((txn) {
      txn.rawInsert('INSERT INTO todo (title, date, time, status) VALUES ("$title", "$date", "$time", "new")').then((value) {
        getFromDatabase(database);
          fabIcon = Icons.edit;
          fabOpened = false;
          emit(insertToDatabaseState());

      });
      return Future(() => null);
    });
  }

  void fabChange(IconData icon,bool state)
  {
    fabIcon = icon;
    fabOpened = state;
    emit(fabChangeState());
  }

  void updateDatabase(
      @required String status,
      @required int id,
      ) async
  {
    database.rawUpdate(
        'UPDATE todo SET status = ? WHERE id = ?',
        ['$status', '$id']).then((value) {
          getFromDatabase(database);
    });
  }

  void deleteFromDatabase(int id)
  {
    database.rawDelete('DELETE FROM todo WHERE id = ?', [id]).then((value) {
      getFromDatabase(database);
      emit(deleteFromDatabaseState());
    });
  }
}