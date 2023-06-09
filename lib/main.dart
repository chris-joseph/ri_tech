import 'package:flutter/material.dart';
import 'package:ri_tech/app/employee/employee_list/employee_list_screen.dart';
import 'package:ri_tech/data/dao/employee/employee_dao.dart';
import 'package:ri_tech/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await employeeDAO.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const EmployeeListScreen(),
      routes: getRoutes,
    );
  }
}
