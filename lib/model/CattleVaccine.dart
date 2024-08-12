class CattleVaccine {
  CattleVaccine({
    this.id,
    this.diseaseId,
    this.name,
  });

  int? id;
  String? diseaseId;
  String? name;

  factory CattleVaccine.fromJson(Map<String, dynamic> json) => CattleVaccine(
        id: json["id"] == null ? null : json["id"],
        diseaseId: json["disease_id"] == " " ? " " : json["disease_id"] ?? "",
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "disease_id": diseaseId == null ? null : diseaseId,
        "name": name == null ? null : name,
      };
}
