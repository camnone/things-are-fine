import 'package:thingsarefine/repositories/chat/model/chat_model.dart';

abstract interface class AbstractChatService {
  Future<void> saveMessage(Message data);
  Future<void> sendUserMessage(String message);
  Future<void> sendBotMessage(String message);
}
