
import 'package:qadiroon_front_end/data_stores/record.dart';
import 'package:qadiroon_front_end/login_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qadiroon_front_end/simple_alert_widget.dart';
import 'package:qadiroon_front_end/tools/query_tools.dart';

class LoginRecord
{
  LoginRecord({required this.Name, required this.PassWordHash, required this.issueTime, required this.userType});
  
  String Name;
  String PassWordHash;
  DateTime issueTime;
  UserType userType;

  @override
  String toString() {
    String buffer = '';
    buffer += '$Name\n';
    buffer += '$PassWordHash\n';
    buffer += '$issueTime\n';
    buffer += '$userType\n';
    return buffer;
  }

  Map<String, dynamic> toMap()
  {
    return {
      'Name': Name,
      'PassWordHash': PassWordHash,
      'issueTime': issueTime,
      'userType': userType.toString()
    };
  }

  void sendRecord() async
  {
    try
    {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('loginRecords').add(toMap());
      print('record sent successfully');
    } catch(e)
    {
      print('Error sending data to DB: $e');
    }
  }

  bool checkLogInAttempt()
  {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference logInRecords = firestore.collection('loginRecords');
    Query query = logInRecords.where('Name', isEqualTo: this.Name);
    print('printing query:');
    query.get().then(
      (querySnapshot)
      {
        for(var docSnapshot in querySnapshot.docs)
        {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      }
      );
    return true;
  }

  void checkRegisterAttempt() async
  {
    bool nameCheck = await QueryTools.doesDocWithNameExist(this.Name);
    if(nameCheck)
    {
      print('Error: UserName with Name: $Name already exists!');
      return;
    }
    else
    {
      sendRecord();
    }
  }

}