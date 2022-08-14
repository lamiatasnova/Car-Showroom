import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerService extends StatelessWidget {
  const CustomerService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer service"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("For techincal issues, contact admin@admin.com"),
            SizedBox(
              height: 20,
            ),
            Text("For order details, contact support@carshowroom.com"),
          ],
        ),
      ),
    );
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries.map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
  }

  _launchEmail(String mail) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: mail,
      query: encodeQueryParameters(<String, String>{'subject': 'Car Showroom queries'}),
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw "Failed";
    }
  }
}
