class BalanceResponse {
  BTC? bTC;

  BalanceResponse({this.bTC});

  BalanceResponse.fromJson(Map<String, dynamic> json) {
    bTC = json['BTC'] != null ? BTC.fromJson(json['BTC']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bTC != null) {
      data['BTC'] = bTC!.toJson();
    }
    return data;
  }
}

class BTC {
  int? availableBalance;

  BTC({this.availableBalance});

  BTC.fromJson(Map<String, dynamic> json) {
    availableBalance = json['AvailableBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AvailableBalance'] = availableBalance;
    return data;
  }
}
