import 'package:flutter/material.dart';

class Dashboard2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/user_image.png'), // Replace with your image asset
          ),
        ),
        title: Text(
          'Welcome, Alex',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.black,
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Digital Marketing Banner
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 250, // Adjust the width as per your requirement
                      height: 150,
                      margin: EdgeInsets.only(left: 16.0, right: 8.0), // Adjust spacing between containers
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blueGrey,
                        image: DecorationImage(
                          image: AssetImage('assets/digital_marketing.png'), // Replace with your image asset
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'DIGITAL MARKETING',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // Add more containers here if needed
                    Container(
                      width: 250, // Adjust the width as per your requirement
                      height: 150,
                      margin: EdgeInsets.only(right: 8.0), // Adjust spacing between containers
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.redAccent,
                        image: DecorationImage(
                          image: AssetImage('assets/another_banner.png'), // Replace with another image asset
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'SOCIAL MEDIA MARKETING',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Topics Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Topics',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopicChip(label: 'Design'),
                        SizedBox(height: 8.0), // Space between rows
                        TopicChip(label: 'Autonomous System'),
                      ],
                    ),
                    SizedBox(width: 8.0), // Space between columns
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopicChip(label: 'Data Science'),
                        SizedBox(height: 8.0), // Space between rows
                        TopicChip(label: 'Artificial Intelligence'),
                      ],
                    ),
                    SizedBox(width: 8.0), // Space between columns
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TopicChip(label: 'Business'),
                        SizedBox(height: 8.0), // Space between rows
                        TopicChip(label: 'Cybersecurity'),
                      ],
                    ),
                    // Add more Columns here if you have more topics
                  ],
                ),
              ),
            ),

            // Batches Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Batches',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enables horizontal scrolling
                child: Row(
                  children: [
                    Container(
                      width: 250, // Adjust the width to your needs
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.orangeAccent,
                        image: DecorationImage(
                          image: AssetImage('assets/upsc_batch.png'), // Replace with your image asset
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'UPSC 2026',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Apply now'),
                              style: ElevatedButton.styleFrom(
                                // primary: Colors.red, // Uncomment to set button color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0), // Space between containers
                    // Add more containers here if needed
                    Container(
                      width: 250, // Adjust the width to your needs
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blueAccent,
                        image: DecorationImage(
                          image: AssetImage('assets/ssc_batch.png'), // Replace with another image asset
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SSC 2026',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Join now'),
                              style: ElevatedButton.styleFrom(
                                // primary: Colors.green, // Uncomment to set button color
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Add more containers if necessary
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopicChip extends StatelessWidget {
  final String label;

  TopicChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.grey.shade200,
      ),

    );
  }
}