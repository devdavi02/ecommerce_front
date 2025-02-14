import 'package:ecommerce_front/screens/login_screen.dart';

import 'controllers/product_controller.dart';
import 'controllers/category_controller.dart';
import 'controllers/role_controller.dart';
import 'controllers/subcategory_controller.dart';
import 'controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/login_controller.dart';
import 'controllers/cart_controller.dart';
import 'controllers/order_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => CategoryController()),
        ChangeNotifierProvider(create: (_) => SubCategoryController()),
        ChangeNotifierProvider(create: (_) => RoleController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => OrderController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Product App',
        theme: ThemeData(
          primarySwatch: Colors.blue, // Define a cor padrão do tema
        ),
        home: LoginScreen());
  }
}
