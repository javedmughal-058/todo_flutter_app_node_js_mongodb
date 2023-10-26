import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Size size;
  const CustomButton({super.key, required this.title, required this.size});

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height: orientation == Orientation.portrait ? size.width * 0.13 : size.height * 0.13,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              end: Alignment.topRight,
              begin: Alignment.topLeft,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.8),
                Theme.of(context).colorScheme.inversePrimary,
              ])),
      child: Center(
        child: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
