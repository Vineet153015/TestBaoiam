import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CourseDetailScreen extends StatefulWidget {
  final String searchQuery;

  CourseDetailScreen({required this.searchQuery});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late Future<List<Map<String, String>>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = fetchDetailedsDescription();
  }


  Future<List<Map<String, String>>> fetchDetailedsDescription() async {
    final databaseReference = FirebaseDatabase.instance.ref();
    final snapshot = await databaseReference.child('courses').get();
    List<Map<String, String>> coursesList = [];

    if (snapshot.exists) {
      Map<dynamic, dynamic> courses = snapshot.value as Map<dynamic, dynamic>;

      print("Fetched courses data: $courses"); // Debug

      courses.forEach((key, value) {
        coursesList.add({

          'DetailedDescription': value['LongDescriptio'] ??'',
          'author': value['author'] ?? '',
          'duration': value['duration'] ?? '',
          'imageUrl': value['imageUrl'] ?? '',
          'NumberOfClasses' : value['NumberOfClasses'] ?? '',
          'TimePerWeek' : value['TimePerWeek'] ?? '',
          'Designation' : value['Designation'] ?? '',
          'AuthorImage' : value['AuthorImageURL'] ?? '',
        });

        print("Data Fetch Kr rha");
      });
    } else {
      print('No data exists in snapshot'); // Debug
    }
    print('Courses list: $coursesList'); // Debug
    return coursesList;

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("${widget.searchQuery}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body:
    FutureBuilder<List<Map<String, String>>>(
    future: _coursesFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No data available'));
      } else {
        final course = snapshot.data!.first;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: course['AuthorImage'] != null
                    ? Image.network(
                  course['AuthorImage']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/ui_ux_design.jpg',
                      fit: BoxFit.cover,
                    );
                  },
                )
                    : Image.asset(
                  'assets/images/ui_ux_design.jpg',
                  fit: BoxFit.cover,
                ),
              ),


              SizedBox(height: 16),
              // Course Title
              Text(
                'UI/UX Design',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // Mentor Information
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    // backgroundImage: AssetImage('assets/images/mentor.jpg'),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edward Ben',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Designer',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 20),
                      SizedBox(width: 4),
                      Text(
                        '4.6',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Tab Bar (Description & Modules)
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: Colors.red,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(text: 'Description'),
                        Tab(text: 'Modules'),
                      ],
                    ),
                    SizedBox(
                      height: 200, // Set the height for tab views
                      child: TabBarView(
                        children: [
                          // Description Tab
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Unlock the secrets of creating seamless and delightful user experiences with our comprehensive UI/UX Design Course. Whether you\'re a beginner or a professional, this course will guide you to mastery.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          // Modules Tab
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Module 1: Introduction to UI/UX\nModule 2: Design Principles\nModule 3: Wireframing and Prototyping\nModule 4: User Research and Testing\nModule 5: Final Project',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Course Duration and Classes
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    '6 months - 14 classes',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.schedule, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    '10 hours/week',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 24),
              // Enroll Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Enroll button action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Enroll Now',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }
    )
    );
  }
}
