import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labour/src/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:labour/src/app/presentation/screens/order_screen/on_going_tap.dart';
import 'package:labour/src/app/presentation/screens/order_screen/past_tap.dart';
import 'package:labour/src/core/presentation/widget/circle_tab_indicator.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/language_manager.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetServicesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.history.tr()),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  late TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          unselectedLabelColor: Colors.grey,
          labelColor: AppColors.black,
          labelStyle: Theme.of(context).textTheme.titleSmall,
          indicator: CircleTabIndicator(color: AppColors.green, radius: 5),
          tabs: [
            Tab(
              text: AppStrings.ongoing.tr(),
            ),
            Tab(
              text: AppStrings.past.tr(),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const [
              OnGoingTap(),
              PastTap(),
            ],
          ),
        ),
      ],
    );
  }
}


class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Divider(
          color: Colors.grey[200],
          thickness: 3,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
