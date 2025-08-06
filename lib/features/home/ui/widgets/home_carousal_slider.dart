import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay_ecommerce/features/common/loading_widgets/loading_widget.dart';
import 'package:crafty_bay_ecommerce/features/home/controller/home_slider_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
class HomeCarousalSlider extends StatefulWidget {
  const HomeCarousalSlider({
    super.key,
  });

  @override
  State<HomeCarousalSlider> createState() => _HomeCarousalSliderState();
}

class _HomeCarousalSliderState extends State<HomeCarousalSlider> {
  final ValueNotifier<int> _currentSlider = ValueNotifier(0);


  @override
  Widget build(BuildContext context) {
    // HomeSliderController homeSliderController = Get.find<HomeSliderController>();
    return Consumer<HomeSliderProvider>(
      builder: (_,provider,_) {
        return Visibility(
          visible: provider.isLoading == false,
          replacement:  LoadingWidget.forHomeCarouselShimmer(),
          child: Column(
            children: [
              CarouselSlider(
                  items: provider.homeSliderList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Consumer<HomeSliderProvider>(
                          builder: (_,controller,_) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                  borderRadius:  BorderRadius.circular(10),
                                  color: Colors.white //  AppColors.themColor
                              ),
                              child: Image.network(i.photoUrl,fit: BoxFit.cover,) ,
                            );
                          }
                        );
                      },
                    );
                  }).toList(),
                  options: CarouselOptions(
                    onPageChanged: (int currentIndex, _){
                      _currentSlider.value = currentIndex;
                    },
                    height: 140,
                    viewportFraction: 1,
                    // initialPage: 0,
                    // enableInfiniteScroll: true,
                    // reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    // autoPlayAnimationDuration: Duration(milliseconds: 800),
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(provider.homeSliderList.length, (int index)=> index+1).map(( int  i){
                  return ValueListenableBuilder(
                    valueListenable: _currentSlider,
                    builder: (context, int index, _) {
                      return Container(
                        margin: EdgeInsets.all(4),
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: i == index+1 ? AppColors.themColor:Colors.white,
                         borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.themColor.shade200),
                        ),

                      );
                    }
                  );
                }).toList()

                ,
              )

            ],
          ),
        );
      }
    );
  }
}