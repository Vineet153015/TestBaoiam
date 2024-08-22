
import 'package:flutter/material.dart';
import 'package:testbaoiam/Screens/Home/Dashboard.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Notification'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            NotificationCard(
              title: 'Pending Courses',
              subtitle: 'You have got special offer',
              icon: Icons.access_time,
              color: Colors.orange,
            ),
            NotificationCard(
              title: 'Your Progress',
              subtitle: 'Well Done you have completed your today’s schedule',
              icon: Icons.check_circle,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 8),
            Text(
              'Yesterday',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            NotificationItem(
              title: 'Reward Earned',
              subtitle: 'Successfully referred',
              icon: Icons.redeem,
              iconColor: Colors.grey,
            ),
            NotificationItem(
              title: 'Course Purchased',
              subtitle: 'You have purchased UX/UI course',
              icon: Icons.shopping_cart,
              iconColor: Colors.grey,
            ),
            NotificationItem(
              title: 'Payment Successful',
              subtitle: 'You have Successfully Completed the payment',
              icon: Icons.payment,
              iconColor: Colors.grey,
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 8),
            Text(
              '2 January, 2024',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            NotificationItem(
              title: 'Account setup successfully',
              subtitle: 'You have got special offer',
              icon: Icons.account_circle,
              iconColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const NotificationItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.1),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
    );
  }
}
