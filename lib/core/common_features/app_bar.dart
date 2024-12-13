import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarDesign extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDesign({
    super.key,
    this.title,
    required this.function,
    this.image,
  });
  final String? title;
  final String? image;
  final VoidCallback function;

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: image == null ? Text(title!) : SvgPicture.asset(image!),
      actions: [
        IconButton(
          onPressed: function,
          icon: image == null
              ? const Icon(Icons.home)
              : const Icon(Icons.shopping_cart_outlined),
        ),
      ],
    );
  }
}
