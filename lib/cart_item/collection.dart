import 'package:collection/collection.dart';

void main() {
  List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  // Menggunakan ekstensi untuk menemukan jumlah total
  int total = numbers.sum;
  print('Total: $total'); // Output: Total: 55

  // Menggunakan ekstensi untuk menyaring data
  var evenNumbers = numbers.where((num) => num.isEven).toList();
  print(
      'Bilangan Genap: $evenNumbers'); // Output: Bilangan Genap: [2, 4, 6, 8, 10]
}
