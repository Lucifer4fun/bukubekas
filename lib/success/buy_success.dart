import 'package:flutter/material.dart';
import 'package:uts/home.dart';
import 'package:uts/detail.dart';

class SuccessPage1 extends StatefulWidget {
  const SuccessPage1({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SuccessPage1> createState() => _SuccesPage1State();
}

Color themeColor = const Color(0xFF43D19E);

class _SuccesPage1State extends State<SuccessPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white, // Ganti warna latar belakang sesuai kebutuhan
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 170,
                padding: EdgeInsets.all(35),
                decoration: BoxDecoration(
                  color: themeColor,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  "assets/verified1.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Text(
                "Transaksi Berhasil!",
                style: TextStyle(
                  color: themeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                "Buku Berhasil Dibeli",
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                "klik disini untuk kembali ke home page",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Home()), // Ganti Home() dengan halaman tujuan yang sesuai
                  );
                },
                child: Text("Kembali ke Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
