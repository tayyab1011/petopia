import 'package:cloud_firestore/cloud_firestore.dart';

class AdminService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getTotalOrders() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('orders').get();
      return snapshot.size;
    } catch (e) {
      print('Error fetching total orders: $e');
      return 0;
    }
  }

  Future<int> getTotalProducts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('products').get();
      return snapshot.size;
    } catch (e) {
      print('Error fetching total products: $e');
      return 0;
    }
  }
}
