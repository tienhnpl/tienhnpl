import 'dart:io';
import 'package:orm/orm.dart';
import 'package:assignment_orm/services/task_service.dart';

void main() async {
  print('\n===== ỨNG DỤNG QUẢN LÝ TASK =====');

  while (true) {
    print('\n==============================');
    print('1. Thêm Task');
    print('2. Hiển thị danh sách Task');
    print('3. Đánh dấu Task là hoàn thành');
    print('4. Xóa Task');
    print('5. Xem chi tiết Task');
    print('6. Tìm kiếm Task');
    print('7. Thoát');
    print('==============================');
    stdout.write('Vui lòng chọn chức năng (1-7): ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        await addTask();
        break;
      case '2':
        await displayTasks();
        break;
      case '3':
        await completeTask();
        break;
      case '4':
        await deleteTask();
        break;
      case '5':
        await viewTaskDetail();
        break;
      case '6':
        await searchTask();
        break;
      case '7':
        print('🔒 Đã thoát chương trình. Hẹn gặp lại!');
        exit(0);
      default:
        print('⚠️  Lựa chọn không hợp lệ. Vui lòng chọn từ 1-7.');
    }
  }
}
