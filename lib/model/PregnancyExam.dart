class PregnancyExam {
  PregnancyExam({
    this.id,
    this.farmId,
    this.cattleId,
    this.impregnationId,
    this.isPregnant,
    this.expectedDeliveryDate,
  });

  int? id;
  int? farmId;
  int? cattleId;
  int? impregnationId;
  int? isPregnant;
  String? expectedDeliveryDate;

  factory PregnancyExam.fromJson(Map<String, dynamic> json) => PregnancyExam(
    id: json["id"] == null ? null : json["id"],
    farmId: json["farm_id"] == null ? null : json["farm_id"],
    cattleId: json["cattle_id"] == null ? null : json["cattle_id"],
    impregnationId: json["impregnation_id"] == null ? null : json["impregnation_id"],
    isPregnant: json["is_pregnant"] == null ? null : json["is_pregnant"],
    expectedDeliveryDate: json["expected_delivery_date"] == null ? null : json["expected_delivery_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "farm_id": farmId == null ? null : farmId,
    "cattle_id": cattleId == null ? null : cattleId,
    "impregnation_id": impregnationId == null ? null : impregnationId,
    "is_pregnant": isPregnant == null ? null : isPregnant,
    "expected_delivery_date": expectedDeliveryDate == null ? null : expectedDeliveryDate,
  };
}
