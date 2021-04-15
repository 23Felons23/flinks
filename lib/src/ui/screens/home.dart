import 'package:firebase_auth/firebase_auth.dart';
import 'package:flink_app/src/services/auth.dart';
import 'package:flink_app/src/ui/components/bottom_app_bar.dart';
import 'package:flink_app/src/ui/components/flink_form.dart';
import 'package:flink_app/src/ui/components/flink_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/flink.dart';
import '../../services/db.dart';

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  bool _isFlinkFormOpened = false;

/*  void loginUser(auth) {
    auth.signInWith
  }*/

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    bool _isUserLoggedIn = user != null;
    if (!_isUserLoggedIn) {
      AuthService().signInWithGoogle();
    }

    DatabaseService db = DatabaseService();

    return WillPopScope(
        onWillPop: () async {
          bool _shouldCloseApp = true;
          if (_isFlinkFormOpened) {
            setState(() {
              _isFlinkFormOpened = false;
            });
            _shouldCloseApp = false;
          }
          return _shouldCloseApp;
        },
        child: Scaffold(

            appBar: AppBar(
              title: Text("Flinks"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _isUserLoggedIn
                    ? StreamProvider<List<Flink>>.value(
                        value: db.streamUserFlinks(),
                        initialData: [],
                        child: FlinkList(),
                      )
                    : Container(),
                _isFlinkFormOpened ? FlinkForm() : Container(),
              ],
            ),
            floatingActionButton: Container(
              margin: const EdgeInsets.only(bottom: 5.0),
              child: _isFlinkFormOpened
                  ? Container()
                  : FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _isFlinkFormOpened = !_isFlinkFormOpened;
                        });
                      },
                      tooltip: 'Add',
                      child: Icon(Icons.add),
                    ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar:
                _isFlinkFormOpened ? null : FlinkBottomAppBar()));
  }
}
