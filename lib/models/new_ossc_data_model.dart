// To parse this JSON data, do
//
//     final booked = bookedFromJson(jsonString);

import 'dart:convert';

OsscNew osscFromJson(String str) => OsscNew.fromJson(json.decode(str));

String osscToJson(OsscNew data) => json.encode(data.toJson());

class OsscNew {
  bool? success;
  List<OsscDataNew>? data;

  OsscNew({
    this.success,
    this.data,
  });

  factory OsscNew.fromJson(Map<String, dynamic> json) => OsscNew(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<OsscDataNew>.from(
                json["data"]!.map((x) => OsscDataNew.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OsscDataNew {
  DateTime? date;
  String? receiveNumber;
  String? customer;
  String? company;
  String? district;
  String? tel;
  String? act;
  String? type;
  String? desc;
  String? cost;
  String? slipUrl;
  String? doc;
  String? requestStaff;
  String? inspectionTeam;
  String? recivedDate;
  String? waitingToCheck;
  String? docStatus;
  String? checkLocation;
  String? results;
  String? sendResults;
  String? resultsStatus;
  String? officer2;
  // dynamic consider;
  // dynamic officer3;
  // dynamic approvalDate;
  String? recived;
  String? recivedResultDate;
  String? recivedName;
  String? recivedSign;
  String? license;
  String? licenseDate;
  String? licenseFee;
  String? licenseFeeSlip;
  String? placeNumber;
  String? licenseNumber;
  String? businessLicenseNumber;
  String? operationLicenseNumber;
  String? advertisingLicenseNumber;
  String? spaOperatorLicenseNumber;
  String? sign;
  String? receiveDate;
  String? parcelNumber;
  String? signature;
  String? status;

  OsscDataNew({
    this.date,
    this.receiveNumber,
    this.customer,
    this.company,
    this.district,
    this.tel,
    this.act,
    this.type,
    this.desc,
    this.cost,
    this.slipUrl,
    this.doc,
    this.requestStaff,
    this.inspectionTeam,
    this.recivedDate,
    this.waitingToCheck,
    this.docStatus,
    this.checkLocation,
    this.results,
    this.sendResults,
    this.resultsStatus,
    this.officer2,
    // this.consider,
    // this.officer3,
    // this.approvalDate,
    this.recived,
    this.recivedResultDate,
    this.recivedName,
    this.recivedSign,
    this.license,
    this.licenseDate,
    this.licenseFee,
    this.licenseFeeSlip,
    this.placeNumber,
    this.licenseNumber,
    this.businessLicenseNumber,
    this.operationLicenseNumber,
    this.advertisingLicenseNumber,
    this.spaOperatorLicenseNumber,
    this.sign,
    this.receiveDate,
    this.parcelNumber,
    this.signature,
    this.status,
  });

  factory OsscDataNew.fromJson(Map<String, dynamic> json) => OsscDataNew(
        date: json["date"] == null
            ? null
            : DateTime.parse(json["date"]),
        receiveNumber: json["receiveNumber"],
        customer: json["customer"],
        company: json["company"],
        district: json["district"],
        tel: json["tel"],
        act: json["act"],
        type: json["type"],
        desc: json["desc"],
        cost: json["cost"],
        slipUrl: json["slipUrl"],
        doc: json["doc"],
        requestStaff: json["requestStaff"],
        docStatus: json["docStatus"],
        inspectionTeam: json["inspectionTeam"],
        recivedDate: json["recivedDate"],
        waitingToCheck: json["waitingToCheck"],
        checkLocation: json["checkLocation"],
        results: json["results"],
        resultsStatus: json["resultsStatus"],
        sendResults: json["sendResults"],
        officer2: json["officer2"],
        // consider: json["เสนอพิจารณา"],//
        // officer3: json["เจ้าหน้าที่เสนอพิจารณา"],//
        // approvalDate: json["อนุมัติ"],//
        recived: json["recived"],
        recivedResultDate: json["recivedResultDate"],
        recivedName: json["recivedName"],
        recivedSign: json["recivedSign"],
        license: json["license"],
        licenseDate: json["licenseDate"],
        licenseFee: json["licenseFee"],
        licenseFeeSlip: json["licenseFeeSlip"],
        placeNumber: json["placeNumber"],
        licenseNumber: json["licenseNumber"],
        businessLicenseNumber: json["businessLicenseNumber"],
        operationLicenseNumber: json["operationLicenseNumber"],
        advertisingLicenseNumber: json["advertisingLicenseNumber"],
        spaOperatorLicenseNumber: json["spaOperatorLicenseNumber"],
        sign: json["sign"],
        receiveDate: json["receiveDate"],
        parcelNumber: json["parcelNumber"],
        signature: json["signature"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "receiveNumber": receiveNumber,
        "customer": customer,
        "company": company,
        "district": district,
        "tel": tel,
        "act.": act,
        "type": type,
        "desc": desc,
        "cost": cost,
        "slipUrl": slipUrl,
        "doc": doc,
        "requestStaff": requestStaff,
        "inspectionTeam": inspectionTeam,
        "recivedDate": recivedDate,
        "waitingToCheck": waitingToCheck,
        "docStatus": docStatus,
        "checkLocation": checkLocation,
        "results": results,
        "resultsStatus": resultsStatus,
        "sendResults": sendResults,
        "officer2": officer2,
        // "เสนอพิจารณา": consider,
        // "เจ้าหน้าที่เสนอพิจารณา": officer3,
        // "อนุมัติ": approvalDate,
        "recived": recived,
        "recivedResultDate": recivedResultDate,
        "recivedName": recivedName,
        "recivedSign": recivedSign,
        "license": license,
        "licenseDate": licenseDate,
        "licenseFee": licenseFee,
        "licenseFeeSlip": licenseFeeSlip,
        "placeNumber": placeNumber,
        "licenseNumber": licenseNumber,
        "businessLicenseNumber": businessLicenseNumber,
        "operationLicenseNumber": operationLicenseNumber,
        "advertisingLicenseNumber": advertisingLicenseNumber,
        "spaOperatorLicenseNumber": spaOperatorLicenseNumber,
        "sign": sign,
        "receiveDate": receiveDate,
        "parcelNumber": parcelNumber,
        "signature": signature,
        "status": status,
      };
}
