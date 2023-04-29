
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsHelper {
  AdsHelper._();

  static final adHelper = AdsHelper._();

  BannerAd? bannerAd;

  loadBannerAd() {
    bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-4996530430036742~8231327088",
      listener: const BannerAdListener(),
      request: const AdRequest(),
    );
    bannerAd?.load();
  }
  InterstitialAd? interstitialAd;

  loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-4996530430036742~8231327088",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            interstitialAd = ad;
          },
          onAdFailedToLoad: (error) {}),
    );
  }
}