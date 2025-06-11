import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../app/app_colors.dart';
class HomeCarousalSlider extends StatefulWidget {
  const HomeCarousalSlider({
    super.key,
  });

  @override
  State<HomeCarousalSlider> createState() => _HomeCarousalSliderState();
}

class _HomeCarousalSliderState extends State<HomeCarousalSlider> {
  final ValueNotifier<int> _currentSlider = ValueNotifier(0);

  List<int> items = [1,2,3,4,5];


  @override
  Widget build(BuildContext context) {



    return Column(
      children: [
        CarouselSlider(
            items: items.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        borderRadius:  BorderRadius.circular(10),
                        color: AppColors.themColor
                    ),


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
              // autoPlay: true,
              // autoPlayInterval: Duration(seconds: 3),
              // autoPlayAnimationDuration: Duration(milliseconds: 800),
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.map(( int  i){
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
                  )
                );
              }
            );
          }).toList()

          ,
        )

      ],
    );
  }
}