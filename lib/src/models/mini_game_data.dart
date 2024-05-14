class MiniGameDataModel {
  String? name;
  late String id;
  late int nextText;
  late String background;
  late List<CluesData> clues;
  late List<Item> collectibles;

  MiniGameDataModel({
    this.name,
    required this.id,
    required this.nextText,
    required this.clues,
    required this.background,
    required this.collectibles,
  });

  MiniGameDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nextText = json['nextText'];
    background = json['background'];
    if (json['clues'] != null) {
      clues = <CluesData>[];
      json['clues'].forEach((v) {
        clues.add(CluesData.fromJson(v));
      });
    }
    if (json['items'] != null) {
      collectibles = <Item>[];
      json['items'].forEach((v) {
        collectibles.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['nextText'] = nextText;
    data['background'] = background;
    data['clues'] = clues.map((v) => v.toJson()).toList();
    data['items'] = collectibles.map((v) => v.toJson()).toList();
    return data;
  }
}

class CluesData {
  late String id;
  late bool active;
  late String description;
  late int time;
  String? narradorLine;

  CluesData({
    this.narradorLine,
    required this.time,
    required this.id,
    required this.active,
    required this.description,
  });

  CluesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    active = json['active'];
    description = json['description'];
    time = json['time'];
    narradorLine = json['narradorLine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['active'] = active;
    data['description'] = description;
    data['time'] = time;
    if (narradorLine != null) data['narradorLine'] = narradorLine;
    return data;
  }
}

class Item {
  late String id;
  late double x;
  late double y;
  late String image;
  late bool show;
  Content? content;
  Map<String, bool>? setState;
  Map<String, bool>? requiredState;

  Item({
    required this.id,
    required this.x,
    required this.y,
    required this.image,
    required this.show,
    this.content,
    this.setState,
    this.requiredState,
  });

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    x = json['x'];
    y = json['y'];
    image = json['image'];
    show = json['show'];
    setState = json['setState'] != null
        ? Map<String, bool>.from(json['setState'])
        : null;
    requiredState = json['requiredState'] != null
        ? Map<String, bool>.from(json['requiredState'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    data['x'] = x;
    data['y'] = y;
    data['image'] = image;
    data['show'] = show;
    if (setState != null) {
      data['setState'] = setState;
    }
    if (requiredState != null) {
      data['requiredState'] = requiredState;
    }
    return data;
  }
}

class Content {
  late String id;
  late String type;
  late String text;
  late String name;
  late String image;
  String? description;
  String? audio;

  Content({
    required this.id,
    required this.type,
    required this.text,
    required this.name,
    required this.image,
    this.description,
    this.audio,
  });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    text = json['text'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['text'] = text;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['audio'] = audio;
    return data;
  }
}
