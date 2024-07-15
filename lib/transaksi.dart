import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaksi'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('transactions').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Tidak ada transaksi.'));
          }

          final transactions = snapshot.data!.docs;

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction =
                  transactions[index].data() as Map<String, dynamic>;
              final bookTitle = transaction['book_title'] ?? 'N/A';
              final quantity = transaction['quantity'] ?? 0;
              final timestamp = transaction['timestamp'] != null
                  ? (transaction['timestamp'] as Timestamp).toDate()
                  : DateTime.now();

              return ListTile(
                title: Text(bookTitle),
                subtitle:
                    Text('Jumlah: $quantity\nTanggal: ${timestamp.toLocal()}'),
              );
            },
          );
        },
      ),
    );
  }
}
