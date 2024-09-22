import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                children: [

                  InkWell(
                    child: CircleAvatar(
                        maxRadius: 70,
                        child: IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.camera_alt)
                          ,iconSize: 60,)
                    ),
                  ),
                  Text("Create your profile",style: TextStyle(fontSize: 30),),
                ],
              ),
            ),
      ),
          Expanded(
            flex: 2, child: Row(
            children: [

            ],
          ),
               )
        ],
      ),
    );
  }
}
