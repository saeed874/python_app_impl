import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:python_app/controllers/signup_controller.dart';
import 'package:python_app/views/signup_view.dart';
import 'controllers/auth_controller.dart';
import 'controllers/data_controller.dart';
import 'services/api_service.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageService = StorageService();
  await storageService.init();

  runApp(MyApp(storageService: storageService));
}

class MyApp extends StatelessWidget {
  final StorageService storageService;

  const MyApp({super.key, required this.storageService});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ApiService()),
        Provider(create: (_) => storageService),
        ChangeNotifierProvider(
          create: (context) => AuthController(
            context.read<ApiService>(),
            context.read<StorageService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DataController(
            context.read<ApiService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SignupController(),
          child: const SignUpScreen(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter MVC Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const SignUpScreen(),
      ),
    );
  }
}
