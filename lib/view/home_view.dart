import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'package:taskapp/viewModel/home_view_model.dart';

import '../service/task_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context, listen: true);
    late HomeViewModel viewModel;
    late BuildContext _context;
    return ChangeNotifierProvider.value(
      value: viewModel = HomeViewModel(),
      builder: (context, child) => Scaffold(
        floatingActionButton: vm.isManager
            ? FloatingActionButton(
                onPressed: () => vm.newTaskBottomSheetOpener(
                    context,
                    Center(
                      child: newTaskBottomSheetBody(vm, context),
                    )),
                child: Center(
                  child: Icon(Icons.add),
                ),
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
              child: Column(
            children: [
              Text(
                "Welcome ${vm.userName}",
                style: TextStyle(fontSize: 30),
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: TaskService().getPersonalTasks().snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          width: double.infinity,
                          child: ListView(
                              children: snapshot.requireData.docs
                                  .map((DocumentSnapshot document) {
                            return Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              document
                                                      .data()
                                                      .toString()
                                                      .contains("title")
                                                  ? document.get("title")
                                                  : "",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(document
                                                    .data()
                                                    .toString()
                                                    .contains("startTime")
                                                ? "Start " +
                                                    document
                                                        .get("startTime")
                                                        .toString()
                                                : ""),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(document
                                                    .data()
                                                    .toString()
                                                    .contains("dueTime")
                                                ? "Due " +
                                                    document
                                                        .get("dueTime")
                                                        .toString()
                                                : ""),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList()),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Scaffold newTaskBottomSheetBody(HomeViewModel vm, BuildContext context) =>
      Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            TextField(
              controller: vm.taskTitleController,
              decoration: InputDecoration(
                  hintText: "Title",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey))),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    controller: vm.assignedUsersController,
                    decoration: InputDecoration(
                        hintText: "Users",
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey))),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 3,
                  child: ElevatedButton(
                      onPressed: () => vm.addAsignedUser(),
                      child: Center(
                        child: Text("Add"),
                      )),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () => DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime(2019, 6, 7),
                            onChanged: (date) {}, onConfirm: (date) {
                          print(vm.startTime);
                          vm.startTime = date;
                          print(vm.startTime);
                        }, currentTime: DateTime.now(), locale: LocaleType.tr),
                    child: Text("Start Time")),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () => DatePicker.showDateTimePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime(2019, 6, 7),
                            onChanged: (date) {}, onConfirm: (date) {
                          print(date.isAfter(vm.startTime));
                          print(vm.dueTime);
                          date.isAfter(vm.startTime) ? vm.dueTime = date : null;
                          print(vm.dueTime);
                        }, currentTime: DateTime.now(), locale: LocaleType.tr),
                    child: Text("Due Time"))
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  vm.addNewTask();
                },
                child: Center(
                  child: Text("Create Task"),
                ))
          ]),
        ),
      );
}
