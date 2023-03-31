

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';

import '../cubit/cubit.dart';

Widget defaultFormField({
  @required TextInputType textInputType,
  @required dynamic function,
  dynamic onTap,
  @required IconData prefixIcon,
  @required TextEditingController controller,
  @required String lable,
  var onSubmit,
  bool isPasswordShown = false,
  IconData suffixIcon,
}) =>
    TextFormField(
      onFieldSubmitted: onSubmit,
      controller: controller,
      obscureText: isPasswordShown,
      decoration: InputDecoration(
        labelText: lable,
        fillColor: Colors.white,
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: GestureDetector(
          onTap: onTap,
          child: Icon(
            suffixIcon,
          ),
        ),
        border: OutlineInputBorder(),
      ),
      validator: function,
    );

Widget butomn({
  double width = double.infinity,
  Color background = Colors.blue,
  @required String text,
  bool isUpper = true,
  double radius = 15.0,
  final VoidCallback function,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget appBar() => AppBar(
      toolbarHeight: 100.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "WhatsApp",
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.camera_alt,
                  color: Colors.white60,
                ),
                SizedBox(
                  width: 40.0,
                ),
                Text(
                  "CHATS",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  width: 40.0,
                ),
                Text(
                  "STATUS",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  width: 35.0,
                ),
                Text(
                  "CALLS",
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(
                  width: 5.0,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white60,
                  radius: 10.0,
                  child: Text(
                    "4",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.green[400],
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 35.0),
          child: Row(
            children: [
              Icon(
                Icons.search,
              ),
              SizedBox(
                width: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Icon(
                  Icons.menu,
                ),
              ),
            ],
          ),
        ),
      ],
    );

Widget buildTaskItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35.0,
              child: Text(
                "${model["time"]}",
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model['title']}",
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${model["date"]}",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: 'done',
                    id: model['id'],
                  );
                },
                icon: Icon(
                  Icons.check_circle_outline,
                )),
            IconButton(
                onPressed: () {
                  AppCubit.get(context).updateData(
                    status: 'archive',
                    id: model['id'],
                  );
                },
                icon: Icon(
                  Icons.archive_outlined,
                )),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget tasksBuilder({
  @required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.length > 0,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              "No Tasks Yet , Please Add Some Tasks",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 10.0,
        end: 10.0,
      ),
      child: Container(
        height: 1.0,
        width: double.infinity,
        color: Colors.grey[300],
      ),
    );


void navigateTo(context, Widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ));

void navigateToAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false,
    );





Widget defultAppBar({
  @required BuildContext context,
  String title,
  List<Widget> actions,
}) => AppBar(
  elevation: 0.0,
  titleSpacing: 1.0,
  leading: IconButton(
    color: Colors.black,
      icon : Icon(
          IconBroken.Arrow___Left_2 ,
      ),
    onPressed: ()
    {
      Navigator.pop(context) ;
    },
  ) ,
  title: Text(
      '${title}' ,
  ),
  actions: actions,
) ;