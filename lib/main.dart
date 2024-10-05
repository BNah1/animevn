import 'package:animevn/bloc/storage/storage_bloc.dart';
import 'package:animevn/screen/splash_screen.dart';
import 'package:animevn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constant/route.dart';

void main() {
  final DateTime now = DateTime.now();
  checkToClearCache(now);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => StorageBloc()),
        ],
        child: MaterialApp(
          onGenerateRoute: Routes.generateRoute,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        ));
  }
}
