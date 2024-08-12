class ReportMonthlyPaymentModel {
  int? totalIncome;
  int? totalExpense;
  int? balance;
  List<Data>? data;

  ReportMonthlyPaymentModel(
      {this.totalIncome, this.totalExpense, this.balance, this.data});

  ReportMonthlyPaymentModel.fromJson(Map<String, dynamic> json) {
    totalIncome = json['total_income'];
    totalExpense = json['total_expense'];
    balance = json['balance'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_income'] = this.totalIncome;
    data['total_expense'] = this.totalExpense;
    data['balance'] = this.balance;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? accountId;
  String? quantity;
  String? amountPerUnit;
  String? date;
  String? totalAmount;

  Data(
      {this.id,
        this.accountId,
        this.quantity,
        this.amountPerUnit,
        this.date,
        this.totalAmount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    quantity = json['quantity'];
    amountPerUnit = json['amount_per_unit'];
    date = json['date'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_id'] = this.accountId;
    data['quantity'] = this.quantity;
    data['amount_per_unit'] = this.amountPerUnit;
    data['date'] = this.date;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}
