class DiseaseModel {
  int? cattleCount;
  List<Datum>? data;

  DiseaseModel({this.cattleCount, this.data});

  DiseaseModel.fromJson(Map<String, dynamic> json) {
    cattleCount = json['cattle_count'];
    if (json['data'] != null) {
      data = <Datum>[];
      json['data'].forEach((v) {
        data!.add(new Datum.fromJson(v));
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

class Datum {
  int? id;
  int? farmId;
  int? cattleId;
  int? cattleDiseaseId;
  String? date;

  Datum({this.id, this.farmId, this.cattleId, this.cattleDiseaseId, this.date});

  Datum.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmId = json['farm_id'];
    cattleId = json['cattle_id'];
    cattleDiseaseId = json['cattle_disease_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farm_id'] = this.farmId;
    data['cattle_id'] = this.cattleId;
    data['cattle_disease_id'] = this.cattleDiseaseId;
    data['date'] = this.date;
    return data;
  }
}
