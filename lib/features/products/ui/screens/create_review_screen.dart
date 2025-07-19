import 'package:crafty_bay_ecommerce/app/app_colors.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widgets/loading_widget.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/create_review_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.id});

  final String id ;
  static const name = 'Create Review Screen';

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final TextEditingController _reviewTeController = TextEditingController();
  final GlobalKey<FormState> _formKey  = GlobalKey<FormState>();
  final CreateReviewController controller =Get.find<CreateReviewController>();



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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 50),
              GetBuilder<CreateReviewController>(
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(5, (i){return GestureDetector(onTap: ()=> controller.ratingHandler(i), child: Icon(Icons.star,size: 50,color: controller.selectedIndex >= i ?AppColors.themColor:Colors.black45 ,));}).map((e)=> e).toList(),
                  );
                }
              ),
              SizedBox(height: 30),

              TextFormField(

                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Enter your comment';
                  }
                  return null;
                },
                controller: _reviewTeController,
                maxLines: 6,
                decoration: InputDecoration(hintText: 'Write Review'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed:()=> _onTapSubmitReview(),
                child: Visibility(
                  visible: controller.isLoading == false,
                  replacement:  LoadingWidget.forButton(),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onTapSubmitReview()async{

    int rating = controller.rating;

    Map<String,dynamic> body = {
      "product": widget.id,
      "comment": _reviewTeController.text.trim() ,
      "rating": rating
    };

    if(_formKey.currentState!.validate()){
      bool isSuccess = await  controller.createReview(body);

      if(isSuccess){
        _reviewTeController.clear();
        Get.snackbar('Thank you', 'your opinion is more valuable for us');
      }
    }

  }

}
