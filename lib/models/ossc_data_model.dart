// To parse this JSON data, do
//
//     final booked = bookedFromJson(jsonString);

import 'dart:convert';

Ossc osscFromJson(String str) => Ossc.fromJson(json.decode(str));

String osscToJson(Ossc data) => json.encode(data.toJson());

class Ossc {
  bool? success;
  List<Data>? data;

  Ossc({
    this.success,
    this.data,
  });

  factory Ossc.fromJson(Map<String, dynamic> json) => Ossc(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Data {
  int? no;
  DateTime? date;
  dynamic receiveNumber;
  dynamic customer;
  dynamic company;
  dynamic district;
  dynamic tel;
  dynamic act;
  dynamic type;
  dynamic desc;
  dynamic cost;
  dynamic slipUrl;
  dynamic doc;
  dynamic requestStaff;
  dynamic waitingToCheck;
  dynamic officer1;
  dynamic checkLocation;
  dynamic results;
  dynamic sendResults;
  dynamic resultsStatus;
  dynamic officer2;
  dynamic consider;
  dynamic officer3;
  dynamic approvalDate;
  dynamic license;
  dynamic placeNumber;
  dynamic licenseNumber;
  dynamic businessLicenseNumber;
  dynamic operationLicenseNumber;
  dynamic advertisingLicenseNumber;
  dynamic spaOperatorLicenseNumber;
  dynamic sign;
  dynamic receiveDate;
  dynamic parcelNumber;
  dynamic status;

  Data({
    this.no,
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
    this.waitingToCheck,
    this.officer1,
    this.checkLocation,
    this.results,
    this.sendResults,
    this.resultsStatus,
    this.officer2,
    this.consider,
    this.officer3,
    this.approvalDate,
    this.license,
    this.placeNumber,
    this.licenseNumber,
    this.businessLicenseNumber,
    this.operationLicenseNumber,
    this.advertisingLicenseNumber,
    this.spaOperatorLicenseNumber,
    this.sign,
    this.receiveDate,
    this.parcelNumber,
    this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        no: json["ลำดับ"],
        date: json["วัน/เดือน/ปี"] == null
            ? null
            : DateTime.parse(json["วัน/เดือน/ปี"]),
        receiveNumber: json["เลขรับ"],
        customer: json["ชื่อผู้รับอนุญาต/ชื่อผู้ติดต่อ"],
        company: json["ชื่อสถานประกอบการ"],
        district: json["อำเภอ"],
        tel: json["เบอร์โทร"],
        act: json["พรบ."],
        type: json["ประเภทสถานที่"],
        desc: json["ธุรกรรม"],
        cost: json["ค่าธรรมเนียม"],
        slipUrl: json["slipUrl"],
        doc: json["เอกสารคำขอ"],
        requestStaff: json["เจ้าหน้าที่รับคำขอ"],
        waitingToCheck: json["รอตรวจสถานที่/ อยู่ระหว่างดำเนินการ"],
        officer1: json["เจ้าหน้าที่ตรวจสถานที่"],
        checkLocation: json["ตรวจสถานที่"],
        results: json["ผลตรวจ"],
        resultsStatus: json["สถานะการตรวจ"],
        sendResults: json["ส่งผลตรวจ"],
        officer2: json["เจ้าหน้าที่ส่งผลตรวจ"],
        consider: json["เสนอพิจารณา"],
        officer3: json["เจ้าหน้าที่เสนอพิจารณา"],
        approvalDate: json["อนุมัติ"],
        license: json["ใบอนุญาต/เอกสาร"],
        placeNumber: json["เลขสถานที่"],
        licenseNumber: json["เลขใบอนุญาต"],
        businessLicenseNumber: json["เลขใบอนุญาตประกอบกิจ"],
        operationLicenseNumber: json["เลขใบอนุญาตดำเนินการ"],
        advertisingLicenseNumber: json["เลขใบอนุญาตโฆษณา"],
        spaOperatorLicenseNumber: json["เลขใบอนุญาตผู้ดำเนินการสปา"],
        sign: json["รับใบอนุญาต/รับเอกสาร"],
        receiveDate: json["วันที่รับ/วันที่จัดส่ง"],
        parcelNumber: json["เลขพัสดุ"],
        status: json["สถานนะ"],
      );

  Map<String, dynamic> toJson() => {
        "ลำดับ": no,
        "วัน/เดือน/ปี": date?.toIso8601String(),
        "เลขรับ": receiveNumber,
        "ชื่อผู้รับอนุญาต/ชื่อผู้ติดต่อ": customer,
        "ชื่อสถานประกอบการ": company,
        "อำเภอ": district,
        "เบอร์โทร": tel,
        "พรบ.": act,
        "ประเภทสถานที่": type,
        "ธุรกรรม": desc,
        "ค่าธรรมเนียม": cost,
        "slipUrl": slipUrl,
        "เอกสารคำขอ": doc,
        "เจ้าหน้าที่รับคำขอ": requestStaff,
        "รอตรวจสถานที่/ อยู่ระหว่างดำเนินการ": waitingToCheck,
        "เจ้าหน้าที่ตรวจสถานที่": officer1,
        "ตรวจสถานที่": checkLocation,
        "ผลตรวจ": results,
        "สถานะการตรวจ": resultsStatus,
        "ส่งผลตรวจ": sendResults,
        "เจ้าหน้าที่ส่งผลตรวจ": officer2,
        "เสนอพิจารณา": consider,
        "เจ้าหน้าที่เสนอพิจารณา": officer3,
        "อนุมัติ": approvalDate,
        "ใบอนุญาต/เอกสาร": license,
        "เลขสถานที่": placeNumber,
        "เลขใบอนุญาต": licenseNumber,
        "เลขใบอนุญาตประกอบกิจ": businessLicenseNumber,
        "เลขใบอนุญาตดำเนินการ": operationLicenseNumber,
        "เลขใบอนุญาตโฆษณา": advertisingLicenseNumber,
        "เลขใบอนุญาตผู้ดำเนินการสปา": spaOperatorLicenseNumber,
        "รับใบอนุญาต/รับเอกสาร": sign,
        "วันที่รับ/วันที่จัดส่ง": receiveDate,
        "เลขพัสดุ": parcelNumber,
        "สถานนะ": status,
      };
}
