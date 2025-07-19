import 'package:crafty_bay_ecommerce/features/common/loading_widgets/loading_widget.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/product_card.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/new_prduct_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/popular_product_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/product_list_by_category_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/controller/special_product_controller.dart';
import 'package:crafty_bay_ecommerce/features/products/data/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.tag});

  final String tag;

  static final String name = 'product-list';

  @override
  State<ProductListScreen> createState() => _ProductList();
}

class _ProductList extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  dynamic _controller;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(loadMoreData);
    _controller = sourceCheck();
  }

  void loadMoreData() {
    if (_scrollController.position.extentAfter < 50) {
      // Get.find<ProductListByCategoryController>().getProductList(
      //   categoryId: widget.category.id,
      // );
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
          widget.tag,
          style: TextTheme.of(context).headlineSmall,
        ),
      ),
      body: GetBuilder(
        init: _controller,
        builder: (_) {
          return Visibility(
            visible: _controller.isLoading == false,
            replacement: Center(child: LoadingWidget.forScreen()),
            child:
              _controller.productList.isEmpty
                    ? Center(child: Text('No product on this category'))
                    : Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GridView.builder(
                              controller: _scrollController,
                              itemCount: _controller.productList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 16,
                                  ),
                              itemBuilder: ((BuildContext context, int index) {
                                Logger().w(
                                  _controller.productList.length,
                                );

                                var controller =
                                  _controller.productList[index];
                                return FittedBox(
                                  child: ProductCard(
                                    id:  controller.id,
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
                        _controller.isLoading
                            ? LinearProgressIndicator()
                            : SizedBox.shrink(),
                      ],
                    ),
          );
        },
      ),
    );
  }

 dynamic sourceCheck(){
    if(widget.tag.toLowerCase() == 'new'){
     return  Get.find<NewProductController>();
    }else if(widget.tag.toLowerCase() == 'special'){
      return  Get.find<SpecialProductController>();
    }else if(widget.tag.toLowerCase() == 'popular'){
      return  Get.find<PopularProductController>();
    }else {
      return  Get.find<NewProductController>();
    }
  }


  _onTapBack() {
    Navigator.pop(context);
  }
}
