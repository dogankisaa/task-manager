import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskapp/viewModel/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context, listen: false);
    late HomeViewModel viewModel;
    late BuildContext _context;
    return ChangeNotifierProvider.value(
      value: viewModel = HomeViewModel(),
      builder: (context, child) => Scaffold(
        body: Center(
            child: Consumer<HomeViewModel>(
                builder: (context, value, child) => FutureBuilder(
                    future: value.getName(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text("Welcome ${value.userName}");
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }))),
      ),
    );
  }
}
