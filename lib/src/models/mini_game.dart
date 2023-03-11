class MiniGameModel {
  String? name;
  late String id;
  late int nextText;
  late List<Clues> clues;
  late List<Collectible> collectibles;

  MiniGameModel({
    this.name,
    required this.id,
    required this.nextText,
    required this.clues,
    required this.collectibles,
  });

  MiniGameModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nextText = json['nextText'];
    if (json['clues'] != null) {
      clues = <Clues>[];
      json['clues'].forEach((v) {
        clues.add(Clues.fromJson(v));
      });
    }
    if (json['collectibles'] != null) {
      collectibles = <Collectible>[];
      json['collectibles'].forEach((v) {
        collectibles.add(Collectible.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['nextText'] = nextText;
    data['clues'] = clues.map((v) => v.toJson()).toList();
    data['collectibles'] = collectibles.map((v) => v.toJson()).toList();
    return data;
  }
}

class Clues {
  late String id;
  late bool active;
  late String description;
  int? time;
  String? narradorLine;

  Clues({
    this.time,
    this.narradorLine,
    required this.id,
    required this.active,
    required this.description,
  });

  Clues.fromJson(Map<String, dynamic> json) {
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
    if (time != null) data['time'] = time;
    if (narradorLine != null) data['narradorLine'] = narradorLine;
    return data;
  }
}

class Collectible {
  late String id;
  Content? content;
  late double x;
  late double y;
  late String image;
  late bool show;
  Map<String, bool>? setState;
  Map<String, bool>? requiredState;

  Collectible({
    required this.id,
    required this.content,
    required this.x,
    required this.y,
    required this.image,
    required this.show,
    this.setState,
    this.requiredState,
  });

  Collectible.fromJson(Map<String, dynamic> json) {
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
