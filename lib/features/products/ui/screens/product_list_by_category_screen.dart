import 'package:crafty_bay_ecommerce/features/common/loading_widgets/loading_widget.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/product_card.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_list_by_category_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/data/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProductListByCategoryScreen extends StatefulWidget {
  const ProductListByCategoryScreen({super.key, required this.category});

  final CategoryModel category;

  static final String name = 'category-list';

  @override
  State<ProductListByCategoryScreen> createState() => _ProductListByCategoryScreenState();
}

class _ProductListByCategoryScreenState extends State<ProductListByCategoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(loadMoreData);
    Get.find<ProductListByCategoryController>().getProductList(
      categoryId: widget.category.id,
    );
  }

  void loadMoreData() async {
    if (_scrollController.position.extentAfter < 50) {
     await  Get.find<ProductListByCategoryController>().getProductList(
        categoryId: widget.category.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _onTapBack,
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          widget.category.title,
          style: TextTheme.of(context).headlineSmall,
        ),
      ),
      body: GetBuilder<ProductListByCategoryController>(
        builder: (productController) {
          return Visibility(
            visible: productController.isInitialLoading == false,
            replacement: Center(child: LoadingWidget.forScreen()),
            child:
                productController.productList.isEmpty
                    ? Center(child: Text('No product on this category'))
                    : Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GridView.builder(
                              controller: _scrollController,
                              itemCount: productController.productList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 16,
                                  ),
                              itemBuilder: ((BuildContext context, int index) {
                                var controller =
                                    productController.productList[index];
                                return FittedBox(
                                  child: ProductCard(
                                    id: controller.id,
                                    imageUrl:
                                        controller.imageUrl.isNotEmpty
                                            ? controller.imageUrl.first
                                            : null,
                                    title: controller.name,
                                    price: controller.price,
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        productController.isLoading
                            ? LinearProgressIndicator()
                            : SizedBox.shrink(),
                      ],
                    ),
          );
        },
      ),
    );
  }

  _onTapBack() {
    Navigator.pop(context);
  }
}
