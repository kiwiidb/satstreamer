class InvoiceResponse {
  int? amt;
  String? description;
  int? expireTime;
  bool? ispaid;
  String? payReq;
  String? paymentHash;
  String? paymentRequest;
  int? timestamp;
  String? type;

  InvoiceResponse(
      {this.amt,
      this.description,
      this.expireTime,
      this.ispaid,
      this.payReq,
      this.paymentHash,
      this.paymentRequest,
      this.timestamp,
      this.type});

  InvoiceResponse.fromJson(Map<String, dynamic> json) {
    amt = json['amt'];
    description = json['description'];
    expireTime = json['expire_time'];
    ispaid = json['ispaid'];
    payReq = json['pay_req'];
    paymentHash = json['payment_hash'];
    paymentRequest = json['payment_request'];
    timestamp = json['timestamp'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amt'] = amt;
    data['description'] = description;
    data['expire_time'] = expireTime;
    data['ispaid'] = ispaid;
    data['pay_req'] = payReq;
    data['payment_hash'] = paymentHash;
    data['payment_request'] = paymentRequest;
    data['timestamp'] = timestamp;
    data['type'] = type;
    return data;
  }
}
