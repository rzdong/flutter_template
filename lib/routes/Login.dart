import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:flutter_template/common/UserModel.dart';
// import 'package:flutter_template/models/user.dart';

import '../common/Global.dart';


class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin;
    if (_unameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登陆'),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _unameController,
                  decoration: InputDecoration(
                    labelText: '用户名字',
                    hintText: '姓名或者邮箱',
                    prefixIcon: Icon(Icons.person),
                  ),
                  // 校验用户名（不能为空）
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : '姓名是必须的';
                  }),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                    labelText: '密码',
                    hintText: '密码',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          pwdShow ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                    )),
                obscureText: !pwdShow,
                //校验密码（不能为空）
                validator: (v) {
                  return v.trim().isNotEmpty ? null : '密码是必须的';
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _onLogin,
                    textColor: Colors.white,
                    child: Text('登陆'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _onLogin() async {
    // 提交前，先验证各个表单字段是否合法
    // if ((_formKey.currentState as FormState).validate()) {
    //   showLoading(context);
    //   User user;
    //   try {
    //     user = await Git(context).login(_unameController.text, _pwdController.text);
    //     // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
    //     Provider.of<UserModel>(context, listen: false).user = user;
    //   } catch (e) {
    //     //登录失败则提示
    //     if (e.response?.statusCode == 401) {
    //       showToast('用户名或者密码错误');
    //     } else {
    //       showToast(e.toString());
    //     }
    //   } finally {
    //     // 隐藏loading框
    //     Navigator.of(context).pop();
    //   }
    //   if (user != null) {
    //     // 返回
    //     Navigator.of(context).pop();
    //   }
    // }
  }
}