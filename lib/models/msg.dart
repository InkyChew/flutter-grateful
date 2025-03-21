class Msg {
  int id;
  String text;
  int from;
  int to;
  DateTime createAt = DateTime.now();
  Privacy privacy;

  Msg({
    this.id = 0,
    required this.text,
    required this.from,
    required this.to,
    this.privacy = Privacy.public,
  });
}

enum Privacy { private, public }
