class EAccount {
  EAccount({
    this.id,
    this.type,
    this.name,
  });

  int? id;
  String? type;
  String? name;

  factory EAccount.fromJson(Map<String, dynamic> json) => EAccount(
    id: json["id"] == null ? null : json["id"],
    type: json["type"] == null ? null : json["type"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "type": type == null ? null : type,
    "name": name == null ? null : name,
  };
}