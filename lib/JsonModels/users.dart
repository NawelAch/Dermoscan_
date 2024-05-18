//In here first we create the users json model
// To parse this JSON data, do
//

import 'dart:typed_data';

class Users {
  final int? usrId;
  final String usrName;
  final String? usrEmail;
  final String usrPassword;
  int? usrAge;
  final String? usrGender;
  final Uint8List? usrProfilePicture;




  Users({
    this.usrId,
    this.usrEmail,
    required this.usrName,
    required this.usrPassword,
    this.usrAge,
    this.usrGender,
    this.usrProfilePicture

  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
    usrId: json["usrId"],
    usrName: json["usrName"] ?? "", // Provide a default value for usrName
    usrPassword: json["usrPassword"] ?? "", // Provide a default value for usrPassword
    usrAge: json["usrAge"] ?? 0, // Provide a default value for usrAge
    usrGender: json["usrGender"] ?? "", // Provide a default value for usrGender
    usrEmail: json["usrEmail"], // Keep usrEmail nullable if needed
    usrProfilePicture: json["usrProfilePicture"] != null
        ? Uint8List.fromList(json["usrProfilePicture"].cast<int>())
        : null,
  );


  Map<String, dynamic> toMap() => {
    "usrId": usrId,
    "usrName": usrName,
    "usrPassword": usrPassword,
    "usrAge":usrAge,
    "usrGender":usrGender,
    "usrEmail":usrEmail,
    "usrProfilePicture": usrProfilePicture?.toList(),

  };
}