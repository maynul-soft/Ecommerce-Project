import 'package:flutter/material.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key});

  static const name = 'Create Review Screen';

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Create Review',
          style: TextStyle(fontWeight: FontWeight.normal),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextFormField(decoration: InputDecoration(labelText: 'First Name')),
            SizedBox(height: 10),
            TextFormField(decoration: InputDecoration(labelText: 'Last Name')),
            SizedBox(height: 10),
            TextFormField(
              maxLines: 6,
              decoration: InputDecoration(hintText: 'Write Review'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
