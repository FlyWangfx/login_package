import 'package:be_login/model/login_model.dart';
import 'package:be_login/res/zh.dart';
import 'package:be_widgets/widgets/components/password_text.dart';
import 'package:flutter/material.dart';

class BELogin extends StatefulWidget {
  final String title;
  final String? subTitle;
  final ImageProvider backgroundImage;
  final String? username;
  final String? password;
  final void Function(LoginModel loginModel) onClickLogin;
  final void Function() onClickPrivacy;
  final void Function()? onClickSwitchServer;

  const BELogin({
    Key? key,
    this.subTitle,
    required this.title,
    required this.backgroundImage,
    this.username,
    this.password,
    required this.onClickLogin,
    required this.onClickPrivacy,
    this.onClickSwitchServer,
  }) : super(key: key);

  @override
  State<BELogin> createState() => _BELoginState();
}

class _BELoginState extends State<BELogin> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// 密码是否可见
  final bool _passwordVisible = true;

  bool? _isReadPrivacyPolicy = false;
  bool? _rememberPassword = true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void didUpdateWidget(BELogin oldWidget) {
    super.didUpdateWidget(oldWidget);
    initData();
  }

  void initData() {
    _usernameController.text = widget.username ?? '';
    _passwordController.text = widget.password ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: widget.backgroundImage,
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.subTitle != null)
                      Text(
                        widget.subTitle!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Container(
                      width: 240,
                      margin: const EdgeInsets.only(top: 80),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            controller: _usernameController,
                            //container
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              icon: Icon(Icons.person),
                              hintText: ZH.account,
                            ),
                            maxLength: 11,
                          ),
                          PasswordText(
                            hintText: ZH.password,
                            passwordController: _passwordController,
                            passwordVisible: _passwordVisible,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 240,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: _rememberPassword,
                            onChanged: (bool? v) {
                              setState(() {
                                _rememberPassword = v;
                              });
                            },
                          ),
                          Text(
                            '记住密码',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 36),
                      width: 240,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromRGBO(106, 175, 247, 1),
                            Color.fromRGBO(21, 101, 242, 1),
                          ],
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => widget.onClickLogin(
                          LoginModel(
                            username: _usernameController.text,
                            password: _passwordController.text,
                            isReadPrivacyPolicy: _isReadPrivacyPolicy,
                            rememberPassword: _rememberPassword,
                          ),
                        ),
                        child: const Text(
                          ZH.signIn,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: _isReadPrivacyPolicy,
                          onChanged: (bool? v) {
                            setState(() {
                              _isReadPrivacyPolicy = v;
                            });
                          },
                        ),
                        TextButton(
                          onPressed: widget.onClickPrivacy,
                          child: Text(
                            ZH.read_privacy_policy,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        if (widget.onClickSwitchServer != null)
                          const Text(
                            "|",
                            style: TextStyle(
                              color: Color.fromRGBO(17, 17, 17, 0.1),
                            ),
                          ),
                        if (widget.onClickSwitchServer != null)
                          TextButton(
                            onPressed: widget.onClickSwitchServer,
                            child: Text(
                              ZH.change_server,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
