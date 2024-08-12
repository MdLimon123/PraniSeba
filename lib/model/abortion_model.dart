class AbortionModel {
  int? cattleCount;
  List<Data>? data;

  AbortionModel({ this.cattleCount,  this.data});

  AbortionModel.fromJson(Map<String, dynamic> json) {
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
  int? pregnancyExamId;
  String? date;

  Data({this.id, this.farmId, this.cattleId, this.pregnancyExamId, this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmId = json['farm_id'];
    cattleId = json['cattle_id'];
    pregnancyExamId = json['pregnancy_exam_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farm_id'] = this.farmId;
    data['cattle_id'] = this.cattleId;
    data['pregnancy_exam_id'] = this.pregnancyExamId;
    data['date'] = this.date;
    return data;
  }
}
