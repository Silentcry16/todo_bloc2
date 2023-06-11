import 'package:path_provider/path_provider.dart';
import 'package:todo_bloc2/app_router.dart';
import 'package:todo_bloc2/screens/task_screen.dart';
import 'package:flutter/material.dart';
import './bloc/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: TaskScreen(),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
