
import 'package:cloud_firestore/cloud_firestore.dart';

class QueryTools
{

  static Future<bool> doesDocWithNameExist(String name) async
  {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference logInRecords = firestore.collection('loginRecords');
    Query query = logInRecords.where('Name', isEqualTo: name);
    print('printing query:');
    query.get().then(
      (querySnapshot)
      {
        for(var docSnapshot in querySnapshot.docs)
        {
          print('doc with Name: $name => ${docSnapshot.data()}');
        }
        return querySnapshot.docs.isNotEmpty;
      }
      );
      return false;
  }

}