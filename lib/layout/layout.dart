

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class Layout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titles[cubit.currentIndex],
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
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
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeCurrentIndexState(index);
              },
              elevation: 10.0,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_task),
                  label: 'New Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.done_all),
                  label: 'Done Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived Tasks',
                ),
              ],
            ),
            body: ConditionalBuilder(
                condition: state is! getDatabaseLoadingState,
                builder: (context) => cubit.screens[cubit.currentIndex],
                fallback: (context) => Center(child: CircularProgressIndicator()),
            ),

          );
        },
      ),
    );
  }

  //Example for a function running in the background not in the main thread.
  Future<String> getName() async {
    return 'Mina Anis';
  }


}

