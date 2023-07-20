import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour/src/app/domain/entity/category.dart';
import 'package:labour/src/app/presentation/controller/category_bloc/category_bloc.dart';
import 'package:labour/src/core/presentation/widget/cached_image_network.dart';
import 'package:labour/src/core/presentation/widget/custom_grid_view.dart';
import 'package:labour/src/core/resources/app_colors.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/string_language_helper.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.category.tr()),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          switch (state.requestStatus) {
            case RequestStatus.error:
            case RequestStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case RequestStatus.success:
              return Padding(
                padding: const EdgeInsets.all(35.0),
                child: CustomGridView(
                  itemCount: state.category.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return BuildCategoriesWidget(
                      category: state.category[index],
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}

class BuildCategoriesWidget extends StatelessWidget {
  final Category? category;

  const BuildCategoriesWidget({
    super.key,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(15),),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            //     color: Colors.amber,
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                fit: StackFit.loose,
                alignment: AlignmentDirectional.centerStart,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.yellowLight,
                  ),
                  CachedImages(
                    height: 100,
                    imageUrl: category!.image,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              Text(
                stringLang(category!.name, category!.nameAr),
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 18.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
