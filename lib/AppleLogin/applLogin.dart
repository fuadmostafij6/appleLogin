



import 'package:flutter/material.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AppleLogin extends StatefulWidget {
  const AppleLogin({Key? key}) : super(key: key);

  @override
  State<AppleLogin> createState() => _AppleLoginState();
}

class _AppleLoginState extends State<AppleLogin> {
  final Future<bool> _isAvailableFuture = TheAppleSignIn.isAvailable();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: _isAvailableFuture, builder: (BuildContext context, AsyncSnapshot<bool> isAvailableSnapshot) {


          if (!isAvailableSnapshot.hasData) {
            return Container(child: Text('Loading...'));
          }

          return isAvailableSnapshot.data!=null
              ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                 AppleSignInButton(
                    onPressed:signInWithApple),
             //   if (errorMessage != null) Text(errorMessage),
                SizedBox(
                  height: 200,
                ),

              ])
              : Text(
              'Sign in With Apple not available. Must be run on iOS 13+');
        },
        )
    );





  }

  Future signInWithApple() async {
    final AuthorizationResult result = await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);

    switch (result.status) {
      case AuthorizationStatus.authorized:
        final AppleIdCredential? _auth = result.credential;

        print("Fuad${_auth!.fullName}");

        // final OAuthProvider oAuthProvider = new OAuthProvider(providerId: "apple.com");
        //
        // final AuthCredential credential = oAuthProvider.getCredential(
        //   idToken: String.fromCharCodes(_auth.identityToken),
        //   accessToken: String.fromCharCodes(_auth.authorizationCode),
        // );


        // update the user information


        break;

      case AuthorizationStatus.error:
        print("Sign In Failed ${result.error!.localizedDescription}");
        break;

      case AuthorizationStatus.cancelled:
        print("User Cancled");
        break;
    }
  }
}