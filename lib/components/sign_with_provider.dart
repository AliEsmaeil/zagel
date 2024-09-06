import 'package:chat/utils/social_icons.dart';
import 'package:flutter/material.dart';

class ProviderSignInList extends StatelessWidget {
  const ProviderSignInList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35,top: 10),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Sign in with Provider',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'Unique1',
                onPressed: () {},
                child: Icon(Social.google, color: Colors.red,),
                backgroundColor: Colors.white,
              ),
              FloatingActionButton(
                heroTag: 'Unique2',
                onPressed: () {},
                child: Icon(Social.facebook,color: Colors.blue),
                backgroundColor: Colors.white,
              ),
              FloatingActionButton(
                heroTag: 'Unique3',
                onPressed: () {},
                child: Icon(Social.twitter , color: Colors.blue,),
                backgroundColor: Colors.white,
              ),
              FloatingActionButton(
                key: UniqueKey(),
                heroTag: 'Unique4',
                onPressed: () {},
                child: Icon(Social.amazon, color: Colors.grey.shade400),
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
