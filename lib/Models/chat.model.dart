class User {
  final String? id;
  final String? name;
  final String? cellphone;
  final bool? isAvatar;
  final String? avatar;

  User({
    this.id,
    this.name,
    this.cellphone,
    this.isAvatar,
    this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      cellphone: json['cellphone'],
      isAvatar: json['isAvatar'],
      avatar: json['avatar'],
    );
  }
}

class LastMessage {
  final String? id;
  final User? sender;
  final String? recipientType;
  final User? receiver;
  final String? message;
  final bool? read;
  final bool? isFile;
  final String? file;
  final List<dynamic>? deletedBy;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  LastMessage({
    this.id,
    this.sender,
    this.recipientType,
    this.receiver,
    this.message,
    this.read,
    this.isFile,
    this.file,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      id: json['_id'],
      sender: User.fromJson(json['sender']),
      recipientType: json['recipient_type'],
      receiver: User.fromJson(json['receiver']),
      message: json['message'],
      read: json['read'],
      isFile: json['isFile'],
      file: json['file'],
      deletedBy: json['deletedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class LastMessageResponse {
  final List<LastMessages>? lastMessages;
  final ErrorMessage? error;

  LastMessageResponse({this.lastMessages, this.error});

  factory LastMessageResponse.fromJson(Map<String, dynamic> json) {
    return LastMessageResponse(
      lastMessages: (json['lastMessages'] as List<dynamic>?)
          ?.map((item) => LastMessages.fromJson(item))
          .toList(),
      error: ErrorMessage.fromJson(json['error']),
    );
  }
}

class ErrorMessage {
  final String? error;
  ErrorMessage({this.error});

  factory ErrorMessage.fromJson(dynamic json) {
    if (json is String) {
      return ErrorMessage(error: json);
    } else if (json is Map<String, dynamic>) {
      return ErrorMessage(error: json['error']);
    } else {
      return ErrorMessage(error: '');
    }
  }
}

class LastMessages {
  final User? receiver;
  final LastMessage? lastMessage;
  final int? unreadCount;
  final List<LastMessage>? filteredMessages;

  LastMessages({
    this.receiver,
    this.lastMessage,
    this.unreadCount,
    this.filteredMessages,
  });

  factory LastMessages.fromJson(Map<String, dynamic> json) {
    return LastMessages(
      receiver:
          json['receiver'] != null ? User.fromJson(json['receiver']) : null,
      lastMessage: json['lastMessage'] != null
          ? LastMessage.fromJson(json['lastMessage'])
          : null,
      unreadCount: json['unreadCount'],
      filteredMessages: (json['filteredMessages'] as List<dynamic>?)
          ?.map((item) => LastMessage.fromJson(item))
          .toList(),
    );
  }
}
