import 'package:flutter/material.dart';
import 'chatmessage.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    List<ChatMessage> messages = [
      // Percakapan pertama antara Will dan Kriss
      ChatMessage(messageContent: "Permisi kak", messageType: "receiver"),
      ChatMessage(
          messageContent: "ya kak , ada yang bisa dibantu?",
          messageType: "sender"),
      ChatMessage(
          messageContent:
              "Ini kak saya mau membeli buku bekas dengan judul 'Buku Pintar Drafter'",
          messageType: "receiver"),
      ChatMessage(messageContent: "Baik Kak.", messageType: "sender"),
      ChatMessage(
          messageContent: "Apakah ingin membeli ", messageType: "sender"),
      ChatMessage(messageContent: "dsdsd", messageType: "sender"),
      ChatMessage(
          messageContent: "Is there any thing wrong?", messageType: "sender")
    ];
    List<ChatMessage> senderMessages =
        messages.where((msg) => msg.messageType == "sender").toList();
    List<ChatMessage> receiverMessages =
        messages.where((msg) => msg.messageType == "receiver").toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme:
            IconThemeData(color: Colors.black), // Mengatur warna ikon AppBar
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "<https://randomuser.me/api/portraits/men/5.jpg>"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Penjual Buku",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        // Mengatur warna teks
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Color(0xFF755DC1), // Background color
          ),
          ListView.builder(
            itemCount: (senderMessages.length + receiverMessages.length),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 60),
            itemBuilder: (context, index) {
              if (index < 2) {
                return SizedBox
                    .shrink(); // Mengembalikan widget kosong untuk indeks kurang dari 2
              } else if ((index - 2) % 2 == 0) {
                // Menggunakan (index - 2) karena kita tidak memerlukan dua pertama item (index 0 dan 1)
                return Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    senderMessages[(index - 2) ~/ 2].messageContent,
                    style:
                        TextStyle(color: Colors.white), // Mengatur warna teks
                  ),
                );
              } else {
                return Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    receiverMessages[((index - 2) ~/ 2)].messageContent,
                    style:
                        TextStyle(color: Colors.white), // Mengatur warna teks
                  ),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChatDetailPage();
                      }));
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Color(0xFF755DC1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white), // Mengatur warna teks input
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Color(0xFF755DC1),
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
