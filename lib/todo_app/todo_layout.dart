import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class HomeLayout extends StatelessWidget
{

  var scaffoldKey = GlobalKey<ScaffoldState>() ;
  var formKey = GlobalKey<FormState>() ;

  var textController = TextEditingController() ;
  var timeController = TextEditingController() ;
  var dateController = TextEditingController() ;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..creatDatabase(),
      child: BlocConsumer<AppCubit , AppStates > (
        listener: (context, state)
        {
          if(state is AppInsertToDatabseState){
            Navigator.pop(context) ;
          }
        },
        builder: (context, state)
        {
          return Scaffold(
            key: scaffoldKey ,
            appBar: AppBar(
              title: Text(
                AppCubit.get(context).titels[AppCubit.get(context).currentIndex] ,
              ),
            ),
            // body: AppCubit.get(context).newTasks==0 ? Center(child: CircularProgressIndicator()) : AppCubit.get(context).screens[AppCubit.get(context).currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if(AppCubit.get(context).isBottunSheetShown)
                {
                  if(formKey.currentState.validate())
                  {
                    AppCubit.get(context).insertToDatabase(text: textController.text
                        , time: timeController.text
                        , date: dateController.text , ) ;
                  }
                }
                else
                {
                  scaffoldKey.currentState?.showBottomSheet(
                        (context) => Container(
                      padding: EdgeInsetsDirectional.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          [
                            Container(
                              child: TextFormField(
                                controller: textController,
                                decoration: InputDecoration(
                                  labelText: 'Task Title',
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                      Icons.title
                                  ),
                                  border: OutlineInputBorder() ,
                                ),
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return 'title must not be empty' ;
                                  }
                                  return null ;
                                },


                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ) ,
                            Container(

                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                onTap: ()
                                {
                                  showTimePicker(context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value)
                                      {
                                        timeController.text = value.format(context).toString() ;
                                        print(value.format(context));
                                      }
                                  ).catchError(
                                          (error){
                                      }
                                  );
                                },
                                controller: timeController,
                                decoration: InputDecoration(
                                  labelText: 'Task Time',
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                      Icons.watch_later_outlined
                                  ),
                                  border: OutlineInputBorder() ,
                                ),
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return 'time must not be empty' ;
                                  }
                                  return null ;
                                },


                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ) ,
                            Container(
                              child: TextFormField(

                                onTap: ()
                                {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now() ,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2030-10-03'),
                                  ) .then((value) {
                                    dateController.text = DateFormat.yMMMd().format(value) ;
                                  }).catchError((error)
                                  {
                                    print("error is $error");
                                  });
                                },
                                controller: dateController,
                                decoration: InputDecoration(
                                  labelText: 'Task Date',
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.date_range,
                                  ),
                                  border: OutlineInputBorder() ,
                                ),
                                validator: (value)
                                {
                                  if(value.isEmpty)
                                  {
                                    return 'date must not be empty' ;
                                  }
                                  return null ;
                                },


                              ),
                            ),
                          ],
                        ),
                      ),
                    ) ,
                    elevation: 15.0 , ).closed.then((value)
                  {
                    AppCubit.get(context).changeBottomSheetState(isShown : false, icon : Icons.edit) ;
                  }) ;
                  AppCubit.get(context).changeBottomSheetState(isShown : true, icon : Icons.add) ;
                }
              },
              child: Icon(
                AppCubit.get(context).addIcon ,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (index)
              {
                AppCubit.get(context).changeIndex(index) ;
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                      Icons.menu
                  ) ,
                  label: "Tasks" ,

                ) ,
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline ,
                  ) ,
                  label: "Done" ,

                ) ,
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined ,
                  ) ,
                  label: "Archived" ,

                ) ,

              ],
            ),
          ) ;
        },

      ),
    );
  }

  // Future <String> getName() async
  // {
  //   return "Anas Emad" ;
  // }


}

