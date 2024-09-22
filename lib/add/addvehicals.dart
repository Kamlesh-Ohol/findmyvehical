import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Addvehicalpage extends StatefulWidget {
  const Addvehicalpage({super.key, required String initialType, required String initialName});

  @override
  _AddvehicalpageState createState() => _AddvehicalpageState();
}

class _AddvehicalpageState extends State<Addvehicalpage> {
  final TextEditingController _vehicalController = TextEditingController();
  String _selectedVehicleType = 'car'; // Default vehicle type
  final storage = FirebaseStorage.instance;
  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  final FirebaseApp secondaryApp = Firebase.app('find-my-ride-279d6');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Vehicle'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Select Type of Vehicle"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildVehicleTypeIcon('bike', 'assets/images/motorcycle.png'),
                  _buildVehicleTypeIcon('car', 'assets/images/car.png'),
                  _buildVehicleTypeIcon('scooter', 'assets/images/scooter.png'),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Enter Name of the Vehicle"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _vehicalController,
                  decoration: InputDecoration(
                    hintText: "Enter name of the vehicle",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_vehicalController.text.isNotEmpty) {
                      // Store vehicle data in Firebase Realtime Database
                      await ref.child("vehicles").push().set({
                        'Icon': _selectedVehicleType,
                        'VehicleName': _vehicalController.text,
                      });

                      // Navigate back to the previous screen after storing data
                      Navigator.pop(context, {
                        'Icon': _selectedVehicleType,
                        'VehicleName': _vehicalController.text,
                      });
                    } else {
                      // Show a message if the text field is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a vehicle name')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: const Text("Create"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build vehicle type icons
  Widget _buildVehicleTypeIcon(String type, String image) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVehicleType = type;
        });
      },
      child: Column(
        children: [
          Image.asset(
            image,
            scale: 10,
            color: _selectedVehicleType == type ? Colors.blue : Colors.grey,
          ),
          Text(type),
        ],
      ),
    );
  }
}
