import 'package:flutter/material.dart';
import 'dashboard_class.dart'; // Import the service class

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  AdminService _adminService = AdminService();
  int _totalOrders = 0;
  int _totalProducts = 0;

  @override
  void initState() {
    super.initState();
    _fetchTotals();
  }

  Future<void> _fetchTotals() async {
    int orders = await _adminService.getTotalOrders();
    int products = await _adminService.getTotalProducts();
    setState(() {
      _totalOrders = orders;
      _totalProducts = products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total Orders: $_totalOrders',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                'Total Products: $_totalProducts',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
