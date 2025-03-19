class Msg {
  int id = 0;
  String text;
  int from;
  int to;
  DateTime createAt = DateTime.now();
  Privacy privacy;

  Msg({
    required this.text,
    required this.from,
    required this.to,
    this.privacy = Privacy.public,
  });
}

enum Privacy { private, public }
