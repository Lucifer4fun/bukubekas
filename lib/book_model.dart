class BookModel {
  String? book_title;
  String? category;
  String? book_poster_url;
  String? writer;
  int price;

  BookModel({
    this.book_title,
    this.category,
    this.writer,
    this.book_poster_url,
    required this.price,
  });

  // Convert a BookModel into a Map. The keys must correspond to the names of the columns in Firestore.
  Map<String, dynamic> toMap() {
    return {
      'book_title': book_title,
      'category': category,
      'book_poster_url': book_poster_url,
      'writer': writer,
      'price': price,
    };
  }

  // Create a BookModel from a Map. This is useful for retrieving data from Firestore.
  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      book_title: map['book_title'],
      category: map['category'],
      writer: map['writer'],
      book_poster_url: map['book_poster_url'],
      price: map['price'],
    );
  }
}
