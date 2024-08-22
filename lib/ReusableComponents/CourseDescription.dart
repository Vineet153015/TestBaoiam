import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:testbaoiam/ReusableComponents/videoPlayer2.dart';
import 'package:testbaoiam/Screens/Home/SearchCategory.dart';
import 'package:testbaoiam/Screens/PopUpScreen/PopUpScreen.dart';



class CourseDetailScreen extends StatefulWidget {
  final String searchQuery;

  CourseDetailScreen({required this.searchQuery});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late Future<Map<String, String>?> _courseFuture;

  @override
  void initState() {
    super.initState();
    _courseFuture = fetchDetailedDescription();
  }

  Future<Map<String, String>?> fetchDetailedDescription() async {
    final databaseReference = FirebaseDatabase.instance.ref();
    final snapshot = await databaseReference.child('courses').get();
    Map<String, String>? courseDetails;

    if (snapshot.exists) {
      Map<dynamic, dynamic> courses = snapshot.value as Map<dynamic, dynamic>;

      print("Fetched courses data: $courses"); // Debug

      // Find the course that matches the search query
      courses.forEach((key, value) {
        if (value['title'] != null &&
            value['title'].toLowerCase() == widget.searchQuery.toLowerCase()) {
          courseDetails = {
            'title': value['title'] ?? '',
            'DetailedDescription': value['LongDescriptio'] ?? '',
            'author': value['author'] ?? '',
            'duration': value['duration'] ?? '',
            'imageUrl': value['thumbnailUrl'] ?? '',
            'NumberOfClasses': value['NumberOfClasses'] ?? '',
            'TimePerWeek': value['TimePerWeek'] ?? '',
            'Designation': value['Designation'] ?? '',
            'AuthorImage': value['AuthorImageURL'] ?? '',
            'description': value['description'] ?? '',
          };
        }
      });

      if (courseDetails == null) {
        print('No course matches the search query');
      }
    } else {
      print('No data exists in snapshot');
    }

    print('Course details: $courseDetails'); // Debug
    return courseDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.searchQuery),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: FutureBuilder<Map<String, String>?>(
        future: _courseFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No course found for the search query'));
          } else {
            final course = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9, // Example aspect ratio, you can adjust it
                    child: VideoPlayerPage()
                  ),
                  SizedBox(height: 16),
                  // Course Title
                  Text(
                    course['title']!,
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
                        backgroundImage: course['AuthorImage'] != null
                            ? NetworkImage(course['AuthorImage']!)
                            : AssetImage('assets/images/mentor.jpg')
                                as ImageProvider,
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course['author']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            course['Designation']!,
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
                                  course['description']!,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                              // Modules Tab
                              SearchResultScreen(searchQuery: widget.searchQuery),
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
                        '${course['duration']} - ${course['NumberOfClasses']} classes',
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
                        '${course['TimePerWeek']} hours/week',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Enroll Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Popupscreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
        },
      ),
    );
  }
}
