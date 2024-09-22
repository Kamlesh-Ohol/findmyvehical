import 'package:findmyvehical/auth/auth_service.dart';
import 'package:findmyvehical/home/ProfilePage.dart';
import 'package:flutter/material.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: (){
              gotoprofile(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.fromLTRB(10,10,10,10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Text("Profile",style: TextStyle(fontSize: 25),),
              ),
            ),
          ),
          InkWell(
            onTap: (){
      AlertDialog(
    title: const Text('You are Signing out'),
    content: const SingleChildScrollView(
    child: ListBody(
    children: <Widget>[
    Text('You will sign out but can login again.'),
    ],
    ),
    ),
    actions: <Widget>[
    TextButton(
    child: const Text('Approve'),
    onPressed: () {
      _auth.signOut();
    },
    ),
    ],
      );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.fromLTRB(10,10,10,10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text("Sign Out",style: TextStyle(fontSize: 25),),
              ),
            ),
          ),
          InkWell(
            onTap: (){
              SnackBar(content: Text("This feature will come out soon"),);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                margin: EdgeInsets.fromLTRB(10,10,10,10),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Text("Themes",style: TextStyle(fontSize: 25),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  gotoprofile(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Profilepage()));

}
