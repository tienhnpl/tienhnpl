import 'package:orm/orm.dart';

/// Enum thể hiện mức độ ưu tiên của Task
enum Priority implements PrismaEnum {
  high._('High'),
  medium._('Medium'),
  low._('Low');

  const Priority._(this.name);
  final String name;
}

/// Model Task theo đúng yêu cầu đề bài
class Task {
  final int? id;
  final String title;
  final String description;
  final Priority priority;
  final DateTime? dueDate;
  final String? externalLink;
  final bool isCompleted;
  final DateTime? createdAt;

  const Task({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    this.dueDate,
    this.externalLink,
    this.isCompleted = false,
    this.createdAt,
  });

  /// Hàm factory chuyển từ JSON sang đối tượng Task
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priority: Priority.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['priority'] ?? '').toLowerCase(),
      ),
      dueDate: json['dueDate'] != null
          ? DateTime.tryParse(json['dueDate'])
          : null,
      externalLink: json['externalLink'],
      isCompleted: json['isCompleted'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  /// Chuyển đối tượng Task sang Map để lưu hoặc gửi đi
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.name,
      'dueDate': dueDate?.toIso8601String(),
      'externalLink': externalLink,
      'isCompleted': isCompleted,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
