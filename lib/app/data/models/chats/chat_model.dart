import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  ChatModel({
    this.text,
    this.recieverID,
    this.recieverName,
    this.recieverLastname,
    this.recieverAvatar,
    this.recieverPhone,
    this.senderID,
    this.senderName,
    this.senderLastname,
    this.senderAvatar,
    this.senderPhone,
    this.createdAt,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    // log('ChatModel.fromJson json ===>> $json');
    return ChatModel(
      text: json['text'] as String,
      recieverID: json['recieverID'] as String,
      recieverName: json['recieverName'] as String,
      recieverLastname: json['recieverLastname'] as String,
      recieverAvatar: json['recieverAvatar'] as String,
      recieverPhone: json['recieverPhone'] as String,
      senderID: json['senderID'] as String,
      senderName: json['senderName'] as String,
      senderLastname: json['senderLastname'] as String,
      senderAvatar: json['senderAvatar'] as String,
      senderPhone: json['senderPhone'] as String,
      createdAt: json['createdAt'],
    );
  }

  final String? text;
  final String? recieverID;
  final String? recieverName;
  final String? recieverLastname;
  final String? recieverAvatar;
  final String? recieverPhone;
  final String? senderID;
  final String? senderName;
  final String? senderLastname;
  final String? senderAvatar;
  final String? senderPhone;
  final Timestamp? createdAt;

  Map<String, Object> toJson() {
    return {
      'text': text!,
      'recieverID': recieverID!,
      'recieverName': recieverName!,
      'recieverLastname': recieverLastname!,
      'recieverAvatar': recieverAvatar!,
      'recieverPhone': recieverPhone!,
      'senderID': senderID!,
      'senderName': senderName!,
      'senderLastname': senderLastname!,
      'senderAvatar': senderAvatar!,
      'senderPhone': senderPhone!,
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
    };
  }
}
