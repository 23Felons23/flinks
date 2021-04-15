import 'package:flink_app/src/ui/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();

    return MultiProvider(
        providers: [
          StreamProvider<User>.value(
            value: FirebaseAuth.instance.authStateChanges(),
            initialData: null,
          )
        ],
        child: MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(
            body: HomePage(),
          ),
        ));
  }
}
