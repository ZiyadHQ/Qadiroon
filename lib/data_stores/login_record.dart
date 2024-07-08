
import 'package:qadiroon_front_end/data_stores/record.dart';
import 'package:qadiroon_front_end/login_widget.dart';

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

}