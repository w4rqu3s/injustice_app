import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String displayName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int level;
  final double gold;
  final int gems;
  final int energy;

  const Account({
    required this.id,
    required this.userId,
    required this.name,
    required this.displayName,
    required this.createdAt,
    required this.updatedAt,
    required this.level,
    required this.gold,
    required this.gems,
    required this.energy,
  }) ;


  Account copyWith({
    String? id,
    String? userId,
    String? name,
    String? displayName,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? level,
    double? gold,
    int? gems,
    int? energy,
  }) {
    return Account(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      level: level ?? this.level,
      gold: gold ?? this.gold,
      gems: gems ?? this.gems,
      energy: energy ?? this.energy,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        displayName,
        createdAt,
        updatedAt,
        level,
        gold,
        gems,
        energy,
      ];

  @override
  String toString() {
    return 'Account('
        'id: $id, '
        'userId: $userId, '
        'name: $name, '
        'displayName: $displayName, '
        'level: $level, '
        'gold: $gold, '
        'gems: $gems, '
        'energy: $energy'
        ')';
  }
}
