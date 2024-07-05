import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Triton/pages/inicio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Fotos FTP',
        debugShowCheckedModeBanner: false,
        home: InicioPage());
  }
}
