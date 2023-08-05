import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:labour/src/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:labour/src/app/presentation/controller/locations_bloc/locations_bloc.dart';
import 'package:labour/src/app/presentation/screens/categories_screen/categories_screen.dart';
import 'package:labour/src/app/presentation/screens/home_screen/widget/slider.dart';
import 'package:labour/src/core/presentation/widget/custom_grid_view.dart';
import 'package:labour/src/core/presentation/widget/custom_text_button.dart';
import 'package:labour/src/core/resources/app_assets.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/resources/routes_manager.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarHome(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.all(20.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppStrings.goodMorning.tr()} Maged",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  AppStrings.homeServicesDesc.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(
                  height: 20.h,
                ),
                const LocationWidget(),
                SizedBox(
                  height: 15.h,
                ),
                const CustomSlider(),
                const BodyHomeContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBarHome(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: InkWell(
        onTap: () async {},
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Badge(
            child: Icon(
              Icons.notifications_none,
              size: 40,
            ),
          ),
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppAssets.laborHome,
            height: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Labor',
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationsBloc, LocationsState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.requestState) {
          case RequestState.loading:
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.yellow,
            ));

          ////case RequestState.empty:
          //return const Center(child: CircularProgressIndicator(color: Colors.red,));

          case RequestState.error:
            return const Center(child: CircularProgressIndicator());
          case RequestState.loaded:
          case RequestState.empty:
            return InkWell(
              onTap: () => context.pushNamed(Routes.location),
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(
                    color: const Color(0xFF4B8673),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.only(start: 20.0, top: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        AppAssets.location2,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.yourLocation.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey[300]),
                            ),
                            Text(
                              '${state.location!.city} - ${state.location!.region} - ${state.location!.building}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey[300]),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}

class BodyHomeContent extends StatelessWidget {
  const BodyHomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.ourServices.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 19),
                ),
                CustomTextButton(
                  text: AppStrings.seeAll.tr(),
                  onPressed: () {},
                ),
              ],
            ),
            CustomGridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext ctx, index) => InkWell(
                onTap: () =>
                    context.pushNamed(Routes.serviceScreen, queryParameters: {
                  'name': state.category[index].name,
                  'image': state.category[index].image,
                  'nameAr': state.category[index].nameAr,
                }),
                child: BuildCategoriesWidget(
                  category: state.category[index],
                ),
              ),
              itemCount: state.category.length,
            ),
          ],
        );
      },
    );
  }
}
