
class HotWord {
  List<HotWordData> data;
  int errorCode;
  String errorMsg;

  HotWord({this.data, this.errorCode, this.errorMsg});

  HotWord.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<HotWordData>();
      json['data'].forEach((v) {
        data.add(new HotWordData.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }

  static HotWord fromMap(Map<String, dynamic> json) {
    HotWord word = new HotWord();
    if (json['data'] != null) {
      word.data = new List<HotWordData>();
      json['data'].forEach((v) {
        word.data.add(new HotWordData.fromJson(v));
      });
    }
    word.errorCode = json['errorCode'];
    word.errorMsg = json['errorMsg'];
    return word;
  }

}

class HotWordData {
  int id;
  String link;
  String name;
  int order;
  int visible;

  HotWordData({this.id, this.link, this.name, this.order, this.visible});

  HotWordData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    link = json['link'];
    name = json['name'];
    order = json['order'];
    visible = json['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['name'] = this.name;
    data['order'] = this.order;
    data['visible'] = this.visible;
    return data;
  }


}
