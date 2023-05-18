import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../cubit/cubit.dart';

Widget defaultTF({
  required TextInputType keyboardType,
  required String text,
  required IconData prefixIcon,
  Function()? onTap,
  TextEditingController? controller,
  required String? Function(String?) validator,
  double radius = 10.0,
}) => TextFormField(
  controller: controller,
  validator: validator,
  onTap: onTap,
  keyboardType: keyboardType,
  decoration: InputDecoration(
    labelText: text,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
    ),
    prefixIcon: Icon(prefixIcon),
  ),
);

Widget taskBuildItem(model, context, String type) {
  AppCubit cubit = AppCubit.get(context);
  Color doneColor = Colors.black45;
  Color archivedColor = Colors.black45;
  IconData doneIcon = Icons.check_circle_outline;
  IconData archivedIcon = Icons.archive_outlined;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var titleController = TextEditingController();
  if(type == 'done')
  {
    doneColor = Colors.green;
    doneIcon = Icons.check_circle;
  }
  else if(type == 'archived')
    {
      archivedColor = Colors.blueAccent;
      archivedIcon = Icons.archive;
    }

  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              '${model['time']}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            radius: 35.0,
          ),
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //Task Title
                Text(
                  '${model['title']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),

                //Date
                Text(
                  '${model['date']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          //Done button
          IconButton(
            onPressed: ()
            {
              AppCubit.get(context).updateDatabase('done', model['id'],);

            },
            icon: Icon(doneIcon, color: doneColor,),
          ),

          //archived button
          IconButton(
              onPressed: ()
              {
                AppCubit.get(context).updateDatabase('archived', model['id'],);
              },
              icon: Icon(archivedIcon, color: archivedColor,),
          ),
          IconButton(
            onPressed: () {
              if(!cubit.fabOpened) {
                cubit.fabChange(Icons.add, true);

                scaffoldKey.currentState!.showBottomSheet((context) {
                  return Container(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Title
                          defaultTF(
                            controller: titleController,
                            keyboardType: TextInputType.text,
                            text: 'Task Title',
                            prefixIcon: Icons.title,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please Enter Task Title';
                              }
                            },
                          ),

                          SizedBox(height: 16.0,),

                          //Date
                          defaultTF(
                            controller: dateController,
                            keyboardType: TextInputType.none,
                            text: 'Task Date',
                            prefixIcon: Icons.calendar_month_rounded,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Please Enter Task Date';
                              }
                            },
                            onTap: () {
                              String month = DateTime.now().month.toString();
                              if(month.length == 1) month = '0' + month;

                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime.parse('${DateTime
                                    .now()
                                    .year}-0${DateTime
                                    .now()
                                    .month + 1}-01'),
                              ).then((value) {
                                dateController.text = DateFormat.yMd().format(value!);
                              });
                            },
                          ),

                          SizedBox(height: 16.0,),

                          //Time
                          defaultTF(
                              controller: timeController,
                              keyboardType: TextInputType.none,
                              text: 'Task Time',
                              prefixIcon: Icons.watch_later_outlined,
                              validator: (value) {
                                if (value != null && value.isEmpty) {
                                  return 'Please Enter Task Time';
                                }
                              },
                              onTap: () {
                                showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now()).then((value) {
                                  timeController.text = value!.format(context).toString();
                                });

                              }
                          ),
                        ],
                      ),
                    ),

                  );
                }, elevation: 10.0).closed.then((value) {
                  cubit.fabChange(Icons.edit, false);
                });
              }
              else
              {
                if(formKey.currentState!.validate())
                {
                  cubit.insertToDatabase(titleController.text, dateController.text, timeController.text);
                  Navigator.pop(context);
                }
              }

            },
            icon: Icon(Icons.edit),
          ),

        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteFromDatabase(model['id']);
    } ,
    background: Icon(
      Icons.delete,
      color: Colors.red,
      size: 40.0,
    ),
  );
}