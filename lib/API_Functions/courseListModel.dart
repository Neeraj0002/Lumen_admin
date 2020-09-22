// To parse this JSON data, do
//
//     final courseListData = courseListDataFromJson(jsonString);

import 'dart:convert';

CourseListModel courseListDataFromJson(String str) =>
    CourseListModel.fromJson(json.decode(str));

String courseListDataToJson(CourseListModel data) => json.encode(data.toJson());

class CourseListModel {
  CourseListModel({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory CourseListModel.fromJson(Map<String, dynamic> json) =>
      CourseListModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.thumbnail,
    this.price,
    this.currency,
    this.duration,
  });

  int id;
  String title;
  String thumbnail;
  String price;
  String currency;
  int duration;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        price: json["price"] == null ? null : json["price"],
        currency: json["currency"] == null ? null : json["currency"],
        duration: json["duration"] == null ? null : json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "price": price == null ? null : price,
        "currency": currency == null ? null : currency,
        "duration": duration == null ? null : duration,
      };
}
