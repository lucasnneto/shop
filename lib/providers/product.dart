import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });
  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  void toggleFavorite() async {
    _toggleFavorite();
    try {
      final url =
          "https://flutter-cod3r-a280a-default-rtdb.firebaseio.com/products";

      final response = await http.patch(
        Uri.parse('$url/$id.json'),
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch (error) {
      _toggleFavorite();
    }
  }
}
