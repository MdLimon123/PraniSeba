class Production {
  Production({
    this.cattleId,
    this.value,
  });

  int? cattleId;
  int? value;

  factory Production.fromJson(Map<String, dynamic> json) => Production(
    cattleId: json["cattle_id"] == null ? null : json["cattle_id"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "cattle_id": cattleId == null ? null : cattleId,
    "value": value == null ? null : value,
  };
}
