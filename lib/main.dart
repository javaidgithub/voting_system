import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'VotingForm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCv_S8rN2ZK83o-EC560NkAQu-5qoDN-gg",
        appId: "1:263949668533:web:80faf8586dbf99bcbdeefc",
        messagingSenderId: "263949668533",
        projectId: "votingsystem-105d7")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Voting System',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: VotingForm(),
    );
  }
}
