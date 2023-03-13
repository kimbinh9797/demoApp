class Todo {
  int? id;
  int? idUser;
  String? title;
  String? description;

  Todo({this.id, this.idUser, this.title, this.description});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_user'] = idUser;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
