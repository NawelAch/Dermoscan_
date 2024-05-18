import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dermoscan/JsonModels/users.dart';
import 'package:dermoscan/sqlite/login_db.dart';
import 'package:image_picker/image_picker.dart';


class AccountPage extends StatefulWidget {
  final int userId;
  const AccountPage({Key? key, required this.userId}) : super(key: key);
  @override
  _AccountPageState createState() => _AccountPageState();
}
class _AccountPageState extends State<AccountPage> {
  late Future<Users?> _userData;
  File? imageFile; // Future to hold fetched user data
  @override
  void initState() {
    super.initState();
    _userData = _getUserData(widget.userId); // Fetch data on initialization
  }
  Future<Users?> _getUserData(int userId) async { // Accept userId as a parameter
    final db = DatabaseHelper();
    return await db.getUserData(userId);
  }
  Future<Uint8List> getImageBytes(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return bytes;
  }

  Future<void> updateProfilePicture() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      var imageFile = File(pickedFile.path);
      final bytes = await getImageBytes(imageFile);

      setState(() {
        imageFile = File(pickedFile.path);

      });

      final db = DatabaseHelper();
      await db.updateUserProfilePicture(widget.userId, bytes);

      setState(() {
        // Récupérer les nouvelles données de l'utilisateur
        _userData = _getUserData(widget.userId);
      });
    }

  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<Users?>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching user data'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        Stack(
                          children: [
                            user.usrProfilePicture != null
                                ? CircleAvatar(
                              radius: 70.0,
                              backgroundImage: MemoryImage(user.usrProfilePicture!),
                            )
                                : CircleAvatar(
                              radius: 70.0,
                              backgroundImage: const AssetImage('lib/assets/login.jpg'),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 20,
                                child: Center(
                                  child: IconButton(
                                    onPressed: updateProfilePicture,
                                    icon: const Icon(Icons.add_a_photo),
                                    color: Colors.white,
                                    iconSize: 23,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        // User details section
                        Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          color: Color(0xFFFCAF4FF).withOpacity(0.85),
                          child: Padding(
                            padding: const EdgeInsets.all(35.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.usrName,
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Icon(Icons.mail, size: 30.0, color: Colors.grey),
                                    SizedBox(width: 10.0),
                                    Expanded(
                                      child: Text(
                                        user.usrEmail ?? '(No email provided)',
                                        maxLines: 1, // Limite le nombre de lignes à 1 pour éviter le débordement
                                        overflow: TextOverflow.ellipsis, // Tronque le texte si nécessaire
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0), // Réduit légèrement l'espace entre les éléments
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, size: 30.0, color: Colors.grey),
                                    SizedBox(width: 10.0),
                                    Text(
                                      'Age: ${user.usrAge}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  children: [
                                    Icon(Icons.transgender, size: 30.0, color: Colors.grey),
                                    SizedBox(width: 10.0),
                                    Text(
                                      'Gender: ${user.usrGender}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No user data found'));
          }
        },
      ),
    );
  }
}

