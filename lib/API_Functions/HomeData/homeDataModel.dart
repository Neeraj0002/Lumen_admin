// To parse this JSON data, do
//
//     final homeData = homeDataFromJson(jsonString);

import 'dart:convert';

HomeData homeDataFromJson(String str) => HomeData.fromJson(json.decode(str));

String homeDataToJson(HomeData data) => json.encode(data.toJson());

class HomeData {
  HomeData({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.gateway,
    this.content,
    this.requests,
    this.records,
  });

  List<String> gateway;
  Content content;
  List<Record> requests;
  List<Record> records;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        gateway: json["gateway"] == null
            ? null
            : List<String>.from(json["gateway"].map((x) => x)),
        content:
            json["content"] == null ? null : Content.fromJson(json["content"]),
        requests: json["requests"] == null
            ? null
            : List<Record>.from(
                json["requests"].map((x) => Record.fromJson(x))),
        records: json["records"] == null
            ? null
            : List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "gateway":
            gateway == null ? null : List<dynamic>.from(gateway.map((x) => x)),
        "content": content == null ? null : content.toJson(),
        "requests": requests == null
            ? null
            : List<dynamic>.from(requests.map((x) => x.toJson())),
        "records": records == null
            ? null
            : List<dynamic>.from(records.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    this.contentNew,
    this.popular,
    this.vip,
    this.sell,
    this.slider,
    this.sliderId,
    this.news,
    this.article,
    this.category,
  });

  List<New> contentNew;
  List<New> popular;
  List<New> vip;
  List<New> sell;
  List<String> slider;
  List<int> sliderId;
  List<Article> news;
  List<Article> article;
  List<Category> category;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        contentNew: json["new"] == null
            ? null
            : List<New>.from(json["new"].map((x) => New.fromJson(x))),
        popular: json["popular"] == null
            ? null
            : List<New>.from(json["popular"].map((x) => New.fromJson(x))),
        vip: json["vip"] == null
            ? null
            : List<New>.from(json["vip"].map((x) => New.fromJson(x))),
        sell: json["sell"] == null
            ? null
            : List<New>.from(json["sell"].map((x) => New.fromJson(x))),
        slider: json["slider"] == null
            ? null
            : List<String>.from(json["slider"].map((x) => x)),
        sliderId: json["slider_id"] == null
            ? null
            : List<int>.from(json["slider_id"].map((x) => x)),
        news: json["news"] == null
            ? null
            : List<Article>.from(json["news"].map((x) => Article.fromJson(x))),
        article: json["article"] == null
            ? null
            : List<Article>.from(
                json["article"].map((x) => Article.fromJson(x))),
        category: json["category"] == null
            ? null
            : List<Category>.from(
                json["category"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "new": contentNew == null
            ? null
            : List<dynamic>.from(contentNew.map((x) => x.toJson())),
        "popular": popular == null
            ? null
            : List<dynamic>.from(popular.map((x) => x.toJson())),
        "vip":
            vip == null ? null : List<dynamic>.from(vip.map((x) => x.toJson())),
        "sell": sell == null
            ? null
            : List<dynamic>.from(sell.map((x) => x.toJson())),
        "slider":
            slider == null ? null : List<dynamic>.from(slider.map((x) => x)),
        "slider_id": sliderId == null
            ? null
            : List<dynamic>.from(sliderId.map((x) => x)),
        "news": news == null
            ? null
            : List<dynamic>.from(news.map((x) => x.toJson())),
        "article": article == null
            ? null
            : List<dynamic>.from(article.map((x) => x.toJson())),
        "category": category == null
            ? null
            : List<dynamic>.from(category.map((x) => x.toJson())),
      };
}

class Article {
  Article({
    this.title,
    this.date,
    this.url,
    this.image,
  });

  String title;
  String date;
  String url;
  String image;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        title: json["title"] == null ? null : json["title"],
        date: json["date"] == null ? null : json["date"],
        url: json["url"] == null ? null : json["url"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "date": date == null ? null : date,
        "url": url == null ? null : url,
        "image": image == null ? null : image,
      };
}

class Category {
  Category({
    this.id,
    this.icon,
    this.count,
    this.title,
    this.childs,
    this.childsCount,
  });

  int id;
  String icon;
  int count;
  String title;
  List<Child> childs;
  int childsCount;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        icon: json["icon"] == null ? null : json["icon"],
        count: json["count"] == null ? null : json["count"],
        title: json["title"] == null ? null : json["title"],
        childs: json["childs"] == null
            ? null
            : List<Child>.from(json["childs"].map((x) => Child.fromJson(x))),
        childsCount: json["childsCount"] == null ? null : json["childsCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "icon": icon == null ? null : icon,
        "count": count == null ? null : count,
        "title": title == null ? null : title,
        "childs": childs == null
            ? null
            : List<dynamic>.from(childs.map((x) => x.toJson())),
        "childsCount": childsCount == null ? null : childsCount,
      };
}

class Child {
  Child({
    this.id,
    this.title,
    this.image,
    this.parentId,
    this.childClass,
    this.mode,
    this.commision,
    this.color,
    this.background,
    this.icon,
    this.reqIcon,
    this.appIcon,
    this.contentsCount,
  });

  int id;
  String title;
  String image;
  int parentId;
  String childClass;
  dynamic mode;
  int commision;
  String color;
  String background;
  String icon;
  String reqIcon;
  String appIcon;
  int contentsCount;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        image: json["image"] == null ? null : json["image"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        childClass: json["class"] == null ? null : json["class"],
        mode: json["mode"],
        commision: json["commision"] == null ? null : json["commision"],
        color: json["color"] == null ? null : json["color"],
        background: json["background"] == null ? null : json["background"],
        icon: json["icon"] == null ? null : json["icon"],
        reqIcon: json["req_icon"] == null ? null : json["req_icon"],
        appIcon: json["app_icon"] == null ? null : json["app_icon"],
        contentsCount:
            json["contents_count"] == null ? null : json["contents_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "image": image == null ? null : image,
        "parent_id": parentId == null ? null : parentId,
        "class": childClass == null ? null : childClass,
        "mode": mode,
        "commision": commision == null ? null : commision,
        "color": color == null ? null : color,
        "background": background == null ? null : background,
        "icon": icon == null ? null : icon,
        "req_icon": reqIcon == null ? null : reqIcon,
        "app_icon": appIcon == null ? null : appIcon,
        "contents_count": contentsCount == null ? null : contentsCount,
      };
}

class New {
  New({
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
  Currency currency;
  int duration;

  factory New.fromJson(Map<String, dynamic> json) => New(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        thumbnail: json["thumbnail"] == null ? null : json["thumbnail"],
        price: json["price"] == null ? null : json["price"],
        currency: json["currency"] == null
            ? null
            : currencyValues.map[json["currency"]],
        duration: json["duration"] == null ? null : json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "thumbnail": thumbnail == null ? null : thumbnail,
        "price": price == null ? null : price,
        "currency": currency == null ? null : currencyValues.reverse[currency],
        "duration": duration == null ? null : duration,
      };
}

enum Currency { EMPTY }

final currencyValues = EnumValues({"\u0024": Currency.EMPTY});

class Record {
  Record({
    this.id,
    this.title,
    this.description,
    this.image,
    this.fans,
  });

  int id;
  String title;
  String description;
  String image;
  int fans;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        image: json["image"] == null ? null : json["image"],
        fans: json["fans"] == null ? null : json["fans"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "image": image == null ? null : image,
        "fans": fans == null ? null : fans,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
