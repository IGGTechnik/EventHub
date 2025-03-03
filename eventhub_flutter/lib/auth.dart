import 'package:eventhub_flutter/graphql/graphql.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

Credential? c;

authenticate({String uri = "http://localhost:8080/realms/eventhub/", String clientId = "flutter-frontend"}) async {
  var issuer = await Issuer.discover(Uri.parse(uri));
  var client = Client(issuer, clientId);

  urlLauncher(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), webViewConfiguration: const WebViewConfiguration());
    } else {
      throw 'Could not launch $url';
    }
  }
    
    // create an authenticator
    var authenticator = Authenticator(client,
        scopes: [],
        port: 4000, urlLancher: urlLauncher);
    
    // starts the authentication
    c = await authenticator.authorize();
    
    // close the webview when finished
    //closeInAppWebView();
    
    //set GraphQL client token
    var token = (await c!.getTokenResponse()).accessToken;
    if (token != null) {
      setAuthToken(token);
    } else {
      throw 'Token is null';
    }

    // return the user info
    return (await c!.getTokenResponse()).accessToken;
}


/*
authenticate(Uri.parse("http://localhost:8080/realms/eventhub/"), "flutter-frontend", []).then((value) {
                    print(value.toString());
                    setAuthToken(value.toString());
                    setState(() {
                      token = value.toString();
                    });
                    print(token == "" ? "No token" : token);
                  });
                  }, */