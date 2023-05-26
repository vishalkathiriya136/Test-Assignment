import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_assignment/src/screen/hello_world_screen.dart';
import 'package:test_assignment/utils/prefskeys.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light));
  WidgetsFlutterBinding.ensureInitialized();

  final Directory appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) async {
    await Hive.openBox('test_assignment').then(
      (value) => runApp(
        MyApp(prefs: value),
      ),
    );
  });
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  Box prefs;
  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    PrefObj.preferences = widget.prefs;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth != 0) {
          final size = Size(constraints.maxWidth, constraints.maxHeight);
          ScreenUtil.init(context, designSize: size);
        }
        return ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Test Assignment',
            home: HelloWordScreen(),
          ),
        );
      },
    );
  }
}
