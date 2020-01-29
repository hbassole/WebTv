class Like {
  int id;

  Like({
    this.id,
  });

  factory Like.fromJson(Map<String, dynamic> json) => Like(
    id: json["id"],
  );

}