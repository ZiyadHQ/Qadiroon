
import 'package:cloud_firestore/cloud_firestore.dart';

class ToJson
{

  static String FireStoreDocToJson(DocumentSnapshot<Map<String, dynamic>> doc)
  {

    var data = doc.data()!;

    String json = "{";

    data.forEach((key, value)
    {
      json += "\"${key}\" : \"${value.toString()}\"";
    });

    json += "}";

    return json;

  }

  static String MapToJson(Map<String, dynamic> data)
  {
    
    String json = "{";

    data.forEach((key, value)
    {
      json += "\"${key}\" : \"${value.toString()}\"";
    });

    json += "}";

    return json;

  }

}