import 'package:crafty_bay_ecommerce/features/common/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key, required this.category});

  final String category;

  static final String name = 'category-list';

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _onTapBack,
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          widget.category,
          style: TextTheme.of(context).headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8 ),
        child: GridView.builder(
          itemCount: 100,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16
          ),
          itemBuilder: ((BuildContext context, int index) {
            return FittedBox(
                child: ProductCard(),

            );
          }),
        ),
      ),
    );
  }
  _onTapBack(){
    Navigator.pop(context);
  }
}
