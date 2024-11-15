import 'dart:convert';
import 'dart:developer';

import 'package:flutter_vision/features/home/domain/entities/ticket.dart';

class ChatCompletionResponse {
  final String id;
  final String object;
  final int created;
  final String model;
  final Choice choice;
  final Usage usage;

  ChatCompletionResponse({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choice,
    required this.usage,
  });

  factory ChatCompletionResponse.fromJson(Map<String, dynamic> json) {
    return ChatCompletionResponse(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      choice: Choice.fromJson(json['choices'][0]), // Only the first choice
      usage: Usage.fromJson(json['usage']),
    );
  }
}

class Choice {
  final Message message;
  final String finishReason;
  final int index;

  Choice({
    required this.message,
    required this.finishReason,
    required this.index,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      message: Message.fromJson(json['message']),
      finishReason: json['finish_reason'],
      index: json['index'],
    );
  }
  String cleanResponse(String response) {
    String cleanedResponse = response.replaceAll('```', "");
    cleanedResponse = cleanedResponse.replaceAll(
        RegExp(r'\bjson\b', caseSensitive: false), '');
    return cleanedResponse;
  }

  Ticket getTicket() {
    final content = cleanResponse(message.content);
    final json = jsonDecode(content);
    log(json.toString());

    return Ticket.fromJson(json);
  }
}

class Message {
  final String role;
  final String content;

  Message({
    required this.role,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      role: json['role'],
      content: json['content'],
    );
  }
}

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}
