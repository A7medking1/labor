import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTileWidget extends StatelessWidget {
  final String? title;
  final String? body;
  final String? leadingIcon;
  final Widget? trailingWidget;
  final void Function()? onTap;

  const CustomListTileWidget(
      {super.key,
        this.body,
        this.onTap,
        this.leadingIcon,
        this.trailingWidget,
        this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(leadingIcon!),
      onTap: onTap,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title!,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Text(
            body!,
            style:
            Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13),
          ),
        ],
      ),
      trailing: trailingWidget ?? const Icon(Icons.arrow_forward_ios),
    );
  }
}
