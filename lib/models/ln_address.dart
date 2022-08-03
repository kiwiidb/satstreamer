class LNAddressResponse {
  String? keysendPubkey;
  String? keysendCustomKey;
  String? keysendCustomValue;
  String? lightningAddress;

  LNAddressResponse(
      {this.keysendPubkey,
      this.keysendCustomKey,
      this.keysendCustomValue,
      this.lightningAddress});

  LNAddressResponse.fromJson(Map<String, dynamic> json) {
    keysendPubkey = json['keysend_pubkey'];
    keysendCustomKey = json['keysend_custom_key'];
    keysendCustomValue = json['keysend_custom_value'];
    lightningAddress = json['lightning_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['keysend_pubkey'] = keysendPubkey;
    data['keysend_custom_key'] = keysendCustomKey;
    data['keysend_custom_value'] = keysendCustomValue;
    data['lightning_address'] = lightningAddress;
    return data;
  }
}
