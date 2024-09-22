import 'package:findmyvehical/auth/auth_service.dart';
import 'package:findmyvehical/home/Settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../add/Maps.dart';
import '../add/addvehicals.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../login/signin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _email = getmail().S;
  List<Map<String, dynamic>> vehicles = [];
  final storage = FirebaseStorage.instance;
  FirebaseApp secondaryApp = Firebase.app('find-my-ride-279d6');
  final _auth = AuthService();
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child('vehicles');

  @override
  void initState() {
    super.initState();
    _loadVehiclesFromDatabase();
  }

  // Fetch vehicle data from Firebase
  Future<void> _loadVehiclesFromDatabase() async {
    DatabaseEvent event = await ref.once();
    Map<dynamic, dynamic>? vehicleData = event.snapshot.value as Map?;
    if (vehicleData != null) {
      // Assuming that "Email" is used as the key for each entry
      vehicleData.forEach((email, data) {
        vehicles.add({
          'email': _email, // Store email for reference if needed
          'type': data['Icon']?.toString() ?? '', // Cast to String
          'VehicalName': data['VehicalName']?.toString() ?? '', // Cast to String
        });
      });

      setState(() {
        vehicles = vehicles; // Update the vehicle list with loaded data
      });
    }
  }

  Future<void> _goToAddPage(BuildContext context) async {
    final newVehicle = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Addvehicalpage(
          initialType: '',
          initialName: '',
        ),
      ),
    );

    if (newVehicle != null) {
      String email = 'user@example.com'; // Replace this with actual email

      await ref.child(email).set({
        'Icon': newVehicle['Icon'],
        'VehicalName': newVehicle['VehicalName'],
      });

      setState(() {
        vehicles.add({
          'email': email,
          'type': newVehicle['Icon'],
          'VehicalName': newVehicle['VehicalName'],
        });
      });
    }
  }

  Future<void> _editVehicle(BuildContext context, int index) async {
    final editedVehicle = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Addvehicalpage(
          initialType: vehicles[index]['type'] ?? '',
          initialName: vehicles[index]['VehicalName'] ?? '',
        ),
      ),
    );

    if (editedVehicle != null) {
      String email = vehicles[index]['email'];

      await ref.child(email).update({
        'Icon': editedVehicle['Icon'],
        'VehicalName': editedVehicle['VehicalName'],
      });

      setState(() {
        vehicles[index] = {
          'email': email,
          'type': editedVehicle['Icon'],
          'VehicalName': editedVehicle['VehicalName'],
        };
      });
    }
  }

  void _deleteVehicle(int index) async {
    String email = vehicles[index]['email'];
    await ref.child(email).remove();

    setState(() {
      vehicles.removeAt(index);
    });
  }

  Widget _vehicleContainer(
      BuildContext context, String vehicleType, String vehicleName, int index) {
    Image vehicleImage;
    switch (vehicleType) {
      case 'bike':
        vehicleImage = Image.asset('assets/images/motorcycle.png', scale: 10);
        break;
      case 'car':
        vehicleImage = Image.asset('assets/images/car.png', scale: 10);
        break;
      case 'scooter':
        vehicleImage = Image.asset('assets/images/scooter.png', scale: 10);
        break;
      default:
        vehicleImage = Image.asset('assets/images/car.png', scale: 10);
    }

    return GestureDetector(
      onTap: () {
        gotoMaps(context);
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            vehicleImage,
            Text(vehicleName),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (String result) {
                if (result == 'edit') {
                  _editVehicle(context, index);
                } else if (result == 'delete') {
                  _deleteVehicle(index);
                }
              },
              itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                gotoSettings(context);
              },
            ),
            ListTile(
              title: const Text('About'),
              onTap: () {
                //Todo: go to about
              },
            ),
            ListTile(
              title: const Text('Signout'),
              onTap: () {
                _auth.signOut();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Vehicle List'),
        actions: [
          IconButton(
            onPressed: () => _goToAddPage(context),
            icon: const Icon(Icons.add, color: Color.fromRGBO(53, 9, 84, 100)),
          ),
        ],
        backgroundColor: const Color.fromRGBO(189, 189, 219, 100),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: vehicles.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/boring.json',
                width: 500,
                height: 500,
              ),
              const SizedBox(height: 20),
              const Text(
                'No vehicle added',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
            : SingleChildScrollView(
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: vehicles.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> vehicle = entry.value;
              return _vehicleContainer(
                  context, vehicle['type']?.toString() ?? '', vehicle['VehicalName']?.toString() ?? '', index);
            }).toList(),
          ),
        ),
      ),
    );
  }

  gotoSettings(BuildContext context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => const SettingsPage()));

  gotoMaps(BuildContext context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => Maps()));
}
