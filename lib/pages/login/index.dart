import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyahaal/controllers/index.dart';
import 'package:kyahaal/utils/index.dart';
import 'package:kyahaal/utils/validators.dart';
import 'package:kyahaal/widgets/textfield.dart';

class Login extends GetView<AuthController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.loginformKey,
          child: Column(
            children: [
              const Spacer(),
              Text(
                'Login',
                textAlign: TextAlign.center,
                style: context.textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              InputField(
                hint: 'Name',
                controller: controller.nameController,
                keyboardType: TextInputType.text,
                // validator: InputFieldValidators.name,
              ),
              InputField(
                hint: 'Phone Number',
                controller: controller.phoneController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                validator: InputFieldValidators.phone,
              ),
              Obx(
                () => [
                  LoginState.sentOTP,
                  LoginState.resendingOTP,
                  LoginState.verifyingOTP,
                  LoginState.verifiedOTP
                ].contains(controller.loginState)
                    ? InputField(
                        hint: 'OTP',
                        controller: controller.otpController,
                        keyboardType: TextInputType.number,
                        obscure: true,
                        maxLength: 6,
                        validator: InputFieldValidators.otp,
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(
                width: context.mediaQuery.size.width * 0.8,
                child: Obx(
                  () => ![
                    LoginState.sentOTP,
                    LoginState.resendingOTP,
                    LoginState.verifyingOTP,
                    LoginState.verifiedOTP
                  ].contains(controller.loginState)
                      ? const SizedBox.shrink()
                      : TextButton(
                          onPressed: controller.timeToResendOTP > 0
                              ? null
                              : controller.resendOTP,
                          child: Text(
                            controller.timeToResendOTP > 0
                                ? 'Resend OTP in ${controller.timeToResendOTPText}'
                                : 'Resend OTP',
                          ),
                        ),
                ),
              ),
              const Spacer(),
              Center(
                child: ElevatedButton(
                  style: ButtonStyles.primary,
                  onPressed: controller.handleLoginClick,
                  child: Obx(() {
                    final text = controller.loginBtnText;
                    return Text(text);
                  }),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
