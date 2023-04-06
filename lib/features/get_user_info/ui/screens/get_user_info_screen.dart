import 'package:flutter/material.dart';
import 'package:onboarding_challenge/core/router.dart';
import 'package:onboarding_challenge/core/routes.dart';
import 'package:onboarding_challenge/shared/design_system/ds.dart';
import 'package:onboarding_challenge/shared/storage/shared_prefs_storage.dart';
import 'package:onboarding_challenge/shared/strings/strings.dart';

import '../components/challenge_button.dart';

class GetUserInfoScreen extends StatefulWidget {
  const GetUserInfoScreen({super.key});

  @override
  State<GetUserInfoScreen> createState() => _GetUserInfoScreenState();
}

class _GetUserInfoScreenState extends State<GetUserInfoScreen> {
  final _loginController = TextEditingController();
  String? initialUserLogin;

  @override
  void initState() {
    super.initState();
    setState(() {
      initialUserLogin =
          localStorage.getString(LocalStorageKeys.userLoginStorageKey);
    });
  }

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.getUserInfoForm.title),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(ds.spacing.small),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(strings.getUserInfoForm.getUserInputLabel),
              TextFormField(
                controller: _loginController,
                decoration: InputDecoration(
                  hintText: strings.getUserInfoForm.getUserInputPlaceholder,
                ),
              ),
              SizedBox(height: ds.spacing.medium),
              Center(
                child: DefaultButton(
                  label: strings.getUserInfoForm.getUserInfoButtonLabel,
                  onTap: () {
                    AppRouter.pushNamed(
                      context,
                      Routes.userDetails,
                      arguments: _loginController.text,
                    );
                    localStorage.setString(
                      LocalStorageKeys.userLoginStorageKey,
                      _loginController.text,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
