import 'package:flutter/material.dart';
import 'package:wasteagram/widgets/account/account.dart';

class AccountPage extends StatelessWidget {
  static const route = '/account';
  static const title = 'Account';

  @override
  Widget build(BuildContext context) {
    return Account();
  }
}
