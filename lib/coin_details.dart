import 'package:flutter/material.dart';

class CoinDetails extends StatelessWidget {
  final Map<String, dynamic> coinData;

  const CoinDetails({super.key, required this.coinData});

  @override
  Widget build(BuildContext context) {
    final name = coinData["name"];
    final symbol = coinData["symbol"];
    final image = coinData["image"];
    final price = coinData["current_price"];
    final priceChange = coinData["price_change_24h"];
    final marketCap = coinData["market_cap"];
    final high24h = coinData["high_24h"];
    final low24h = coinData["low_24h"];

    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.red, // Change this to your desired color
        ),
        title: Text(
          "$name ($symbol)",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black38,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(image, height: 100),
              const SizedBox(height: 20),
              _buildDetailText("Current Price", price, Colors.green),
              _buildDetailText("Price Change (24h)", priceChange, Colors.red),
              _buildDetailText("Market Cap", marketCap, Colors.white),
              _buildDetailText("24h High", high24h, Colors.white),
              _buildDetailText("24h Low", low24h, Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailText(String label, dynamic value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "$label: \$${value.toStringAsFixed(2)}",
        style: TextStyle(fontSize: 16, color: color),
      ),
    );
  }
}
