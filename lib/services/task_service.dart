import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import '../models/task.dart';
import '../prisma_client.dart/client.dart';
import '../prisma_client.dart/prisma.dart';
import '../utils/validator.dart';

/// Khởi tạo Prisma Client
final PrismaClient _client = PrismaClient();

/// Thêm mới một Task
Future<void> addTask() async {
  stdout.write('Nhập tiêu đề: ');
  String? title = stdin.readLineSync();
  if (title == null || title.trim().isEmpty) {
    print('⚠️  Tiêu đề không được để trống.');
    return;
  }

  stdout.write('Nhập mô tả: ');
  String? description = stdin.readLineSync();
  if (description == null || description.trim().isEmpty) {
    print('⚠️  Mô tả không được để trống.');
    return;
  }

  print('Chọn mức độ ưu tiên (high / medium / low): ');
  String? priorityInput = stdin.readLineSync();
  Priority? priority;
  switch (priorityInput?.toLowerCase()) {
    case 'high':
      priority = Priority.high;
      break;
    case 'medium':
      priority = Priority.medium;
      break;
    case 'low':
      priority = Priority.low;
      break;
    default:
      print('⚠️  Ưu tiên không hợp lệ.');
      return;
  }

  stdout.write('Nhập deadline (yyyy-MM-dd) hoặc để trống: ');
  String? dueDateInput = stdin.readLineSync();
  DateTime? dueDate;
  if (dueDateInput != null && dueDateInput.trim().isNotEmpty) {
    dueDate = DateTime.tryParse(dueDateInput);
    if (dueDate == null) {
      print('⚠️  Ngày không hợp lệ.');
      return;
    }
  }

  stdout.write('Nhập liên kết ngoài (hoặc để trống): ');
  String? link = stdin.readLineSync();
  if (link != null && link.trim().isNotEmpty && !isValidUrl(link)) {
    print('⚠️  Liên kết không hợp lệ.');
    return;
  }

  await _client.task.create(
    data: TaskCreateInput(
      title: title.trim(),
      description: description.trim(),
      priority: priority,
      dueDate: dueDate,
      externalLink: link?.trim(),
    ),
  );

  print('✅ Task đã được thêm thành công.');
}

/// Hiển thị danh sách tất cả các Task, sắp xếp theo mức độ ưu tiên
Future<void> displayTasks() async {
  final tasks = await _client.task.findMany(
    orderBy: [TaskOrderByInput(priority: SortOrder.desc)],
  );

  print('\n===== DANH SÁCH TASK =====');
  for (var task in tasks) {
    print(
      'ID: ${task.id} | Tiêu đề: ${task.title} | Ưu tiên: ${task.priority?.name} | Hạn: ${task.dueDate ?? '---'} | Trạng thái: ${task.isCompleted ? 'Hoàn thành' : 'Chưa hoàn thành'}',
    );
  }
}

/// Đánh dấu Task là hoàn thành
Future<void> completeTask() async {
  stdout.write('Nhập ID task cần hoàn thành: ');
  int? id = int.tryParse(stdin.readLineSync() ?? '');
  if (id == null) {
    print('⚠️  ID không hợp lệ.');
    return;
  }

  await _client.task.update(
    where: TaskWhereUniqueInput(id: id),
    data: TaskUpdateInput(isCompleted: true),
  );

  print('✅ Task đã được đánh dấu hoàn thành.');
}

/// Xóa Task
Future<void> deleteTask() async {
  stdout.write('Nhập ID task cần xóa: ');
  int? id = int.tryParse(stdin.readLineSync() ?? '');
  if (id == null) {
    print('⚠️  ID không hợp lệ.');
    return;
  }

  await _client.task.delete(where: TaskWhereUniqueInput(id: id));

  print('✅ Task đã được xóa.');
}

/// Xem chi tiết một Task
Future<void> viewTaskDetail() async {
  stdout.write('Nhập ID task cần xem: ');
  int? id = int.tryParse(stdin.readLineSync() ?? '');
  if (id == null) {
    print('⚠️  ID không hợp lệ.');
    return;
  }

  final task = await _client.task.findUnique(
    where: TaskWhereUniqueInput(id: id),
  );

  if (task == null) {
    print('⚠️  Không tìm thấy task.');
    return;
  }

  print('\n===== CHI TIẾT TASK =====');
  print('Tiêu đề: ${task.title}');
  print('Mô tả: ${task.description}');
  print('Ưu tiên: ${task.priority?.name}');
  print('Deadline: ${task.dueDate ?? '---'}');
  print('Liên kết ngoài: ${task.externalLink ?? '---'}');
  print('Trạng thái: ${task.isCompleted ? 'Hoàn thành' : 'Chưa hoàn thành'}');

  if (task.externalLink != null) {
    stdout.write('Bạn có muốn mở liên kết ngoài? (y/n): ');
    String? choice = stdin.readLineSync();
    if (choice?.toLowerCase() == 'y') {
      if (await canLaunch(task.externalLink!)) {
        await launch(task.externalLink!);
      } else {
        print('⚠️  Không thể mở liên kết.');
      }
    }
  }
}

/// Tìm kiếm Task theo từ khóa trong tiêu đề hoặc mô tả
Future<void> searchTask() async {
  stdout.write('Nhập từ khóa tìm kiếm: ');
  String? keyword = stdin.readLineSync();
  if (keyword == null || keyword.trim().isEmpty) {
    print('⚠️  Từ khóa không được để trống.');
    return;
  }

  final tasks = await _client.task.findMany(
    where: TaskWhereInput(
      OR: [
        TaskWhereInput(title: StringFilter(contains: keyword)),
        TaskWhereInput(description: StringFilter(contains: keyword)),
      ],
    ),
  );

  print('\n===== KẾT QUẢ TÌM KIẾM =====');
  for (var task in tasks) {
    print(
      'ID: ${task.id} | Tiêu đề: ${task.title} | Ưu tiên: ${task.priority?.name} | Trạng thái: ${task.isCompleted ? 'Hoàn thành' : 'Chưa hoàn thành'}',
    );
  }
}
