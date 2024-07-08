import 'package:flutter/material.dart';
import 'package:uts/data.dart';
import 'book_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
// i'm now going to create a dummy list of movies
// you can build your own list, I used the IMDB data so u can use the same source

  // creating the list that we're going to display and filter
  List<BookModel> display_list = List.from(main_book_list);
  void updateList(String value) {
    setState(() {
      display_list = main_book_list
          .where((element) =>
              element.book_tittle!
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.category!.toLowerCase().contains(value.toLowerCase()) ||
              element.writer!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1f1545),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pencarian Buku",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              onChanged: (value) => updateList(value),
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 42, 28, 98),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "contoh : CorelDraw",
                hintStyle:
                    TextStyle(color: Colors.grey), // Menetapkan warna teks hint
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Color.fromARGB(255, 0, 221, 255),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: display_list.length == 0
                  ? Center(
                      child: Text(
                      "Now Result Found",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ))
                  : ListView.builder(
                      itemCount: display_list.length,
                      itemBuilder: (context, index) => ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(
                          display_list[index].book_tittle!,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${display_list[index].category!}',
                          style: TextStyle(color: Colors.white60),
                        ),
                        trailing: Text(
                          "${display_list[index].writer!}",
                          style: TextStyle(color: Colors.amber),
                        ),
                        leading:
                            Image.network(display_list[index].book_poster_url!),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
