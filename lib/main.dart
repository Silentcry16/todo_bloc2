import 'package:path_provider/path_provider.dart';
import 'package:todo_bloc2/services/app_router.dart';
import 'package:todo_bloc2/screens/task_screen.dart';
import 'package:flutter/material.dart';
import 'package:todo_bloc2/services/app_theme.dart';
import './blocs/bloc_exports.dart';

Future<void> main() async {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<TasksBloc>(
          create: (BuildContext context) => TasksBloc(),
        ),
        BlocProvider<SwitchBloc>(
          create: (BuildContext context) => SwitchBloc(),
        ),
      ],
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.switchValue
                ? AppThemes.AppThemeData[AppTheme.darkTheme]
                : AppThemes.AppThemeData[AppTheme.lightTheme],
            home: const TaskScreen(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
