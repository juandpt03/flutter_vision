class ChatCompletionRequest {
  final String model;
  final List<Message> messages;
  final int maxTokens;

  ChatCompletionRequest({
    this.model = 'gpt-4o',
    List<Message>? messages,
    this.maxTokens = 1000,
  }) : messages = [
          Message(
            role: 'system',
            content: [
              ContentItem(
                type: 'text',
                text:
                    'Extract all relevant information from the provided image and format it as a JSON object matching this schema:'
                    '{'
                    '"website": "String",'
                    '"company": "String",'
                    '"ticket_number": "int",'
                    '"barcode": "String",'
                    '"items": ['
                    '{'
                    '"quantity": "int",'
                    '"product_code": "String",'
                    '"description": "String",'
                    '"size": "String",'
                    '"price": "int"'
                    '}'
                    '],'
                    '"return_policy": "String",'
                    '"machine": {'
                    '"model": "String",'
                    '"serial_number": "String"'
                    '},'
                    '"timestamp": "String"'
                    '}',
              )
            ],
          ),
        ];
  void addMessage(Message message) {
    messages.add(message);
  }

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'messages': messages.map((message) => message.toJson()).toList(),
      'max_tokens': maxTokens,
    };
  }

  ChatCompletionRequest copyWith({
    String? model,
    List<Message>? messages,
    int? maxTokens,
  }) {
    return ChatCompletionRequest(
      model: model ?? this.model,
      messages: messages ?? this.messages,
      maxTokens: maxTokens ?? this.maxTokens,
    );
  }
}

class Message {
  final String role;
  final List<ContentItem> content;

  Message({
    required this.role,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'content': content.map((item) => item.toJson()).toList(),
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      role: json['role'],
      content: (json['content'] as List)
          .map((item) => ContentItem.fromJson(item))
          .toList(),
    );
  }
}

class ContentItem {
  final String type;
  final String? text;
  final ImageUrl? imageUrl;

  ContentItem({
    required this.type,
    this.text,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'type': type,
    };
    if (text != null) {
      data['text'] = text;
    }
    if (imageUrl != null) {
      data['image_url'] = imageUrl!.toJson();
    }
    return data;
  }

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      type: json['type'],
      text: json['text'],
      imageUrl: json['image_url'] != null
          ? ImageUrl.fromJson(json['image_url'])
          : null,
    );
  }
}

class ImageUrl {
  final String url;

  ImageUrl({required this.url});

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }

  factory ImageUrl.fromJson(Map<String, dynamic> json) {
    return ImageUrl(
      url: json['url'],
    );
  }
}
