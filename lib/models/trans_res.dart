/// This class is used to parse the transaction status response from the Worldline Payment Gateway.
///
/// {
///   "pgMeTrnRefNo": "95284059",
///   "orderId": "1687607892408",
///   "trnAmt": "100",
///   "authNStatus": "0",
///   "authZStatus": "0",
///   "captureStatus": "0",
///   "rrn": "",
///   "authZCode": "",
///   "responseCode": "",
///   "trnReqDate": "2023-06-24 17:28:14",
///   "statusCode": "F",
///   "statusDesc": "Transaction is failed",
///   "addField1": "",
///   "addField2": "",
///   "addField3": "",
///   "addField4": "",
///   "addField5": "",
///   "addField6": "",
///   "addField7": "",
///   "addField8": "",
///   "addField9": "",
///   "addField10": "{\"currency\":\"INR\"}",
///   "pgRefCancelReqId": "",
///   "refundAmt": ""
/// }
class TransResMsg {
  late String pgMeTrnRefNo;
  late String orderId;
  late String trnAmt;
  late String authNStatus;
  late String authZStatus;
  late String captureStatus;
  late String rrn;
  late String authZCode;
  late String responseCode;
  late String trnReqDate;
  late String statusCode;
  late String statusDesc;
  late String addField1;
  late String addField2;
  late String addField3;
  late String addField4;
  late String addField5;
  late String addField6;
  late String addField7;
  late String addField8;
  late String addField9;
  late String addField10;
  late String pgRefCancelReqId;
  late String refundAmt;

  TransResMsg({
    required this.pgMeTrnRefNo,
    required this.orderId,
    required this.trnAmt,
    required this.authNStatus,
    required this.authZStatus,
    required this.captureStatus,
    required this.rrn,
    required this.authZCode,
    required this.responseCode,
    required this.trnReqDate,
    required this.statusCode,
    required this.statusDesc,
    required this.addField1,
    required this.addField2,
    required this.addField3,
    required this.addField4,
    required this.addField5,
    required this.addField6,
    required this.addField7,
    required this.addField8,
    required this.addField9,
    required this.addField10,
    required this.pgRefCancelReqId,
    required this.refundAmt,
  });
  TransResMsg.fromJson(Map<String, dynamic> json) {
    pgMeTrnRefNo = json['pgMeTrnRefNo'].toString();
    orderId = json['orderId'].toString();
    trnAmt = json['trnAmt'].toString();
    authNStatus = json['authNStatus'].toString();
    authZStatus = json['authZStatus'].toString();
    captureStatus = json['captureStatus'].toString();
    rrn = json['rrn'].toString();
    authZCode = json['authZCode'].toString();
    responseCode = json['responseCode'].toString();
    trnReqDate = json['trnReqDate'].toString();
    statusCode = json['statusCode'].toString();
    statusDesc = json['statusDesc'].toString();
    addField1 = json['addField1'].toString();
    addField2 = json['addField2'].toString();
    addField3 = json['addField3'].toString();
    addField4 = json['addField4'].toString();
    addField5 = json['addField5'].toString();
    addField6 = json['addField6'].toString();
    addField7 = json['addField7'].toString();
    addField8 = json['addField8'].toString();
    addField9 = json['addField9'].toString();
    addField10 = json['addField10'].toString();
    pgRefCancelReqId = json['pgRefCancelReqId'].toString();
    refundAmt = json['refundAmt'].toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pgMeTrnRefNo'] = pgMeTrnRefNo;
    data['orderId'] = orderId;
    data['trnAmt'] = trnAmt;
    data['authNStatus'] = authNStatus;
    data['authZStatus'] = authZStatus;
    data['captureStatus'] = captureStatus;
    data['rrn'] = rrn;
    data['authZCode'] = authZCode;
    data['responseCode'] = responseCode;
    data['trnReqDate'] = trnReqDate;
    data['statusCode'] = statusCode;
    data['statusDesc'] = statusDesc;
    data['addField1'] = addField1;
    data['addField2'] = addField2;
    data['addField3'] = addField3;
    data['addField4'] = addField4;
    data['addField5'] = addField5;
    data['addField6'] = addField6;
    data['addField7'] = addField7;
    data['addField8'] = addField8;
    data['addField9'] = addField9;
    data['addField10'] = addField10;
    data['pgRefCancelReqId'] = pgRefCancelReqId;
    data['refundAmt'] = refundAmt;
    return data;
  }
}
