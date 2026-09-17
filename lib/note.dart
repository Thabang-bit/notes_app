class Note { String id; String title; String body; DateTime lastEdited; 
Note({ required this.id, required this.title, required this.body, required this.lastEdited, }); 
Map<String, dynamic> toJson() => { 'id': id, 'title': title, 'body': body, 'lastEdited': lastEdited.toIso8601String(), }; 
factory Note.fromJson(Map<String, dynamic> json) => Note( id: json['id'], title: json['title'], body: json['body'], 
lastEdited: DateTime.parse(json['lastEdited']), ); }