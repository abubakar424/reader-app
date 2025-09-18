import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/utils/validation.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../provider/expanded_provider.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  bool isExpanded = false;
  final feedBackController = TextEditingController();
  List<String> title = [
    'New Quizzes',
    'Multiple Question',
  ];

  bool dialogBox = false;
  void showDialogBox() {
    setState(() {
      dialogBox = true;
    });
    // Start a timer to hide the dialog box after 5 seconds
    Timer(const Duration(seconds: 2), () {
      setState(() {
        dialogBox = false;
      });
    });
  }

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final expandProvider = Provider.of<ExpandProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback',style: textTheme(context).headlineMedium!.copyWith(fontWeight: FontWeight.w600),),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _key,
            child: Column(
          children: [
            ListView.builder(
              itemCount: expandProvider.isExpandedList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.appgrey.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(title[index],style: textTheme(context).labelLarge?.copyWith(fontWeight: FontWeight.w700),),
                            ),
                            GestureDetector(
                                onTap: (){
                                  expandProvider.toggleExpand(index);
                                },
                                child:  Icon(expandProvider.isExpandedList[index] ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up_rounded,size: 30,color: colorScheme(context).primary.withOpacity(0.5),))
                          ],
                        ),
                      ),
                    ),
                    expandProvider.isExpandedList[index]
                        ?
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.appgrey.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(9)
                      ),
                      child: const Column(
                        children: [
                          Text('How would you rate the shopping experience?'),
                          Text('How would you rate the shopping experience?'),
                          Text('How would you rate the shopping experience?'),
                          Text('How would you rate the shopping experience?'),
                        ],
                      ),
                    )  : const SizedBox.shrink(),
                  ],
                );
              },),
            const SizedBox(height: 15,),
            CustomTextFormField(
              controller: feedBackController,
              autoValidateMode: AutovalidateMode.disabled,
              hint: 'Get feedback',
              validator: (value) => Validation.fieldValidation(value, 'feedback'),
              fillColor: Colors.transparent,
              borderColor: AppColor.greyColor.withOpacity(0.2),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: (){

                    if(_key.currentState?.validate() ?? false){
                      showDialogBox();
                      feedBackController.clear();
                    }
                  },
                  child: Container(
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(color: colorScheme(context).primary.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: Center(child: Text('Submit',style: textTheme(context).labelMedium?.copyWith(letterSpacing: 0.5),)),
                  ),
                ),
              ),
              suffixConstraint: const BoxConstraints(
                minWidth: 60,
                minHeight: 30,
              ),
              focusBorderColor: AppColor.greyColor.withOpacity(0.2),
            ),
            const SizedBox(height: 30,),
            dialogBox ? Container(
              height: 60,
              decoration: BoxDecoration(
                color: colorScheme(context).primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme(context).onSurface),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Thanks for asking Question',style: textTheme(context).labelLarge?.copyWith(letterSpacing: 0,color: colorScheme(context).onSurface.withOpacity(0.6)),),
                  const SizedBox(width: 8,),
                  Icon(Icons.thumb_up,color: colorScheme(context).primary.withOpacity(0.7),)
                ],
              ),
            ) : Container(),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                height: 44,
                width: 170,
                decoration: BoxDecoration(
                    border: Border.all(color: colorScheme(context).onSurface),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Center(child: Text('Cancel',style: textTheme(context).labelLarge?.copyWith(letterSpacing: 0),)),
              ),
            )
          ],
        )),
      ),
    );
  }
}
