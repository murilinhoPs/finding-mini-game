import 'package:equatable/equatable.dart';

class Clues extends Equatable {
  final String id;
  final int time;
  final bool active;
  final String description;
  final String? narradorLine;

  const Clues({
    this.narradorLine,
    required this.id,
    required this.time,
    required this.active,
    required this.description,
  });

  Clues copyWith({
    String? id,
    int? time,
    bool? active,
    String? description,
    String? narradorLine,
  }) {
    return Clues(
      id: id ?? this.id,
      time: time ?? this.time,
      active: active ?? this.active,
      description: description ?? this.description,
      narradorLine: narradorLine ?? this.narradorLine,
    );
  }

  @override
  List<Object?> get props => [time, id, active, description, narradorLine];
}
