class BookModel {
  String? book_title;
  String? category;
  String? book_poster_url;
  String? writer;

  BookModel(
      [this.book_title, this.category, this.writer, this.book_poster_url]);

  // Convert a BookModel into a Map. The keys must correspond to the names of the columns in Firestore.
  Map<String, dynamic> toMap() {
    return {
      'bookTitle': book_title,
      'category': category,
      'bookPosterUrl': book_poster_url,
      'writer': writer,
    };
  }

  // Create a BookModel from a Map. This is useful for retrieving data from Firestore.
  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      map['bookTitle'],
      map['category'],
      map['writer'],
      map['bookPosterUrl'],
    );
  }
}
