import 'package:hng_task_two_ecommerce/utils/app_images.dart';

class ProductsModel {
  int? id;
  String? name;
  String? image;
  int? price;
  bool isFavourite;
  ProductsModel(
      {this.id, this.name, this.image, this.price, this.isFavourite = false});
 

  static List<ProductsModel> generateProduct = [
    ProductsModel(
      id: 1,
      price: 2000,
      image: AppImages.shoe1,
      isFavourite: false,
      name: 'MultiShoe',
    ),
    ProductsModel(
      id: 2,
      price: 1400,
      image: AppImages.shoe2,
      isFavourite: false,
      name: 'GreyShyn',
    ),
    ProductsModel(
      id: 3,
      price: 14400,
      image: AppImages.shoe3,
      isFavourite: false,
      name: 'RedHilly',
    ),
    ProductsModel(
      id: 4,
      price: 900,
      image: AppImages.shoe4,
      isFavourite: false,
      name: 'Golden Step Hill',
    ),
    ProductsModel(
      id: 5,
      price: 14400,
      image: AppImages.shoe5,
      isFavourite: false,
      name: 'White Neon',
    ),
    ProductsModel(
      id: 6,
      price: 1200,
      image: AppImages.shoe6,
      isFavourite: false,
      name: 'Air White',
    ),
    ProductsModel(
      id: 7,
      price: 14400,
      image: AppImages.shoe7,
      isFavourite: false,
      name: 'Nike Grinny',
    ),
    ProductsModel(
      id: 8,
      price: 14400,
      image: AppImages.shoe8,
      isFavourite: false,
      name: 'HilBrowny',
    ),
    ProductsModel(
      id: 9,
      price: 4400,
      image: AppImages.shoe9,
      isFavourite: false,
      name: 'Corporate Shoe',
    ),
    ProductsModel(
      id: 10,
      price: 14400,
      image: AppImages.shoe10,
      isFavourite: false,
      name: 'Floaty Fit',
    ),
  ];
}
