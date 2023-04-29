import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../../Global.dart';
import '../../controllers/CurrencyConvertAPI.dart';
import '../../controllers/Provider/theme_Provider.dart';
import '../../controllers/ads_helper.dart';
import '../../controllers/controllers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<CurrencyConvert?> future;
  TextEditingController amtController = TextEditingController();
  TextStyle fromToStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    super.initState();
    AdsHelper.adHelper.interstitialAd;
    AdsHelper.adHelper.loadBannerAd();
    future = CurrencyConvertAPI.weatherAPI
        .currencyConvertorAPI(from: "USD", to: "INR", amt: 1);
    amtController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.light_mode),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
          ),
        ],
        centerTitle: true,
        title: Text(
          "Currency Convertor",
          style: GoogleFonts.aboreto(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder(
        future: future,
        builder: (context, snapShot) {
          if (snapShot.hasError) {
            return Center(
              child: Text("${snapShot.error}"),
            );
          } else if (snapShot.hasData) {
            CurrencyConvert? data = snapShot.data;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 95,
                    backgroundColor: Colors.amber,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundImage: NetworkImage(
                        "https://www.strictlybusinesslawblog.com/wp-content/webpc-passthru.php?src=https://www.strictlybusinesslawblog.com/wp-content/uploads/2021/04/resources-1.jpg&nocache=1",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text("Amount :", style: fromToStyle),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            controller: amtController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("From", style: fromToStyle),
                          DropdownButtonFormField(
                            value: Global.fromCurrency,
                            onChanged: (val) {
                              setState(() {
                                Global.fromCurrency = val!;
                              });
                            },
                            items: Global.currency.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("To", style: fromToStyle),
                          DropdownButtonFormField(
                            value: Global.toCurrency,
                            onChanged: (val) {
                              setState(() {
                                Global.toCurrency = val!;
                              });
                            },
                            items: Global.currency.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      onPressed: () {
                        if (amtController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text("Please Enter Amount"),
                            ),
                          );
                        } else {
                          int amt = int.parse(amtController.text);
                          setState(
                            () {
                              future = CurrencyConvertAPI.weatherAPI
                                  .currencyConvertorAPI(
                                from: Global.fromCurrency,
                                to: Global.toCurrency,
                                amt: amt,
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        "CONVERT",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      "Result : ${data!.difference}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AdWidget(ad: AdsHelper.adHelper.bannerAd!),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
