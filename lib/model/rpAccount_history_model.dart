// To parse this JSON data, do
//
//     final rpAccountHistoryModel = rpAccountHistoryModelFromJson(jsonString);

import 'dart:convert';

RpAccountHistoryModel rpAccountHistoryModelFromJson(String str) =>
    RpAccountHistoryModel.fromJson(json.decode(str));

String rpAccountHistoryModelToJson(RpAccountHistoryModel data) =>
    json.encode(data.toJson());

class RpAccountHistoryModel {
  RpAccountHistoryModel({
    this.totalIncome,
    this.totalExpense,
    this.balance,
    this.data,
  });

  int? totalIncome;
  int? totalExpense;
  int? balance;
  List<Datum>? data;

  factory RpAccountHistoryModel.fromJson(Map<String, dynamic> json) =>
      RpAccountHistoryModel(
        totalIncome: json["total_income"] == null ? null : json["total_income"],
        totalExpense:
            json["total_expense"] == null ? null : json["total_expense"],
        balance: json["balance"] == null ? null : json["balance"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_income": totalIncome == null ? null : totalIncome,
        "total_expense": totalExpense == null ? null : totalExpense,
        "balance": balance == null ? null : balance,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.date,
    this.balance,
    this.entries,
  });

  DateTime? date;
  int? balance;
  List<Entry>? entries;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        balance: json["balance"] == null ? null : json["balance"],
        entries: json["entries"] == null
            ? null
            : List<Entry>.from(json["entries"].map((x) => Entry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "balance": balance == null ? null : balance,
        "entries": entries == null
            ? null
            : List<dynamic>.from(entries!.map((x) => x.toJson())),
      };
}

class Entry {
  Entry({
    this.id,
    this.quantity,
    this.amountPerUnit,
    this.date,
    this.totalAmount,
    this.name,
    this.unit,
  });

  int? id;
  String? quantity;
  String? amountPerUnit;
  DateTime? date;
  String? totalAmount;
  String? name;
  String? unit;

  factory Entry.fromJson(Map<String, dynamic> json) => Entry(
        id: json["id"] == null ? null : json["id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        amountPerUnit:
            json["amount_per_unit"] == null ? null : json["amount_per_unit"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        totalAmount: json["total_amount"] == null ? null : json["total_amount"],
        name: json["name"] == null ? null : json["name"],
        unit: json["unit"] == null ? null : json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "quantity": quantity == null ? null : quantity,
        "amount_per_unit": amountPerUnit == null ? null : amountPerUnit,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "total_amount": totalAmount == null ? null : totalAmount,
        "name": name == null ? null : name,
        "unit": unit == null ? null : unit,
      };
}
