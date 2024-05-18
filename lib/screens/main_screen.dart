import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dermoscan/screens/Learn.dart';
import 'package:dermoscan/screens/account_screen.dart';
import 'package:dermoscan/screens/home_screen.dart';
import 'package:dermoscan/screens/results.dart';
import 'package:dermoscan/screens/storage_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final int defaultUserId = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skin Cancer Detection App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(userId: defaultUserId),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int? userId;
  MyHomePage({Key? key, required this.userId}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(
      source: source,
      maxHeight: 300, // Spécifiez la hauteur maximale de l'image capturée
      maxWidth: 300,  // Spécifiez la largeur maximale de l'image capturée
    );
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(image: image, userId: widget.userId!),
        ),
      );
    }
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[50],
        title: Text(

          _selectedIndex == 0
              ? 'Home'
              : (_selectedIndex == 1
              ? 'Scan History'
              : (_selectedIndex == 2
              ? 'Learn'
              : (_selectedIndex == 3 ? 'Account' : 'SkinDetection'))),
        ),
        elevation: 0,
      ),
      body: Center(
        child: _selectedIndex == 0
            ? HomePage()
            : (_selectedIndex == 1
            ? StorageScreen(userId: widget.userId!)
            : (_selectedIndex == 2
            ? Learn()
            : AccountPage(userId: widget.userId ?? 0))),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              icon: Icon(Icons.storage),
              color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
              onPressed: () {
                _onItemTapped(1);
              },
            ),
            SizedBox(width: 40), // The space for the floating action button
            IconButton(
              icon: Icon(Icons.school),
              color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
              onPressed: () {
                _onItemTapped(2);
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
              onPressed: () {
                _onItemTapped(3);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFCAF4FF).withOpacity(0.85), Colors.blue.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Choose an option'),
                    content: Text('Do you want to take a picture or select from gallery?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Camera', style: TextStyle(color: Colors.blueAccent)),
                        onPressed: () {
                          _pickImage(ImageSource.camera);
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Gallery', style: TextStyle(color: Colors.blueAccent)),
                        onPressed: () {
                          _pickImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.camera_alt, size: 30.0, color: Colors.black54),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}