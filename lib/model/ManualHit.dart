class ManualHit {
  ManualHit({
    this.id,
    this.cattleId,
    this.date,
  });

  int? id;
  int? cattleId;
  String? date;

  factory ManualHit.fromJson(Map<String, dynamic> json) => ManualHit(
        id: json["id"] == null ? null : json["id"],
        cattleId: json["cattle_id"] == null ? null : json["cattle_id"],
        date: json["date"] == null ? null : json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "cattle_id": cattleId == null ? null : cattleId,
        "date": date == null ? null : date,
      };
}
