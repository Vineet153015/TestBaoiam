import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:testbaoiam/ReusableComponents/CourseDescription.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchQuery;

  SearchResultScreen({required this.searchQuery});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {

  Future<List<Map<String, String>>> fetchCourses() async {
    final databaseReference = FirebaseDatabase.instance.ref();
    final snapshot = await databaseReference.child('courses').get();

    List<Map<String, String>> coursesList = [];

    if (snapshot.exists) {
      Map<dynamic, dynamic> courses = snapshot.value as Map<dynamic, dynamic>;

      print("Fetched courses data: $courses"); // Debug

      courses.forEach((key, value) {
        List<dynamic>? tags = value['tags']; // Expect tags to be a List

        if (tags != null && tags is List) {
          List<String> tagsList = tags.map((tag) => tag.toString()).toList();

          print('Tags list: $tagsList'); // Debug

          bool matchFound = tagsList.any((tag) => tag.toLowerCase().contains(widget.searchQuery.toLowerCase()));

          print('Match found: $matchFound'); // Debug

          if (matchFound) {
            coursesList.add({
              'title': value['title'] ?? '',
              'description': value['description'] ?? '',
              'author': value['author'] ?? '',
              'duration': value['duration'] ?? '',
              'imageUrl': value['thumbnailUrl'] ?? '',
            });

            print("Data Fetch Kr rha");
          }
        } else {
          print('Tags are null or not in expected format: $tags'); // Debug
        }
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
        backgroundColor: Colors.white,
        title: Text('Results for "${widget.searchQuery}"'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: fetchCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No results found for "${widget.searchQuery}".',
                style: TextStyle(fontSize: 18.0),
              ),
            );
          }

          final results = snapshot.data!;

          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                        builder: (context) => CourseDetailScreen(
                      searchQuery: result['title'] ?? 'No title',
                    ),
                        )
                    );

                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: result['imageUrl'] != null && result['imageUrl']!.startsWith('http')
                                ? Image.network(
                              result['imageUrl']!,
                              height: 90.0, // Adjust height and width as needed
                              width: 90.0,
                              fit: BoxFit.cover,
                            )
                                : Image.asset(
                              'assets/logo/baoiam_logo.png', // Default local asset
                              height: 90.0, // Adjust height and width as needed
                              width: 90.0,
                              fit: BoxFit.fill,
                            ),
                          ),

                          SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  result['title'] ?? 'No title',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6.0),
                                Text(
                                  result['description'] ?? 'No description',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      result['author'] ?? 'Unknown Author',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      result['duration'] ?? 'Unknown Duration',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
