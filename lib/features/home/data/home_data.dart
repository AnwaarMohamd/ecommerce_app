import 'package:ecommerce_app/core/constants/app_assets.dart';
import 'package:ecommerce_app/features/home/data/product_model.dart';

class HomeData {
  static List<String> categories = [
    'Technology',
    'Fashion',
    'Sports',
    'Supermarket',
  ];

  static List<ProductModel> hotSales = [
    ProductModel(
      title: "MacBook Pro 16",
      price: "\$999",
      image: AppAssets.macbook,
      description:
          "A powerful laptop with stunning display and long battery life.",
    ),
    ProductModel(
      title: "Sony WH-1000XM4",
      price: "\$100",
      image: AppAssets.headSet,
      description: "Next-level noise cancellation and premium sound quality.",
    ),
    ProductModel(
      title: "Speaker",
      price: "\$200",
      image: AppAssets.speaker,
      description: "Next-level noise cancellation and premium sound quality.",
    ),
    ProductModel(
      title: "Switch",
      price: "\$300",
      image: AppAssets.switchDevice,
      description: "Next-level noise cancellation and premium sound quality.",
    ),
  ];

  static List<ProductModel> recentlyViewed = [
    ProductModel(
      title: "AirPods Pro",
      price: "\$1,999",
      image: AppAssets.redAirPods,
      description: "Immersive audio with adaptive transparency for daily use.",
    ),
  ];
}
