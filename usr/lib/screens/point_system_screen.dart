import 'package:flutter/material.dart';

class PointSystemScreen extends StatefulWidget {
  const PointSystemScreen({super.key});

  @override
  State<PointSystemScreen> createState() => _PointSystemScreenState();
}

class _PointSystemScreenState extends State<PointSystemScreen> {
  int _points = 1250;
  final List<Map<String, dynamic>> _history = [
    {'title': 'Daily Login', 'points': 50, 'date': 'Today, 9:00 AM', 'isPositive': true},
    {'title': 'Completed Profile', 'points': 200, 'date': 'Yesterday', 'isPositive': true},
    {'title': 'Redeemed Coupon', 'points': -500, 'date': 'Yesterday', 'isPositive': false},
  ];

  void _earnPoints() {
    setState(() {
      int earned = 100;
      _points += earned;
      _history.insert(0, {
        'title': 'Bonus Task',
        'points': earned,
        'date': 'Just now',
        'isPositive': true,
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You earned $earned points!'), backgroundColor: Colors.green),
    );
  }

  void _spendPoints() {
    if (_points >= 200) {
      setState(() {
        int spent = 200;
        _points -= spent;
        _history.insert(0, {
          'title': 'Premium Feature',
          'points': -spent,
          'date': 'Just now',
          'isPositive': false,
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You spent 200 points!'), backgroundColor: Colors.orange),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Not enough points!'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rewards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Points Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Total Balance',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  '$_points',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Points',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _earnPoints,
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('Earn Points'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.blue.shade700,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _spendPoints,
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: const Text('Redeem'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),
          
          // History Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final item = _history[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: item['isPositive'] ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                      child: Icon(
                        item['isPositive'] ? Icons.arrow_downward : Icons.arrow_upward,
                        color: item['isPositive'] ? Colors.green : Colors.orange,
                      ),
                    ),
                    title: Text(
                      item['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(item['date']),
                    trailing: Text(
                      '${item['isPositive'] ? '+' : ''}${item['points']}',
                      style: TextStyle(
                        color: item['isPositive'] ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
