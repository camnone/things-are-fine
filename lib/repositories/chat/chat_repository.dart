import 'package:flutter/material.dart';
import 'package:thingsarefine/repositories/chat/abstract_chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thingsarefine/repositories/chat/model/chat_model.dart';
import 'package:thingsarefine/repositories/app/app_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';

class ChatRepository implements AbstractChatService {
  ChatRepository({
    required this.prefs,
    required this.firestore,
    required this.appRepository,
    required this.dio,
  });
  final SharedPreferences prefs;
  final FirebaseFirestore firestore;
  final AppRepository appRepository;
  final Dio dio;

  @override
  Future<void> saveMessage(Message data) async {
    await firestore.collection("chats").doc(data.id).set(data.toMap());
  }

  Future<void> clearHistory() async {
    final data = await firestore
        .collection("chats")
        .where("userID",
            isEqualTo: appRepository.getValue(appRepository.uidKey))
        .get();
    for (int i = 0; i < data.docs.length; i++) {
      await firestore.collection("chats").doc(data.docs[i]["id"]).delete();
    }
  }

  @override
  Future<void> sendBotMessage(String message) async {
    try {
      final history = await createChatHistory(message);

      final res = await dio
          .post("https://finksapitodo.com/finks", data: {"messages": history});

      await saveMessage(
        Message(
          id: const Uuid().v4().toString(),
          userID: appRepository.getValue(appRepository.uidKey)!,
          botID: appRepository.getValue(appRepository.bidKey)!,
          isUser: true,
          message: res.data["answer"],
          timestamp: Timestamp.now(),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> sendUserMessage(String message) async {
    await saveMessage(Message(
      id: const Uuid().v4().toString(),
      userID: appRepository.getValue(appRepository.uidKey)!,
      botID: appRepository.getValue(appRepository.bidKey)!,
      isUser: true,
      message: message,
      timestamp: Timestamp.now(),
    ));
  }

  Future<List> createChatHistory(String message) async {
    final List history = [
      {
        "content":
            "You are an assistant who helps to make a list of tasks for users",
        "role": "assistant"
      }
    ];

    final userMessages = await firestore
        .collection("chats")
        .where("userID",
            isEqualTo: appRepository.getValue(appRepository.uidKey)!)
        .get();

    for (int i = 0; i < userMessages.docs.length; i++) {
      if (userMessages.docs[i].data()["isUser"] == true) {
        history.add({
          "role": "user",
          "content": userMessages.docs[i].data()["message"]
        });
      } else {
        history.add({
          "role": "assistant",
          "content": userMessages.docs[i].data()["message"]
        });
      }
    }
    history.add({"role": "user", "content": message});

    return history;
  }
}
