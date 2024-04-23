import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class Message {
  final String id;
  final String userID;
  final String botID;
  final String message;
  final bool isUser;
  final Timestamp timestamp;

  const Message({
    required this.id,
    required this.userID,
    required this.botID,
    required this.isUser,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userID": userID,
      "botID": botID,
      "message": message,
      "timestamp": timestamp,
      "isUser": isUser,
    };
  }
}

@immutable
class ChatStructure {
  final String id;
  final Object message;

  const ChatStructure({required this.id, required this.message});
}
