class TaskModel {
  String id;
  String? title = '';
  String? describition = '';
  String? userId;
  bool stutes = false;
  int date;

  TaskModel(
      {this.id = '',
      required this.title,
      required this.date,
      required this.describition,
      required this.userId,
      required this.stutes});

  TaskModel.fromJson(Map<String?, dynamic> json)
      : this(
          id: json['id'],
          title: json['title'],
          stutes: json['stutes'],
          describition: json['describition'],
          userId: json['userId'],
          date: json['date'],
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'stutes': stutes,
      'describition': describition,
      'userId': userId,
      'date': date
    };
  }
}
