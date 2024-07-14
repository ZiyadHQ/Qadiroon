
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qadiroon_front_end/main.dart';
import 'package:qadiroon_front_end/start_widget.dart';

class ServiceProviderScreen extends StatefulWidget
{

  ServiceProviderScreen({super.key, required this.user});

  final UserCredential user;

  State<StatefulWidget> createState()
  {
    return _UserScreenState();
  }

}

class _UserScreenState extends State<ServiceProviderScreen>
{

  Widget build(BuildContext context)
  {
    return Scaffold(
      
      body: Center(
        child: Text('مقدم خدمة'),
      ),
      bottomNavigationBar: Tab(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            IconButton(onPressed: (){FirebaseAuth.instance.signOut(); main_switchBaseWidget(StartScreen());}, icon: Icon(Icons.logout)),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
            Text('Test1'),
            SizedBox(width: 32),
          ],
        ),
      ),
    );
  }

}
