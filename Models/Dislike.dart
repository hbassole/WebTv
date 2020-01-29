class Dislike {
  int id;

  Dislike({
    this.id,
  });

  factory Dislike.fromJson(Map<String, dynamic> json) => Dislike(
    id: json["id"],
  );

}