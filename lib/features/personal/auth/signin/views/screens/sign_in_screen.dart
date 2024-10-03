import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/utilities/app_validators.dart';
import '../../../../../../core/widgets/costom_textformfield.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/password_textformfield.dart';
import '../../../../../../core/widgets/sellout_title.dart';
import '../../../../../../routes/app_linking.dart';
import '../../../../dashboard/views/screens/dasboard_screen.dart';
import '../../../signup/views/screens/signup_screen.dart';
import '../providers/signin_provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});
  static const String routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          TextButton(
            onPressed: () => AppNavigator.pushNamed(DashboardScreen.routeName),
            child: const Text('skip').tr(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Consumer<SigninProvider>(
            builder: (BuildContext context, SigninProvider authPro, _) {
          return Column(
            children: <Widget>[
              const SellOutTitle(),
              const SizedBox(height: 24),
              CustomTextFormField(
                controller: authPro.email,
                labelText: 'email'.tr(),
                hint: 'Ex: username@mail.com',
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) => AppValidator.email(value),
              ),
              PasswordTextFormField(controller: authPro.password),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async => await authPro.forgotPassword(),
                  child: Text(
                    'forgot_password',
                    style: TextStyle(color: Theme.of(context).dividerColor),
                  ).tr(),
                ),
              ),
              CustomElevatedButton(
                title: 'login'.tr(),
                isLoading: authPro.isLoading,
                onTap: () async => await authPro.signIn(),
              ),
              CustomElevatedButton(
                title: 'create-account'.tr(),
                isLoading: false,
                bgColor: Colors.transparent,
                border: Border.all(),
                onTap: () async =>
                    await AppNavigator.pushNamed(SignupScreen.routeName),
              ),
            ],
          );
        }),
      ),
    );
  }
}
