

import 'package:firebase_auth/firebase_auth.dart';
import 'package:qadiroon_front_end/data_stores/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginRecord
{
  LoginRecord({required this.Name, required this.passWord, required this.issueTime, required this.userType});
  
  String Name;
  String passWord;
  DateTime issueTime;
  UserType userType;

  @override
  String toString() {
    String buffer = '';
    buffer += '$Name\n';
    buffer += '$passWord\n';
    buffer += '$issueTime\n';
    buffer += '$userType\n';
    return buffer;
  }

  Map<String, dynamic> toMap()
  {
    return {
      'Name': Name,
      'PassWordHash': passWord,
      'issueTime': issueTime,
      'userType': userType.toString()
    };
  }

  void sendRecord() async
  {
    throw UnimplementedError();
  }

  Future<UserCredential?> checkLogInAttempt() async
  {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    UserCredential userCredential;
    try
    {
      print("attempting to sign in~!!\n");
      var creds = await _auth.signInWithEmailAndPassword(
        email: '$Name@testmail.com',
        password: passWord
      );
      print(creds.user?.uid?? "no user!!\n");
      userCredential = creds;

    }
    catch(e)
    {
      print('Error signing in : $e');
      return null;
    }

    try
    {
      FirebaseFirestore _database = FirebaseFirestore.instance;
      DocumentSnapshot _snapshot = await _database.collection('User').doc(userCredential.user!.uid).get();
      print(  _snapshot.data() as Map<String, dynamic>?);
    } catch (e)
    {
      print('Error retrieving user data : $e');
      return null;
    }

    return userCredential;
  }

  Future<bool> checkRegisterAttempt() async
  {

    final FirebaseAuth _auth = FirebaseAuth.instance;
    try
    {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: '$Name@testmail.com',
        password: passWord
      );
      FirebaseFirestore _database = FirebaseFirestore.instance;
      _database.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).set(
        toMap()
      );
    } catch (e)
    {
      print('Error: $e');
      return false;
    }

    return true;
  }

}