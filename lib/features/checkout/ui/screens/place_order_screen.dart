import 'package:crafty_bay_ecommerce/features/cert/controller/get_cart_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  static const name = 'place-order-screen';

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final GetCartProductController _getCartProductController = Get.find<GetCartProductController>();
  final TextEditingController _fullNameTeController = TextEditingController();
  final TextEditingController _mobileNumberTeController = TextEditingController();
  final TextEditingController _addressTeController = TextEditingController();
  final TextEditingController _cityTeController = TextEditingController();
  final TextEditingController _postTeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final mobileRegex = RegExp(r'^(\+88)?01[3-9]\d{8}$');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: _fullNameTeController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value== null || value.isEmpty){
                        return 'Enter your name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Full name',
                      labelText: 'Type your full name'
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: _mobileNumberTeController,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value== null || value.isEmpty){
                        return 'Enter your mobile number';
                      }else if(!mobileRegex.hasMatch(value)){
                        return'Enter a valid mobile number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Mobile',
                      labelText: 'Type your mobile number'
                    ),
                  ),
                  const SizedBox(height: 15,),
                  TextFormField(
                    controller: _addressTeController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value== null || value.isEmpty){
                        return 'Enter your address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Address',
                        labelText: 'Enter your address'
                    ),
                  ),
                  const SizedBox(height: 15,),

                  Row(spacing: 8, children: [
                    Expanded(child:  TextFormField(
                      controller: _cityTeController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value){
                        if(value== null || value.isEmpty){
                          return 'Enter your city';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'City',
                          labelText: 'Enter your City'
                      ),
                    ),),
                    Expanded(child:  TextFormField(
                      controller: _postTeController,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value){
                        if(value== null || value.isEmpty){
                          return 'Enter your postcode';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: 'Postcode',
                          labelText: 'Enter your postcode'
                      ),
                    ),)
                  ],),
                  SizedBox(height: 30,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total price:'),
                      Text('${_getCartProductController.totalPrice}')
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Fee:'),
                      Text('${_getCartProductController.deliveryCharge}')
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax :'),
                      Text('${_getCartProductController.tax}')
                    ],
                  ),Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Total :'),
                      Text('${_getCartProductController.checkoutPrice}')
                    ],
                  ),

                  SizedBox(height: 15,),

                  Row(
                    children: [
                     Container(
                       height: 100,
                       width: 100,
                       decoration: BoxDecoration(

                       ),
                       child: Image.network('https://www.digitallockerhouse.com/public/assets/img/cards/sslcommerz.png',
                       fit: BoxFit.fill,
                       ),
                     )
                    ],
                  )

                ],),
              ),
            ),
            ),
            const SizedBox(height: 15,),
            ElevatedButton(onPressed:_onTapPlaceOrder, child: Text('Place order'))
          ],
        ),
      ),
    );
  }



  _onTapPlaceOrder(){
  Map<String,dynamic> body =  {
    "payment_method": "ssl",
    "shipping_address": {
    "full_name": _fullNameTeController.text.trim(),
    "address": _addressTeController.text.trim(),
    "city": _cityTeController.text.trim(),
    "postal_code": _postTeController.text.trim(),
    "phone": _mobileNumberTeController.text.trim()
  },
    "redirect_url":"https://jsonplaceholder.typicode.com/posts"
  };


  }
}
