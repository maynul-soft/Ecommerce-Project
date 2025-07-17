import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/create_review_screen.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  static final String name = 'ReviewScreen';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews', style: TextStyle(fontWeight: FontWeight.w500)),
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_ios_new_sharp),
        ),
        elevation: 10,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildReviewCardSection(),
          buildReviewCountSection(),
        ],
      ),
    );
  }

  Container buildReviewCountSection() {
    return Container(
          padding:  EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.themColor.shade100,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: Text('Reviews (1000)',style: TextStyle(fontWeight: FontWeight.normal),)),
              IconButton(
                  onPressed: onTapToCrateReviewScreen,
                  icon: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.themColor.shade700
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(Icons.add),
                    ),
                  )
              ),
            ],
          ),
        );
  }

  Widget buildReviewCardSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemCount: 10,
          itemBuilder: ((BuildContext context, int index) {
            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.person_outline, size: 35),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Maynul Islam Jibon',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                      overflow: TextOverflow.visible,
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                    ),
                  ],
                ),
              ),
            );
          }),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
        ),
      ),
    );
  }


  onTapToCrateReviewScreen(){
    Navigator.pushNamed(context, CreateReviewScreen.name);
  }
}
