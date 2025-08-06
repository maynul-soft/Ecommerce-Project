import 'package:crafty_bay_ecommerce/core/urls.dart';
import 'package:crafty_bay_ecommerce/core/service/network_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToWishListProvider extends ChangeNotifier{

  Future<void> addToWishList(context,{required String id})async{

    NetworkResponse response = await  Provider.of<NetworkClient>(context, listen: false).postRequest(
        url: Urls.addToWishlistUrl,
        body: {"product": id}
    );

    if(response.statusCode == 200 || response.statusCode == 201){
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content:  Text('Grate..! Successfully added to wishlist'),
      //     )
      // );

    }else{
      // ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content:  Text('Sorry..! ${response.errorMessage}'),
      //     )
      // );
    }
  }
}