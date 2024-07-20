import 'package:flutter/material.dart';
import 'package:petopia/service/order_class.dart';
import 'package:petopia/widget/widget_support.dart';// Import the service class

class OrderScreen extends StatefulWidget {
  final String userId;

  OrderScreen({required this.userId});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderService _orderService = OrderService();
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrdersForUser(widget.userId);
  }

  Future<void> _fetchOrdersForUser(String userId) async {
    List<Map<String, dynamic>> orders = await _orderService.fetchOrdersForUser(userId);
    setState(() {
      _orders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Your Orders'),
      ),
      body: _orders.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          var order = _orders[index];
          var items = order['items'] as List<dynamic>;
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text('Name: ${order['name']}',style: AppWidget.semiBoldTextFieldStyle(),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: items.map((item) {
                  return Row(
                    children: [
                      Image.asset(
                        item['imageUrl'],
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(width: 10),
                      Text(item['title']),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
