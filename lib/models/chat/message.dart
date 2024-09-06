class Message {
  String from;
  String to;
  String message;
  String date;
  List<String> likes = [];

  Message({
    required this.from,
    required this.to,
    required this.date,
    required this.message,
  });

  Message.fromJson(Map<String, dynamic> json)
      : from = json['from'],
        to = json['to'],
  message = json['message'],
        date = json['date'] {
    if (json['likes'].isNotEmpty) {
      json['likes'].forEach((e) {
        likes.add(e);
      });
    }
  }

  Map<String,dynamic> get toJson=>{
    'message' : message,
    'from' : from,
    'to'  : to,
    'date' : date,
    'likes' : likes,
  };
}
