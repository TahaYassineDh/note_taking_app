class Note {
  String title;
  String content;
  String date;

  Note({
    required this.title,
    required this.content,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map['title'],
      content: map['content'],
      date: map['date'],
    );
  }
}
