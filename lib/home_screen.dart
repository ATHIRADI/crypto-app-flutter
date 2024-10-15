import 'dart:convert';

import 'package:crypto_app/coin_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> cryptoCurrenciesData = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    getCryptoData();
  }

  Future<void> getCryptoData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=500&page=1&sparkline=false'));

      if (response.statusCode == 200) {
        setState(() {
          cryptoCurrenciesData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load data. Please try again later.';
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage =
            'An error occurred. Please check your internet connection.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.black38,
        actions: const [],
        title: const Text(
          'Crypto Currency App',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Text(errorMessage!,
                      style: const TextStyle(color: Colors.red)))
              : ListView.builder(
                  itemCount: cryptoCurrenciesData.length,
                  itemBuilder: (context, index) {
                    final crypto = cryptoCurrenciesData[index];
                    return _buildCryptoListTile(crypto, context);
                  },
                ),
    );
  }
}

Widget _buildCryptoListTile(dynamic crypto, BuildContext context) {
  final name = crypto["name"];
  final symbol = crypto["symbol"];
  final image = crypto["image"];
  final price = crypto["current_price"];
  final priceChange = crypto["price_change_24h"];

  return ListTile(
    textColor: Colors.white,
    leading: Image.network(image, height: 40, width: 40),
    title: Text("$name ($symbol)", style: const TextStyle(fontSize: 16)),
    subtitle: Text(
      "Change: \$${priceChange.toStringAsFixed(2)}",
      style: TextStyle(color: priceChange >= 0 ? Colors.green : Colors.red),
    ),
    trailing: Text(
      "\$${price.toStringAsFixed(2)}",
      style: const TextStyle(fontSize: 16, color: Colors.white),
    ),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CoinDetails(coinData: crypto),
        ),
      );
    },
  );
}
