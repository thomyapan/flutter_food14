import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 90.0,
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          SizedBox(height: 24.0),
          Text('Promlert Lovichit',
              style: Theme.of(context).textTheme.headline1),
          SizedBox(height: 8.0),
          Text('promlert@gmail.com', style: TextStyle(fontSize: 20.0)),
        ],
      ),
    );
  }
}
