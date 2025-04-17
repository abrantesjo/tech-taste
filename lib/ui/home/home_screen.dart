import 'package:flutter/material.dart';
import 'package:myapp/data/categories_data.dart';
import 'package:myapp/data/restaurant_data.dart';
import 'package:myapp/model/restaurant.dart';
import 'package:myapp/ui/_core/app_colors.dart';
import 'package:myapp/ui/_core/widgets/app_bar.dart';
import 'package:myapp/ui/checkout/checkout_screen.dart';
import 'package:myapp/ui/home/widgets/category_widget.dart';
import 'package:myapp/ui/home/widgets/restaurant_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RestaurantData restaurantData = Provider.of<RestaurantData>(context);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.mainColor),
              child: Text(
                'Bem-vindo!',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Sacola'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: getAppBar(context: context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), // faz o teclado sumir
        behavior: HitTestBehavior.opaque, //  capturar toques fora
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Center(child: Image.asset('assets/logo.png', width: 147)),
                SizedBox(height: 16),
                Text(
                  "Boas vindas!",
                  style: TextStyle(
                    fontSize: 24,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'O que você quer comer?',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white, width: 1.5),
                    ),
                    labelStyle: TextStyle(color: Colors.white70),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 32),
                Text(
                  "Escolha por categoria",
                  style: TextStyle(fontSize: 18, color: AppColors.mainColor),
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      CategoriesData.listCategories.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CategoryWidget(
                            category: CategoriesData.listCategories[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Image.asset('assets/banners/banner_promo.png'),
                SizedBox(height: 32),
                Text(
                  "Bem avaliados",
                  style: TextStyle(fontSize: 16, color: AppColors.mainColor),
                ),
                SizedBox(height: 16),
                Column(
                  children: List.generate(
                    restaurantData.listRestaurant.length,
                    (index) {
                      Restaurant restaurant =
                          restaurantData.listRestaurant[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: RestaurantWidget(restaurant: restaurant),
                      );
                    },
                  ),
                ),
                SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
