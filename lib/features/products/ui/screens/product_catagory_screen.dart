import 'package:crafty_bay_ecommerce/features/auth/ui/controller/main_bottom_nav_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widgets/loading_widget.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_%20catagory_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/ui/screens/product_list_by_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/ui/widgets/catagory_card.dart';

class ProductCategoryScreen extends StatefulWidget {
  const ProductCategoryScreen({super.key});

  static final String name = 'product_category';

  @override
  State<ProductCategoryScreen> createState() => _ProductCategoryScreenState();
}

class _ProductCategoryScreenState extends State<ProductCategoryScreen> {



  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreData);
  }

  void _loadMoreData (){
    if(_scrollController.position.extentAfter <200){
     Provider.of<ProductCategoryProvider>(context).getCategoryList(context);
    }
  }



  @override
  Widget build(BuildContext context) {

    MainBottomNavProvider mainBottomNavProvider =
    Provider.of<MainBottomNavProvider>(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        mainBottomNavProvider.backToHomeScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Categories', style: TextTheme.of(context).headlineSmall),
          leading: IconButton(
            onPressed: _onTapBackButton,
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Consumer<ProductCategoryProvider>(
          builder: (_,categoryController,_) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    itemCount: categoryController.categoryList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 5,
                    ),
                    itemBuilder: ((BuildContext context, int index) {
                      var controller = categoryController.categoryList[index];
                      return FittedBox(
                        child: GestureDetector(
                          onTap: ()async{
                            Navigator.pushNamed(context, ProductListByCategoryScreen.name, arguments: categoryController.categoryList[index]);
                          },
                          child: CategoryCard(
                            categoryName: controller.title,
                            imageUrl: controller.icon,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                categoryController.isLoading? LoadingWidget.forScreen() :SizedBox.shrink()
              ],
            );
          },
        ),
      ),
    );
  }

  _onTapBackButton() {
    Provider.of<MainBottomNavProvider>(context, listen: false).backToHomeScreen();
  }
}
