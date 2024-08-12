class FoodConsumWeightModel {
  int? cattleCount;
  List<Data>? data;

  FoodConsumWeightModel({this.cattleCount, this.data});

  FoodConsumWeightModel.fromJson(Map<String, dynamic> json) {
    cattleCount = json['cattle_count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cattle_count'] = this.cattleCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? sl;
  int? farmId;
  int? cattleId;
  String? date;
  bool? hasConsumedFood;
  bool? hasMeasuredWeight;

  Data(
      {this.sl,
        this.farmId,
        this.cattleId,
        this.date,
        this.hasConsumedFood,
        this.hasMeasuredWeight});

  Data.fromJson(Map<String, dynamic> json) {
    sl = json['sl'];
    farmId = json['farm_id'];
    cattleId = json['cattle_id'];
    date = json['date'];
    hasConsumedFood = json['has_consumed_food'];
    hasMeasuredWeight = json['has_measured_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sl'] = this.sl;
    data['farm_id'] = this.farmId;
    data['cattle_id'] = this.cattleId;
    data['date'] = this.date;
    data['has_consumed_food'] = this.hasConsumedFood;
    data['has_measured_weight'] = this.hasMeasuredWeight;
    return data;
  }
}
