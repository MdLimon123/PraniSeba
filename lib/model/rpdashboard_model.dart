// To parse this JSON data, do
//
//     final rpDashboardModel = rpDashboardModelFromJson(jsonString);

import 'dart:convert';

RpDashboardModel rpDashboardModelFromJson(String str) =>
    RpDashboardModel.fromJson(json.decode(str));

String rpDashboardModelToJson(RpDashboardModel data) =>
    json.encode(data.toJson());

class RpDashboardModel {
  RpDashboardModel({
    this.totalLoanPoints,
    this.totalPurchasePoints,
    this.totalSalePoints,
    this.totalHandCash,
    this.totalPaidPoints,
    this.totalAvailablePoints,
  });

  int? totalLoanPoints;
  int? totalPurchasePoints;
  int? totalSalePoints;
  int? totalHandCash;
  int? totalPaidPoints;
  int? totalAvailablePoints;

  factory RpDashboardModel.fromJson(Map<String, dynamic> json) =>
      RpDashboardModel(
        totalLoanPoints: json["total_loan_points"] == null
            ? null
            : json["total_loan_points"],
        totalPurchasePoints: json["total_purchase_points"] == null
            ? null
            : json["total_purchase_points"],
        totalSalePoints: json["total_sale_points"] == null
            ? null
            : json["total_sale_points"],
        totalHandCash:
            json["total_hand_cash"] == null ? null : json["total_hand_cash"],
        totalPaidPoints: json["total_paid_points"] == null
            ? null
            : json["total_paid_points"],
        totalAvailablePoints: json["total_available_points"] == null
            ? null
            : json["total_available_points"],
      );

  Map<String, dynamic> toJson() => {
        "total_loan_points": totalLoanPoints == null ? null : totalLoanPoints,
        "total_purchase_points":
            totalPurchasePoints == null ? null : totalPurchasePoints,
        "total_sale_points": totalSalePoints == null ? null : totalSalePoints,
        "total_hand_cash": totalHandCash == null ? null : totalHandCash,
        "total_paid_points": totalPaidPoints == null ? null : totalPaidPoints,
        "total_available_points":
            totalAvailablePoints == null ? null : totalAvailablePoints,
      };
}
