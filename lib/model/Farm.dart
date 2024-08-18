// class Farm {
//   Farm({
//     this.id,
//     this.name,
//     this.divisionId,
//     this.districtId,
//     this.upazilaId,
//   });

//   int? id;
//   String? name;
//   int? divisionId;
//   int? districtId;
//   int? upazilaId;

//   factory Farm.fromJson(Map<String, dynamic> json) => Farm(
//     id: json["id"] == null ? null : json["id"],
//     name: json["name"] == null ? null : json["name"],
//     divisionId: json["division_id"] == null ? null : int.parse(json["division_id"]),
//     districtId: json["district_id"] == null ? null :int.parse( json["district_id"]),
//     upazilaId: json["upazila_id"] == null ? null : int.parse(json["upazila_id"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id == null ? null : id,
//     "name": name == null ? null : name,
//     "division_id": divisionId == null ? null : divisionId,
//     "district_id": districtId == null ? null : districtId,
//     "upazila_id": upazilaId == null ? null : upazilaId,
//   };
// }

class Farm {
  Farm({
    this.id,
    this.name,
    this.divisionId,
    this.districtId,
    this.upazilaId,
  });

  int? id;
  String? name;
  int? divisionId;
  int? districtId;
  int? upazilaId;

  factory Farm.fromJson(Map<String, dynamic> json) => Farm(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    divisionId: json["division_id"] == null ? null : json["division_id"],
    districtId: json["district_id"] == null ? null : json["district_id"],
    upazilaId: json["upazila_id"] == null ? null : json["upazila_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "division_id": divisionId == null ? null : divisionId,
    "district_id": districtId == null ? null : districtId,
    "upazila_id": upazilaId == null ? null : upazilaId,
  };
}