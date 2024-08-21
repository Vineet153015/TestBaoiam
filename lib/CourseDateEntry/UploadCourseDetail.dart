import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadCourseScreen extends StatefulWidget {
  @override
  _UploadCourseScreenState createState() => _UploadCourseScreenState();
}

class _UploadCourseScreenState extends State<UploadCourseScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController longDescriptionController = TextEditingController();
  final TextEditingController numnberOfClassessController = TextEditingController();
  final TextEditingController timePerWeekController = TextEditingController();

  File? _thumbnail;
  File? _authorImage;
  final picker = ImagePicker();

  Future ThumbnailpickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _thumbnail = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future AuthorpickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _authorImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadCourse() async {
    if (_thumbnail == null || _authorImage == null ) return;

    // Upload the image to Firebase Storage
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference thumbnailstorageReference =
    FirebaseStorage.instance.ref().child('thumbnails/$fileName');
    UploadTask uploadTask = thumbnailstorageReference.putFile(_thumbnail!);
    await uploadTask.whenComplete(() => null);
    String thumbnailimageUrl = await thumbnailstorageReference.getDownloadURL();



    // Uploading author image to Firebase Storage
    String AuthorfileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference AuthorstorageReference =
    FirebaseStorage.instance.ref().child('Author/$AuthorfileName');
    UploadTask AuthoruploadTask = AuthorstorageReference.putFile(_authorImage!);
    await AuthoruploadTask.whenComplete(() => null);
    String AuthorimageUrl = await AuthorstorageReference.getDownloadURL();

    List<String> tagsList = tagsController.text.split(',').map((tag) => tag.trim()).toList();


    // Store data in Firebase Realtime Database
    DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('courses');
    dbRef.push().set({
      'title': titleController.text,
      'description': descriptionController.text,
      'author': authorController.text,
      'duration': durationController.text,
      'Designation': designationController.text,
      'LongDescriptio': longDescriptionController.text,
      'NumberOfClasses': numnberOfClassessController.text,
      'TimePerWeek': timePerWeekController.text,
      'thumbnailUrl': thumbnailimageUrl,
      'AuthorImageURL' : AuthorimageUrl,
      'tags': tagsList
    }).then((_) {
      // Clear the fields after upload
      titleController.clear();
      descriptionController.clear();
      authorController.clear();
      durationController.clear();
      designationController.clear();
      longDescriptionController.clear();
      numnberOfClassessController.clear();
      timePerWeekController.clear();
      tagsController.clear(); // Clearing the tags field
      setState(() {
        _thumbnail = null;
        _authorImage = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Course uploaded successfully!'),
      ));
    }).catchError((error) {
      print('Failed to upload course: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Upload New Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),SizedBox(height: 16.0),
              TextField(
                controller: longDescriptionController,
                decoration: InputDecoration(labelText: 'Detailed Description'),
                maxLines: 12,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),SizedBox(height: 16.0),
              TextField(
                controller: designationController,
                decoration: InputDecoration(labelText: 'Designation'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: durationController,
                decoration: InputDecoration(labelText: 'Duration (e.g., 2 hours)'),
              ),SizedBox(height: 16.0),
              TextField(
                controller: numnberOfClassessController,
                decoration: InputDecoration(labelText: 'Number Of Classes This Course Have'),
              ),SizedBox(height: 16.0),
              TextField(
                controller: timePerWeekController,
                decoration: InputDecoration(labelText: 'Time Per Week'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: tagsController,
                decoration: InputDecoration(
                    labelText: 'Tags (comma separated, e.g., Technology,Management)'),
              ),
              SizedBox(height: 16.0),
              Text("Thumbnail Image Picker"),
              GestureDetector(
                onTap: ThumbnailpickImage,
                child: _thumbnail == null
                    ? Container(
                  width: double.infinity,
                  height: 150.0,
                  color: Colors.grey[300],
                  child: Icon(Icons.add_a_photo, color: Colors.grey[700]),
                )
                    : Image.file(_thumbnail!, height: 150.0, fit: BoxFit.cover),
              ),

              SizedBox(height: 16.0),
              Text("Author Image Picker"),
              GestureDetector(
                onTap: AuthorpickImage,
                child: _authorImage == null
                    ? Container(
                  width: double.infinity,
                  height: 150.0,
                  color: Colors.grey[300],
                  child: Icon(Icons.add_a_photo, color: Colors.grey[700]),
                )
                    : Image.file(_authorImage!, height: 150.0, fit: BoxFit.cover),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: uploadCourse,
                child: Text('Upload Course'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
