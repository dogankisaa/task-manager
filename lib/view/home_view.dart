import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/viewModel/home_view_model.dart';

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
                      child: newTaskBottomSheetBody(vm),
                    )),
                child: Center(
                  child: Icon(Icons.add),
                ),
              )
            : null,
        body: Center(
            child: FutureBuilder(
                future: vm.getName(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("Welcome ${vm.userName}");
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })),
      ),
    );
  }

  Scaffold newTaskBottomSheetBody(HomeViewModel vm) => Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            controller: vm.taskTitleController,
            decoration: InputDecoration(hintText: "Title"),
          ),
          Row(
            children: [
              Expanded(
                flex: 7,
                child: TextField(
                  controller: vm.assignedUsersController,
                  decoration: InputDecoration(hintText: "Users"),
                ),
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
          ElevatedButton(
              onPressed: () {
                vm.addNewTask();
              },
              child: Center(
                child: Text("Register"),
              ))
        ]),
      );
}
