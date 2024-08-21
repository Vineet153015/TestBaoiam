import 'package:testbaoiam/Screens/Home/Category.dart';
import 'package:testbaoiam/Screens/Home/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:testbaoiam/Screens/Home/SearchCategory.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:permission_handler/permission_handler.dart';


class Searchfield extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Searchfield> {
  final TextEditingController _searchController = TextEditingController();
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FocusNode _focusNode = FocusNode();
  List<Map<dynamic, dynamic>> _searchResults = [];
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus(); // Request focus when the widget is initialized
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Map<dynamic, dynamic>>> _searchCourses(String query) async {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('courses');
    final snapshot = await dbRef.get();

    if (snapshot.exists) {
      List<Map<dynamic, dynamic>> results = [];
      Map<dynamic, dynamic> courses = snapshot.value as Map<dynamic, dynamic>;

      courses.forEach((key, value) {
        List<dynamic> tags = value['tags'] ?? [];
        if (tags.any((tag) => tag.toString().toLowerCase().contains(query.toLowerCase()))) {
          results.add(value);
        }
      });

      return results;
    } else {
      return [];
    }
  }


  void _onSearchChanged() async {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });

    // Firebase se suggestions fetch karo
    if (_searchQuery.isNotEmpty) {
      List<dynamic> rawSuggestions = await _searchCourses(_searchQuery);

      // Ensure karo ki tumhari list me sirf Strings hi ho
      List<String> suggestions = rawSuggestions.map((item) {
        if (item is String) {
          return item;
        } else if (item is Map) {
          // Map se specific value extract karo jo String ho
          // yaha 'name' ko replace karo us key se jisme tumhe String mil rahi ho
          return item['name'] as String;
        } else {
          // Kisi unexpected type ke case me empty string return karo ya error handle karo
          return '';
        }
      }).where((item) => item.isNotEmpty).toList();

      setState(() {
        _suggestions = suggestions;
      });
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  Future<void> _requestMicrophonePermission() async {
    var status = await Permission.microphone.status;
    if (!status.isGranted) {
      await Permission.microphone.request();
    }
  }


  void _startListening() async {
    await _requestMicrophonePermission();
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );

    if (available) {
      _speech.listen(
        onResult: (val) => setState(() {
          _searchController.text = val.recognizedWords;
          _searchQuery = val.recognizedWords.toLowerCase();
        }),
      );
      Fluttertoast.showToast(
        msg: "Listening...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Fluttertoast.showToast(
        msg: "The microphone is not available.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  List<String> popularSearches = [
    'UX/UI',
    'Python',
    'AWS',
    'Artificial Intelligence',
    'C++',
    'Excel',
    'Autonomous System',
    'React',
  ];

  List<Category> categories = [
    Category(
        name: 'Technology',
        image: 'assets/images/SearchPageAssets/technology.jpg'),
    Category(
        name: 'Management',
        image: 'assets/images/SearchPageAssets/management.jpg'),
    Category(
        name: 'Business', image: 'assets/images/SearchPageAssets/Business.jpg'),
    Category(
        name: 'Marketing',
        image: 'assets/images/SearchPageAssets/Marketing.jpg'),
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Filter popular searches based on search query
    final filteredSearches = popularSearches
        .where((search) => search.toLowerCase().contains(_searchQuery))
        .toList();

    // Filter categories based on search query
    final filteredCategories = categories
        .where((category) => category.name.toLowerCase().contains(_searchQuery))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F2), // Grey background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: TextFormField(
                controller: _searchController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      );
                    },
                  ),
                  hintText: 'What do you want to learn?',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: _startListening,
                  ),
                ),
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.center,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your search query';
                  }
                  return null;
                },
              ),
            ),
            if (_suggestions.isNotEmpty) ...[
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_suggestions[index]),
                    onTap: () {
                      // Jab user kisi suggestion par tap kare to usko select karo
                      setState(() {
                        _searchController.text = _suggestions[index];
                        _suggestions = [];
                      });
                    },
                  );
                },
              ),
            ],
            SizedBox(height: 24.0),
            // Popular Searches
            if (filteredSearches.isNotEmpty) ...[
              Text(
                'Popular searches',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: filteredSearches
                    .map((search) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => SearchResultScreen(searchQuery: search),
                            ),
                            );
                          },
                          child: Chip(
                            label: Text(
                              search,
                              style: TextStyle(color: Colors.grey),
                            ),
                            backgroundColor: Color(0xFFF2F2F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide.none,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
            SizedBox(height: 24.0),
            // Categories
            if (filteredCategories.isNotEmpty) ...[
              Text(
                'Categories',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.5,
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the CategoryDetailPage with the selected category
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchResultScreen(searchQuery: category.name),
                        ),
                      );
                    },
                    child: CategoryCard(category: filteredCategories[index]),
                  );
                },
              )

            ],
            if (filteredSearches.isEmpty && filteredCategories.isEmpty)
              Center(
                child: Text(
                  'No results found.',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
