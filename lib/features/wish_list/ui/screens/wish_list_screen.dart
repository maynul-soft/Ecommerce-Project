import 'package:crafty_bay_ecommerce/features/auth/ui/controller/main_bottom_nav_controller.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widgets/loading_widget.dart';
import 'package:crafty_bay_ecommerce/features/common/ui/widgets/product_card.dart';
import 'package:crafty_bay_ecommerce/features/wish_list/controller/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key,});

  static final String name = 'wish-list';

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  final ScrollController _controller = ScrollController();


  @override
  void initState() {
    super.initState();
    _controller.addListener(fetchProduct);
    fetchProduct();
  }

  fetchProduct() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WishListProvider>(context, listen: false).getWishListProduct(context);
    });
  }

  loadMoreData() {
    final provider = Provider.of<WishListProvider>(context, listen: false);

    if (_controller.position.extentAfter < 50 || provider.totalItem! >= provider.wishList.length){
      provider.getWishListProduct(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) => _backToHome(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _backToHome,
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(
            'Wish List',
            style: TextTheme
                .of(context)
                .headlineSmall,
          ),
        ),
        body: Consumer<WishListProvider>(
            builder: (_,controller,_) {
              return Visibility(
                visible: controller.isInitialLoading == false,
                replacement: Center(child: LoadingWidget.forScreen()),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GridView.builder(
                          controller: _controller,
                          itemCount: controller.wishList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 16
                          ),
                          itemBuilder: ((BuildContext context, int index) {
                            var wishListController = controller.wishList[index];
                            return FittedBox(
                              child: ProductCard(id: wishListController.productId,
                                title: wishListController.name,
                                price: wishListController.price,
                                imageUrl: wishListController.imageUrl.first,),
                            );
                          }),
                        ),
                      ),
                    ),
                    controller.isLoading? LinearProgressIndicator():SizedBox.shrink()
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  _backToHome() {
    Provider.of<MainBottomNavProvider>(context).backToHomeScreen();
  }
}
