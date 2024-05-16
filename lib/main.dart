import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:routes/infraestructure/controllers/request_permission_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = _controller.onStatusChanged.listen((status) {
      if (status == PermissionStatus.granted) {
        return;
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _controller.request();
             Navigator.push(
              // ignore: use_build_context_synchronously
              context,
              MaterialPageRoute(builder: (context) =>  HomePage()),
        );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            minimumSize: const Size(200, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: const Text(
            'permisos de ubicación',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontFamily: 'FiraSansCondensed',
            ),
          ),
        ),
      ),
    );
  }
}
