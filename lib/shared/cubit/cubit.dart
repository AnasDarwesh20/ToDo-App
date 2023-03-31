import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';

import '../../modules/archived/archived_screen.dart';
import '../../modules/cheked/cheked_screen.dart';
import '../../modules/new_tasks/new_tasks.dart';

class AppCubit extends Cubit<AppStates>
{

  AppCubit() : super(initialState()) ;

  static AppCubit get(context) => BlocProvider.of(context) ;

  int currentIndex = 0 ;
  List<Widget> screens =
  [
    NewTasksScreen() ,
    ChekedScreen() ,
    ArchivedScreen() ,
  ] ;

  List<String> titels = [
    "New Tasks" ,
    "Done Taks" ,
    "Archived Tasks" ,
  ] ;
  List<Map> newTasks = [] ;
  List<Map> archivedTasks = [] ;
  List<Map> doneTasks = [] ;


  void changeIndex (int index )
  {
    currentIndex = index ;
    emit(AppChangeBottomNavBarState()) ;
  }
    Database database  ;


  void creatDatabase ()
  {
    openDatabase(
      'todo.db' ,
      version: 1 ,
      onCreate: (database , version)
      {
        print("database created ") ;
        database.execute('CREATE TABLE tasks ( id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT )').then((value) {
          print('table created') ;
        }).catchError((error){
          print('error is ${error.toString()}') ;
        }) ;
      } ,
      onOpen: (database)
      {
        getDataFromDatabase(database) ;
        print("database opend") ;

      } ,
    ).then((value)
    {
      database = value ;
      emit(AppCreateDatabseState()) ;
      print(database)  ;
    })  ;
  }

  Future insertToDatabase ({
    @required String text ,
    @required String time ,
    @required String date ,

  })
  async {
    return await database.transaction((txn)
    async{
      txn.rawInsert('INSERT INTO tasks (title , date, time  , status) VALUES("$text","$date","$time","new")').then((value)
      {
        print("$value inserted successfully : ") ;
        emit(AppInsertToDatabseState()) ;
        getDataFromDatabase(database) ;
        print(database) ;
      }
      ).catchError((error)
      {
        print("error is ${error.toString()}") ;

      }) ;
    }
    ) ;
  }

 void getDataFromDatabase(database)
  {
    newTasks = [] ;
    doneTasks = [] ;
    archivedTasks = [] ;
    emit(AppGetFromDatabseLodingState()) ;
      database.rawQuery('SELECT * FROM tasks') .then((value)
      {
        value.forEach((element)
        {
          if(element['status']== 'new')
            newTasks.add(element) ;
          else if(element['status']== 'done')
            doneTasks.add(element) ;
          else
            archivedTasks.add(element) ;

        }) ;
        emit(AppGetFromDatabseState()) ;

      }) ;
  }

  void updateData({
  @required String status ,
  @required int id ,
})
  async
  {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?  ' ,
          ['$status' , id] ,

    ).then((value)
    {
      getDataFromDatabase(database) ;
      emit(AppUpdateDatabaseState()) ;
    }) ;
  }

  void deleteData({
    @required int id ,
  })
  async
  {
    database.rawDelete(
      'DELETE FROM  tasks  WHERE id = ?  ' ,
      [id] ,

    ).then((value)
    {
      getDataFromDatabase(database) ;
      emit(AppDeleteFromDatabaseState()) ;
    }) ;
  }


  bool isBottunSheetShown = false ;
  IconData addIcon = Icons.edit ;

  void changeBottomSheetState({
    @required bool isShown ,
    @required IconData icon ,
})
  {
    isBottunSheetShown = isShown ;
    addIcon = icon ;
    emit(AppChangeBottomSheetState()) ;
  }
  }