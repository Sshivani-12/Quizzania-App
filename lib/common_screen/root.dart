import 'package:flutter/material.dart';
import 'package:rait_online_portal/common_screen/login_screen.dart';
import 'package:rait_online_portal/components/decider.dart';
import 'package:rait_online_portal/states/currentUser.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  notLoggedIn,
  loggedIn,
}

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.notLoggedIn;
  var _email;
  var userType;




  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    //get the state,check the current user
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if (_returnString == 'Success') {
      _email = _currentUser.getEmail;
      userType = await getUserType(_email);
      setState(() {
        _authStatus = AuthStatus.loggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;
    switch (_authStatus) {
      case AuthStatus.notLoggedIn:
        retVal = LoginScreen();
        break;
      case AuthStatus.loggedIn:
        retVal = userType;
        break;
      default:
    }
    return retVal;
  }
}
