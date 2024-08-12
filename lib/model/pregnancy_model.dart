class PregnancyModel {
  int? cattleCount;
  List<Data>? data;

  PregnancyModel({this.cattleCount, this.data});

  PregnancyModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? farmId;
  int? cattleId;
  int? impregnationId;
  int? isPregnant;
  String? expectedDeliveryDate;

  Data(
      {this.id,
        this.farmId,
        this.cattleId,
        this.impregnationId,
        this.isPregnant,
        this.expectedDeliveryDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmId = json['farm_id'];
    cattleId = json['cattle_id'];
    impregnationId = json['impregnation_id'];
    isPregnant = json['is_pregnant'];
    expectedDeliveryDate = json['expected_delivery_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farm_id'] = this.farmId;
    data['cattle_id'] = this.cattleId;
    data['impregnation_id'] = this.impregnationId;
    data['is_pregnant'] = this.isPregnant;
    data['expected_delivery_date'] = this.expectedDeliveryDate;
    return data;
  }
}
