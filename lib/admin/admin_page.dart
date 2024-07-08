import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uts/home.dart';
import 'auth_service.dart';
import 'package:uts/home.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['email']),
                subtitle: Text('Role: ${doc['role']}'),
                trailing: doc['role'] == 'seller'
                    ? ElevatedButton(
                        child: Text('Remove Seller'),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(doc.id)
                              .update({'role': 'user'});
                        },
                      )
                    : ElevatedButton(
                        child: Text('Make Seller'),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(doc.id)
                              .update({'role': 'seller'});
                        },
                      ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
