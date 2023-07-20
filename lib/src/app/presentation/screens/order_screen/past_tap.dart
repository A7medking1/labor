
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labour/src/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:labour/src/app/presentation/screens/order_screen/on_going_tap.dart';

class PastTap extends StatefulWidget {
  const PastTap({Key? key}) : super(key: key);

  @override
  State<PastTap> createState() => _PastTapState();
}

class _PastTapState extends State<PastTap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final past = state.services
            .where((element) =>
        (element.serviceStatus == 'canceled') ||
            element.serviceStatus == 'done')
            .toList();

        if(past.isEmpty){
          return const EmptyServices();
        }
        switch (state.servicesReqState) {
          case RequestStatus.empty:
            return const EmptyServices();
          case RequestStatus.loading:
          case RequestStatus.error:
            return const Center(child: CircularProgressIndicator());
          case RequestStatus.success:
            return ListView.builder(
              itemBuilder: (_, index) {
                return OnGoingBuildCard(
                  service: past[index],
                );
              },
              itemCount: past.length,
            );
        }
      },
    );
  }
}
