import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widgets/loading_widget.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/create_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/product_review_controller.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.id});

  final String id;

  static final String name = 'ReviewScreen';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProductReviewController>().getReview(id: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews', style: TextStyle(fontWeight: FontWeight.w500)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_sharp),
        ),
        elevation: 10,
      ),
      body: GetBuilder<ProductReviewController>(
        builder: (controller) {
          return Visibility(
            visible:  controller.isLoading == false,
            replacement: Center(child:LoadingWidget.forScreen()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildReviewCardSection(),
                buildReviewCountSection(count: controller.reviewList.length, id: widget.id)
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildReviewCountSection({int? count, String? id}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),

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
          Expanded(
            child: Text(
              'Reviews (${count?? 0})',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          IconButton(
            onPressed: onTapToCrateReviewScreen,
            icon: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.themColor.shade700,
              ),
              child: IconButton(onPressed:()=> _createReviewScreen(id), icon: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(Icons.add),
              )),
            ),
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
          itemCount: Get.find<ProductReviewController>().reviewList.length,
          itemBuilder: ((BuildContext context, int index) {
            return GetBuilder<ProductReviewController>(
              builder: (controller) {
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
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
                              controller.reviewList[index].userName.isEmpty
                                  ? 'Maynul Islam Jibon'
                                  : controller.reviewList[index].userName,
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          controller.reviewList[index].comment.isEmpty
                              ? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                              : controller.reviewList[index].comment,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
        ),
      ),
    );
  }

  onTapToCrateReviewScreen() {
    Navigator.pushNamed(context, CreateReviewScreen.name);
  }

  _createReviewScreen(id){
    Navigator.pushNamed(context, CreateReviewScreen.name, arguments: id);
  }


}
