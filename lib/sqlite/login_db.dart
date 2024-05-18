import 'dart:typed_data';
import 'package:dermoscan/models/previous_scan_result.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:dermoscan/JsonModels/users.dart';
import 'dart:io';


class DatabaseHelper {
  final databaseName = "skin_cancer.db";

  String createUserTable = """
    CREATE TABLE users (
      usrId INTEGER PRIMARY KEY AUTOINCREMENT,
      usrName TEXT UNIQUE,
      usrPassword TEXT,
      usrAge INTEGER,
      usrGender TEXT,
      usrEmail Text,
      usrProfilePicture BLOB
    )
  """;

  String createScanResultsTable = """
    CREATE TABLE scan_results (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userId INTEGER,
      scanDate TEXT,
      scanResult TEXT,
      scanImage BLOB
    )
  """;

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    // Increment the version number to trigger the onUpgrade function
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(createUserTable);
      await db.execute(createScanResultsTable);// Initial table creation
    }, onUpgrade: onUpgrade);
  }

  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('onUpgrade called. oldVersion: $oldVersion, newVersion: $newVersion');
    if (oldVersion < newVersion) {
      print('Executing upgrade SQL statements...');
      await db.execute("ALTER TABLE users ADD COLUMN usrAge INTEGER;");
      await db.execute("ALTER TABLE users ADD COLUMN usrGender TEXT;");
      await db.execute("ALTER TABLE users ADD COLUMN usrEmail TEXT;");
      print('Upgrade completed.');
    }
    await db.execute("ALTER TABLE users ADD COLUMN usrProfilePicture BLOB;");

    print('Upgrade completed.');



  }

  Future<bool> login(Users user) async {
    final Database db = await initDB();
    var result = await db.query(
      'users',
      where: 'usrName = ? AND usrPassword = ?',
      whereArgs: [user.usrName, user.usrPassword],
    );
    return result.isNotEmpty;
  }

  Future<void> signup(Users user, String ageText, String selectedGender) async {
    final Database db = await initDB();

    int? parsedAge;
    try {
      // Trim any leading or trailing whitespace from ageText
      final trimmedAgeText = ageText.trim();
      parsedAge = int.parse(trimmedAgeText);
    } catch (e) {
      print("Error parsing age: $e");
      // Handle the case where age text is not a valid integer
      throw Exception("Invalid age");
    }

    // Add user data to the database
    try {
      final id = await db.insert('users', {
        'usrName': user.usrName,
        'usrPassword': user.usrPassword,
        'usrAge': parsedAge,
        'usrGender': selectedGender,
        'usrEmail': user.usrEmail,
      });
      print("User added with id: $id");
    } catch (error) {
      print("Error saving user: $error"); // Handle database errors
      throw Exception("Error saving user");
    }
  }

  Future<Users?> getUserData(int userId) async {
    try {
      final db = await initDB();
      final List<Map<String, dynamic>> data = await db.query(
        'users',
        where: 'usrId = ?',
        whereArgs: [userId],
      );
      if (data.isNotEmpty) {
        return Users.fromMap(data.first);
      } else {
        print('User data not found for ID: $userId');
        return null; // Return null if user data is not found
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null; // Return null in case of any error
    }
  }

  Future<Users> getUserByUsername(String username) async {
    final Database db = await initDB();
    var result = await db.query(
      'users',
      where: 'usrName = ?',
      whereArgs: [username],
    );
    return Users.fromMap(result.first);
  }


  Future<void> updateUserProfilePicture(int userId,
      Uint8List profilePictureBytes) async {
    final db = await initDB();
    await db.update(
      'users',
      {'usrProfilePicture': profilePictureBytes},
      where: 'usrId = ?',
      whereArgs: [userId],
    );
  }

  Future<void> saveScanResult(int userId, String scanDate, String scanResult, Uint8List scanImage) async {
    final Database db = await initDB();
    await db.insert('scan_results', {
      'userId': userId,
      'scanDate': scanDate,
      'scanResult': scanResult,
      'scanImage': scanImage,
    });
  }

  Future<List<PreviousScanResult>> getPreviousScanResults(int userId) async {
    final Database db = await initDB();
    final results = await db.query('scan_results', where: 'userId = ?', whereArgs: [userId]);
    return results.map((result) => PreviousScanResult.fromMap(result)).toList();
  }
}