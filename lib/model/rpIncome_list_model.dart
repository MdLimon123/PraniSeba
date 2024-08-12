// To parse this JSON data, do
//
//     final rpIncomeListModel = rpIncomeListModelFromJson(jsonString);

import 'dart:convert';

RpIncomeListModel rpIncomeListModelFromJson(String str) =>
    RpIncomeListModel.fromJson(json.decode(str));

String rpIncomeListModelToJson(RpIncomeListModel data) =>
    json.encode(data.toJson());

class RpIncomeListModel {
  RpIncomeListModel({
    this.totalQuantity,
    this.totalAmount,
    this.data,
  });

  int? totalQuantity;
  int? totalAmount;
  List<Datum>? data;

  factory RpIncomeListModel.fromJson(Map<String, dynamic> json) =>
      RpIncomeListModel(
        totalQuantity:
            json["total_quantity"] == null ? null : json["total_quantity"],
        totalAmount: json["total_amount"] == null ? null : json["total_amount"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_quantity": totalQuantity == null ? null : totalQuantity,
        "total_amount": totalAmount == null ? null : totalAmount,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.accountId,
    this.quantity,
    this.amountPerUnit,
    this.date,
    this.totalAmount,
  });

  int? id;
  int? accountId;
  String? quantity;
  String? amountPerUnit;
  DateTime? date;
  String? totalAmount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        accountId: json["account_id"] == null ? null : json["account_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        amountPerUnit:
            json["amount_per_unit"] == null ? null : json["amount_per_unit"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        totalAmount: json["total_amount"] == null ? null : json["total_amount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "account_id": accountId == null ? null : accountId,
        "quantity": quantity == null ? null : quantity,
        "amount_per_unit": amountPerUnit == null ? null : amountPerUnit,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "total_amount": totalAmount == null ? null : totalAmount,
      };
}
