import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:kgchat/app/utils/date_utils/datetime_format.dart';

class UserModel extends Equatable {
  String? userID;
  final String? name;
  final String? lastName;
  String? profilePhoto;
  String? phone;
  final String? createdAt;
  final bool? isVIP;
  bool? isRegistered;

  UserModel({
    this.userID,
    this.name,
    this.lastName,
    this.createdAt,
    this.phone,
    this.profilePhoto,
    this.isVIP,
    this.isRegistered,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userID: json['userID'],
        name: json['name'],
        lastName: json['lastName'],
        profilePhoto: json['profilePhoto'],
        createdAt: DateTimeFormatter.timestampToString(json['createdAt']),
        phone: json['phone'],
        isVIP: json['isVIP'],
        isRegistered: json['isRegistered'] ?? false,
      );

  factory UserModel.fromCacheJson(Map<String, dynamic> json) => UserModel(
        userID: json['userID'],
        name: json['name'],
        lastName: json['lastName'],
        profilePhoto: json['profilePhoto'],
        createdAt: json['createdAt'],
        phone: json['phone'],
        isVIP: json['isVIP'],
        isRegistered: json['isRegistered'] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "userID": userID ?? '',
        "name": name ?? '',
        "lastName": lastName ?? '',
        "profilePhoto": profilePhoto ?? '',
        "phone": phone ?? '',
        "isVIP": isVIP ?? false,
        "isRegistered": isRegistered ?? false,
        "createdAt": FieldValue.serverTimestamp(),
      };

  Map<String, dynamic> toCacheJson() => {
        "userID": userID ?? '',
        "name": name ?? '',
        "lastName": lastName ?? '',
        "profilePhoto": profilePhoto ?? '',
        "phone": phone ?? '',
        "isVIP": isVIP ?? false,
        "isRegistered": isRegistered ?? false,
        "createdAt": DateTimeFormatter.dateTimeToString(DateTime.now()),
      };

  @override
  List<Object?> get props => [
        userID,
        name,
        lastName,
        profilePhoto,
        phone,
        isVIP,
        isRegistered,
      ];
}
