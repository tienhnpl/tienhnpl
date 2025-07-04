// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:orm/orm.dart' as _i1;

import 'model.dart' as _i2;

enum Priority implements _i1.PrismaEnum {
  high._('High'),
  medium._('Medium'),
  low._('Low');

  const Priority._(this.name);

  @override
  final String name;
}

class Task {
  const Task({
    this.id,
    this.title,
    this.description,
    this.priority,
    this.dueDate,
    this.externalLink,
    this.isCompleted,
    this.createdAt,
  });

  factory Task.fromJson(Map json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    priority: json['priority'] != null
        ? _i2.Priority.values.firstWhere((e) => e.name == json['priority'])
        : null,
    dueDate: switch (json['dueDate']) {
      DateTime value => value,
      String value => DateTime.parse(value),
      _ => json['dueDate'],
    },
    externalLink: json['externalLink'],
    isCompleted: json['isCompleted'],
    createdAt: switch (json['createdAt']) {
      DateTime value => value,
      String value => DateTime.parse(value),
      _ => json['createdAt'],
    },
  );

  final int? id;

  final String? title;

  final String? description;

  final _i2.Priority? priority;

  final DateTime? dueDate;

  final String? externalLink;

  final bool? isCompleted;

  final DateTime? createdAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'priority': priority?.name,
    'dueDate': dueDate?.toIso8601String(),
    'externalLink': externalLink,
    'isCompleted': isCompleted,
    'createdAt': createdAt?.toIso8601String(),
  };
}

class CreateManyTaskAndReturnOutputType {
  const CreateManyTaskAndReturnOutputType({
    this.id,
    this.title,
    this.description,
    this.priority,
    this.dueDate,
    this.externalLink,
    this.isCompleted,
    this.createdAt,
  });

  factory CreateManyTaskAndReturnOutputType.fromJson(Map json) =>
      CreateManyTaskAndReturnOutputType(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        priority: json['priority'] != null
            ? _i2.Priority.values.firstWhere((e) => e.name == json['priority'])
            : null,
        dueDate: switch (json['dueDate']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['dueDate'],
        },
        externalLink: json['externalLink'],
        isCompleted: json['isCompleted'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt'],
        },
      );

  final int? id;

  final String? title;

  final String? description;

  final _i2.Priority? priority;

  final DateTime? dueDate;

  final String? externalLink;

  final bool? isCompleted;

  final DateTime? createdAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'priority': priority?.name,
    'dueDate': dueDate?.toIso8601String(),
    'externalLink': externalLink,
    'isCompleted': isCompleted,
    'createdAt': createdAt?.toIso8601String(),
  };
}

class UpdateManyTaskAndReturnOutputType {
  const UpdateManyTaskAndReturnOutputType({
    this.id,
    this.title,
    this.description,
    this.priority,
    this.dueDate,
    this.externalLink,
    this.isCompleted,
    this.createdAt,
  });

  factory UpdateManyTaskAndReturnOutputType.fromJson(Map json) =>
      UpdateManyTaskAndReturnOutputType(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        priority: json['priority'] != null
            ? _i2.Priority.values.firstWhere((e) => e.name == json['priority'])
            : null,
        dueDate: switch (json['dueDate']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['dueDate'],
        },
        externalLink: json['externalLink'],
        isCompleted: json['isCompleted'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt'],
        },
      );

  final int? id;

  final String? title;

  final String? description;

  final _i2.Priority? priority;

  final DateTime? dueDate;

  final String? externalLink;

  final bool? isCompleted;

  final DateTime? createdAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'priority': priority?.name,
    'dueDate': dueDate?.toIso8601String(),
    'externalLink': externalLink,
    'isCompleted': isCompleted,
    'createdAt': createdAt?.toIso8601String(),
  };
}
