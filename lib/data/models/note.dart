import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Note {
  final int id;
  final String title;
  final String? content;

  Note({
    this.id = 0,
    required this.title,
    required this.content,
  });

  Note copyWith({
    int? id,
    String? title,
    String? content,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int,
      title: map['title'] as String,
      content: map['content'] != null ? map['content'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Note(id: $id, title: $title, content: $content)';

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.content == content;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ content.hashCode;
}
