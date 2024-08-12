
class Food {
  Food({
    this.cattleFoodId,
    this.value,
  });

  int? cattleFoodId;
  int? value;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
    cattleFoodId: json["cattle_food_id"] == null ? null : json["cattle_food_id"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "cattle_food_id": cattleFoodId == null ? null : cattleFoodId,
    "value": value == null ? null : value,
  };
}
