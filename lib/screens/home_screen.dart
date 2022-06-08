import 'package:flutter/material.dart';
import 'package:food_delivery_ui/data/data.dart';
import 'package:food_delivery_ui/models/restaurant.dart';
import 'package:food_delivery_ui/screens/cart_screen.dart';
import 'package:food_delivery_ui/screens/restaurent_screen.dart';
import 'package:food_delivery_ui/widgets/recent_orders.dart';

import '../widgets/rating_stars.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _buildRestaurents() {
    List<Widget> restaurentList = [];
    restaurants.forEach((Restaurant restaurant) {
      restaurentList.add(GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RestaurentScreen(
              restaurent: restaurant,
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(width: 1.0, color: Colors.grey)),
          child: Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image(
                    height: 150.0,
                    width: 150.0,
                    image: AssetImage(restaurant.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(12.0),
                    child: Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              restaurant.name,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            RatingStars(
                              rating: restaurant.rating,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              restaurant.address,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "2 Miles Away",
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            )
                          ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ));
    });
    return Column(children: restaurentList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          iconSize: 30.0,
          onPressed: () {},
        ),
        title: const Text(" Food Delivery"),
        actions: [
          FlatButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CartScreen())),
              child: Text(
                'Cart (${currentUser.cart.length})',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      BorderSide(width: 0.8, color: Colors.deepOrangeAccent),
                ),
                hintText: "Search Hotel or Food",
                prefixIcon: Icon(
                  Icons.search,
                  size: 30.0,
                  color: Colors.deepOrangeAccent,
                ),
                suffixIcon: Icon(
                  Icons.clear,
                  size: 30.0,
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
          ),
          RecentOrders(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Nearby Restaurents",
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2),
                ),
              ),
              _buildRestaurents(),
            ],
          ),
        ],
      ),
    );
  }
}
