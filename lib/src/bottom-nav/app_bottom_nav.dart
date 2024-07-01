import 'package:flutter/material.dart';
import 'package:hng_task_two_ecommerce/src/model/product_model.dart';
import 'package:hng_task_two_ecommerce/src/view/checkout_page.dart';
import 'package:hng_task_two_ecommerce/src/view/home_page.dart';

class AppBottomNav extends StatefulWidget {
  const AppBottomNav({super.key});

  @override
  _AppBottomNavState createState() => _AppBottomNavState();
}

class _AppBottomNavState extends State<AppBottomNav> {
  int _selectedIndex = 0;
  final List<ProductsModel> _selectedProducts = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addProductToCart(ProductsModel product) {
    bool isProductInCart = _selectedProducts.any((res) => res.id == product.id);

    if (isProductInCart) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('The product has been added to checkout already'),
      ));
    } else {
      setState(() {
        _selectedProducts.add(product);
        _selectedIndex = 1;
      });
    }
  }

  void _removeProductFromCart(ProductsModel product) {
    setState(() {
      _selectedProducts.remove(product);
    });
  }

  void _clearCart() {
    setState(() {
      _selectedProducts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          MyHomePage(
            onProductSelected: _addProductToCart,
          ),
          CheckoutPage(
            selectedProducts: _selectedProducts,
            onRemoveProduct: _removeProductFromCart,
            onClearCart: _clearCart,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Checkout',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
