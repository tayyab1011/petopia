import 'package:flutter/material.dart';
import 'order_service.dart'; // Import the service class

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderService _orderService = OrderService();
  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    List<Map<String, dynamic>> orders = await _orderService.fetchOrders();
    setState(() {
      _orders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
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
              title: Text('Name: ${order['name']}'),
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
                      SizedBox(width: 20),
                      Text("Price \$"+item['price']),
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
