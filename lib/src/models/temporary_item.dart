import 'package:equatable/equatable.dart';

class TemporaryItem extends Equatable {
  final String image;
  final Map<String, bool> setState;

  const TemporaryItem({
    required this.setState,
    required this.image,
  });

  @override
  List<Object?> get props => [image, setState];
}
