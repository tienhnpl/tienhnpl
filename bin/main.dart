import 'dart:convert';
import 'dart:io';

class Order {
  String item;
  String itemName;
  int price;
  String currency;
  int quantity;

  Order({
    required this.item,
    required this.itemName,
    required this.price,
    required this.currency,
    required this.quantity,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      item: json['Item'],
      itemName: json['ItemName'],
      price: json['Price'],
      currency: json['Currency'],
      quantity: json['Quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Item': item,
      'ItemName': itemName,
      'Price': price,
      'Currency': currency,
      'Quantity': quantity,
    };
  }

  @override
  String toString() {
    return 'Item: $item, Name: $itemName, Price: $price $currency, Quantity: $quantity';
  }
}

void main() async {
  List<Order> orders = [];

  final file = File('order.json');

  // Nếu file tồn tại, đọc dữ liệu từ file
  if (await file.exists()) {
    String content = await file.readAsString();
    List<dynamic> jsonData = jsonDecode(content);
    orders = jsonData.map((e) => Order.fromJson(e)).toList();
  } else {
    // Nếu chưa có file, tạo dữ liệu mặc định
    String jsonString = '''
    [
      {"Item": "A1000","ItemName": "Iphone 15","Price": 1200,"Currency": "USD","Quantity":1},
      {"Item": "A1001","ItemName": "Iphone 16","Price": 1500,"Currency": "USD","Quantity":1}
    ]
    ''';

    orders = (jsonDecode(jsonString) as List)
        .map((e) => Order.fromJson(e))
        .toList();

    await file.writeAsString(
      jsonEncode(orders.map((e) => e.toJson()).toList()),
    );
  }

  while (true) {
    print('\n===== MENU =====');
    print('1. Show all orders');
    print('2. Add new order');
    print('3. Search by Item Name');
    print('4. Exit');
    stdout.write('Choose option: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        print('\n--- All Orders ---');
        for (var order in orders) {
          print(order);
        }
        break;
      case '2':
        stdout.write('Item: ');
        String item = stdin.readLineSync() ?? '';
        stdout.write('Item Name: ');
        String itemName = stdin.readLineSync() ?? '';
        stdout.write('Price: ');
        int price = int.parse(stdin.readLineSync() ?? '0');
        stdout.write('Currency: ');
        String currency = stdin.readLineSync() ?? '';
        stdout.write('Quantity: ');
        int quantity = int.parse(stdin.readLineSync() ?? '1');

        orders.add(
          Order(
            item: item,
            itemName: itemName,
            price: price,
            currency: currency,
            quantity: quantity,
          ),
        );

        await file.writeAsString(
          jsonEncode(orders.map((e) => e.toJson()).toList()),
        );
        print('Order added successfully!');
        break;
      case '3':
        stdout.write('Enter Item Name to search: ');
        String searchName = stdin.readLineSync() ?? '';
        var results = orders
            .where(
              (o) =>
                  o.itemName.toLowerCase().contains(searchName.toLowerCase()),
            )
            .toList();

        if (results.isEmpty) {
          print('No orders found with Item Name: $searchName');
        } else {
          print('\n--- Search Results ---');
          for (var order in results) {
            print(order);
          }
        }
        break;
      case '4':
        print('Exiting...');
        return;
      default:
        print('Invalid option. Please try again.');
    }
  }
}
