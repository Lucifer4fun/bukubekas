import 'package:flutter/material.dart';
import 'book_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
// i'm now going to create a dummy list of movies
// you can build your own list, I used the IMDB data so u can use the same source
  static List<BookModel> main_book_list = [
    BookModel(
        "CorelDraw untuk Tingkat Pemula Sampai Mahir",
        "Desain",
        "Jubilee Enterprise",
        "https://ebooks.gramedia.com/ebook-covers/42748/image_highres/ID_CDTP2018MTH05CDTP.jpg"),
    BookModel("Buku Pintar Drafter Untuk Pemula Hingga Mahir", "Desain",
        "Widada", "https://cdn.gramedia.com/uploads/items/9789798774379.jpg"),
    BookModel(
        "Adobe InDesign: Seri Panduan Terlengkap",
        "Desain",
        "Jubilee Enterprise",
        "https://cdn.gramedia.com/uploads/images/1/42737/image_highres/ID_AIK2018MTH05AIK.jpg"),
    BookModel(
        "Pemodelan Objek Dengan 3Ds Max 2014",
        "Desain",
        "Wahana Komputer",
        "https://cdn.gramedia.com/uploads/items/66427/thumb_image_normal/BLK_PADSPOD3M22021539840.jpg"),
    BookModel(
        "Penerapan Visualisasi 3D Dengan Autodesk Maya",
        "Desain",
        "Dhani Ariatmanto",
        "https://cdn.gramedia.com/uploads/items/9789792951660.jpeg"),
    BookModel(
        "Teknik Lancar Menggunakan Adobe Photoshop",
        "Desain",
        "Jubilee Enterprise",
        "https://cdn.gramedia.com/uploads/images/1/42660/image_highres/ID_LMAP2018MTH05LMAP.jpg"),
    BookModel(
        "Adobe Premiere Terlengkap dan Termudah",
        "Desain",
        "Jubilee Enterprise",
        "https://cdn.gramedia.com/uploads/items/9786020445694_adobe-premiere-komplet.jpg"),
    BookModel(
        "Cad Series : Google Sketchup Untuk Desain 3D",
        "Desain",
        "Wahana Komputer",
        "https://cdn.gramedia.com/uploads/items/CAD_Series__Google_Sketchup_1.jpg"),
    BookModel(
        "Webmaster Series : Trik Cepat Menguasai CSS",
        "Web",
        "Wahana Komputer",
        "https://cdn.gramedia.com/uploads/items/67611/thumb_image_normal/BLK_WSMC2021515039.jpg"),
  ];

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
              element.penulis!.toLowerCase().contains(value.toLowerCase()))
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
                          "${display_list[index].penulis!}",
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
