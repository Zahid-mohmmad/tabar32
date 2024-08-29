import 'package:e_commerce_app/features/account/screens/widgets/account_button.dart';
import 'package:e_commerce_app/features/account/services/account_services.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your Charity products', onTap: () {}),
            AccountButton(
              text: 'Log Out',
              onTap: () => AccountServices().logOut(context),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(text: 'List', onTap: () {}),
            AccountButton(text: 'something', onTap: () {}),
          ],
        )
      ],
    );
  }
}
