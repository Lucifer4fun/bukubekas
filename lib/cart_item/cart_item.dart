import 'package:uts/book_model.dart';
import 'package:uts/data.dart';

class CartItem {
  final BookModel book;
  int quantity;

  CartItem(this.book, this.quantity);
}
