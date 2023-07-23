import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labour/src/app/data/model/comment_entity.dart';
import 'package:labour/src/app/domain/entity/comment.dart';
import 'package:labour/src/app/domain/entity/company.dart';
import 'package:labour/src/app/domain/use_cases/set_comment_to_company_useCase.dart';
import 'package:labour/src/app/domain/use_cases/set_rating_to_company_useCase.dart';
import 'package:labour/src/app/presentation/controller/company_bloc/company_bloc.dart';
import 'package:labour/src/app/presentation/controller/home_bloc/home_bloc.dart';
import 'package:labour/src/app/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:labour/src/core/format_date.dart';
import 'package:labour/src/core/presentation/widget/cached_image_network.dart';
import 'package:labour/src/core/presentation/widget/custom_button.dart';
import 'package:labour/src/core/presentation/widget/custom_loading.dart';
import 'package:labour/src/core/presentation/widget/custom_text_button.dart';
import 'package:labour/src/core/presentation/widget/custom_text_formField.dart';
import 'package:labour/src/core/resources/app_strings.dart';
import 'package:labour/src/core/services_locator/services_locator.dart';
import 'package:labour/src/core/string_language_helper.dart';

class CompanyScreen extends StatefulWidget {
  final Company company;

  const CompanyScreen({Key? key, required this.company}) : super(key: key);

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(GetCurrentUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CompanyBloc>()
        ..add(GetCommentEvent(widget.company.uid))
        ..add(GetRatingEvent(widget.company.uid)),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.company.tr()),
          ),
          body: _CompanyBody(
            company: widget.company,
          ),
        ),
      ),
    );
  }
}

class _CompanyBody extends StatelessWidget {
  final Company company;

  const _CompanyBody({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
          bottom: 50, start: 10, end: 10, top: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoCompanyWidget(
              company: company,
            ),
            const SizedBox(
              height: 15,
            ),
            const CommentCompanyWidget(),
            const SizedBox(
              height: 20,
            ),
            CommentButtonAndForm(
              companyId: company.uid,
            ),
          ],
        ),
      ),
    );
  }
}

class CommentButtonAndForm extends StatefulWidget {
  final String companyId;

  const CommentButtonAndForm({
    super.key,
    required this.companyId,
  });

  @override
  State<CommentButtonAndForm> createState() => _CommentButtonAndFormState();
}

class _CommentButtonAndFormState extends State<CommentButtonAndForm> {
  final TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyBloc, CompanyState>(
      listener: (context, state) {
        if (state.setCommentStatus == RequestStatus.loading) {
          OverlayLoadingProgress.start(context);
        }
        if (state.setCommentStatus == RequestStatus.success) {
          OverlayLoadingProgress.stop();
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              Card(
                child: CustomTextFormField(
                  controller: controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'empty Form';
                    }
                    return null;
                  },
                  title: AppStrings.add_comment.tr(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    final bloc = context.read<ProfileBloc>().state.user!;
                    SetCommentToCompanyParameters parameters =
                        SetCommentToCompanyParameters(
                      commentModel: CommentModel(
                        userPic: bloc.image!,
                        userName: bloc.name,
                        dateTime: DateTime.now().toString(),
                        commentDisc: controller.text,
                      ),
                      companyUid: widget.companyId,
                    );
                    context
                        .read<CompanyBloc>()
                        .add(SetCommentEvent(parameters));
                    context
                        .read<CompanyBloc>()
                        .add(GetCommentEvent(widget.companyId));
                  }
                },
                text: AppStrings.add_comment.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CommentCompanyWidget extends StatelessWidget {
  const CommentCompanyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.comments.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(
              height: 15,
            ),
            BlocBuilder<CompanyBloc, CompanyState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.comments.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return BuildComment(
                      comment: state.comments[index],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BuildComment extends StatelessWidget {
  final CommentEntity comment;

  const BuildComment({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                child: CachedImages(
                  imageUrl: comment.userPic,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.userName,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    formatDateTime(comment.dateTime),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            comment.commentDisc,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.w300),
          ),
          const Divider(
            thickness: 3,
          ),
        ],
      ),
    );
  }
}

class InfoCompanyWidget extends StatefulWidget {
  final Company company;

  const InfoCompanyWidget({
    super.key,
    required this.company,
  });

  @override
  State<InfoCompanyWidget> createState() => _InfoCompanyWidgetState();
}

class _InfoCompanyWidgetState extends State<InfoCompanyWidget> {
  double rating = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyBloc, CompanyState>(
      listener: (context, state) {
        if (state.setRatingStatus == RequestStatus.loading) {
          OverlayLoadingProgress.start(context);
        }
        if (state.setRatingStatus == RequestStatus.success) {
          OverlayLoadingProgress.stop();
        }

        if (state.setRatingStatus == RequestStatus.error) {
          OverlayLoadingProgress.stop();
          print('error');
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 480.h,
          child: Card(
            elevation: 10,
            child: Container(
              padding: const EdgeInsetsDirectional.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 70.r,
                    backgroundColor: Colors.transparent,
                    child: CachedImages(
                      imageUrl: widget.company.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    stringLang(
                      widget.company.name,
                      widget.company.nameAr,
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow.shade900,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        state.rating.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    stringLang(widget.company.desc, widget.company.descAr),
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    AppStrings.add_your_rate.tr(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        initialRating: rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        tapOnlyMode: true,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rate) async {
                          print(rating);
                          rating = rate;
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        width: 40.w,
                      ),
                      Text(
                        rating.toString(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  CustomTextButton(
                    onPressed: () async {
                      context.read<CompanyBloc>().add(SetRatingToCompanyEvent(
                            SetRatingToCompanyParameters(
                              rating: rating,
                              companyUid: widget.company.uid,
                            ),
                          ));

                      context
                          .read<CompanyBloc>()
                          .add(GetRatingEvent(widget.company.uid));
                    },
                    text: 'update Rate',
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/*    final coll = FirebaseFirestore.instance
                          .collection('company')
                          .doc(
                            widget.company.uid,
                          )
                          .collection('rate');*/

/*final fire = await coll
                      .doc('cN0CpcmI0dY1UV4uznpctbrnX3p2')
                      .set({
                    'rate': rating,
                  });*/

/*  final data = await coll.get();

                      double result = data.docs
                              .map((m) => m['rate'])
                              .reduce((a, b) => a + b) /
                          data.size;
                      print(result.toStringAsFixed(1));

                      /// is rating ;
                      final isRating = await FirebaseFirestore.instance
                          .collection('company')
                          .doc('FXpAMngNRltIqPxKuK6J')
                          .collection('rate')
                          .doc('laYGYgV7kPbdMZ0j0hs5jHdV9vn2')
                          .get();

                      if (isRating.exists) {
                        print('yes');
                      } else {
                        print('not rating');
                      }
                      print(isRating.data());*/
