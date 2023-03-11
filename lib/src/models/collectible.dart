class Collectible {
  late String id;
  CollectibleContent? content;
  late String image;
  Map<String, bool>? requiredState;

  Collectible({
    required this.id,
    required this.content,
    required this.image,
    this.requiredState,
  });
}

class CollectibleContent {
  late String id;
  late String type;
  late String text;
  late String name;
  late String image;
  String? description;
  String? audio;

  CollectibleContent({
    required this.id,
    required this.type,
    required this.text,
    required this.name,
    required this.image,
    this.description,
    this.audio,
  });
}
