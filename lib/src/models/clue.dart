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

  @override
  List<Object?> get props => [time, id, active, description];
}
