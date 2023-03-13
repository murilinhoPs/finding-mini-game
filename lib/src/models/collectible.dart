import 'package:equatable/equatable.dart';

class Collectible extends Equatable {
  final String id;
  final CollectibleContent content;
  final String image;
  final Map<String, bool>? requiredState;

  const Collectible({
    required this.id,
    required this.content,
    required this.image,
    this.requiredState,
  });

  @override
  List<Object?> get props => [id, content, image, requiredState];
}

class CollectibleContent extends Equatable {
  final String id;
  final String type;
  final String text;
  final String name;
  final String image;
  final String? audio;
  final String? description;

  const CollectibleContent({
    required this.id,
    required this.type,
    required this.text,
    required this.name,
    required this.image,
    this.description,
    this.audio,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        text,
        name,
        image,
        audio,
        description,
      ];
}
