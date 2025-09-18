import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../router/routes.dart';
import '../../../theme/color_scheme.dart';
import '../widgets/pageview_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final ValueNotifier<int> currentPage = ValueNotifier<int>(0);

    void goToNextPage() {
      if (currentPage.value < 3) {
        currentPage.value++;
        pageController.animateToPage(
          currentPage.value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }

    return Scaffold(
      backgroundColor: colorSchemeLight.surface,
      appBar: AppBar(
        backgroundColor: colorSchemeLight.surface,
        automaticallyImplyLeading: false,
        leading: ValueListenableBuilder<int>(
          valueListenable: currentPage,
          builder: (context, value, child) {
            return value == 0
                ? const SizedBox.shrink() // Invisible widget instead of null
                : IconButton(
                    onPressed: () {
                      // Go back to the previous page
                      if (currentPage.value > 0) {
                        currentPage.value--;
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back_outlined,
                      color: colorScheme(context).onSurface,
                    ),
                  );
          },
        ),
        actions: [
          const Spacer(),
          SelectableText(
            "Skip",
            onTap: () {
              context.pushReplacementNamed(AppRoute.loginPage);
            },
            style: textTheme(context).bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColor.boardingScreenText,
                ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                currentPage.value = index;
              },
              children: buildPages(context),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 20),
              SmoothPageIndicator(
                controller: pageController,
                count: 4,
                effect: ExpandingDotsEffect(
                  spacing: 8,
                  dotHeight: 10,
                  dotWidth: 10,
                  dotColor: colorSchemeLight.outline,
                  activeDotColor: colorScheme(context).primary,
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 60,
                child: ValueListenableBuilder<int>(
                  valueListenable: currentPage,
                  builder: (context, value, child) {
                    return value == 3
                        ? SizedBox(
                            height: 50,
                            width: 150,
                            child: CustomElevatedButton(
                              onPressed: () {
                                context
                                    .pushReplacementNamed(AppRoute.loginPage);
                              },
                              text: 'Get Started',
                            ),
                          )
                        : CircleAvatar(
                            radius: 30,
                            backgroundColor: colorScheme(context).secondary,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_forward,
                                size: 30,
                                color: colorScheme(context).onSecondary,
                              ),
                              onPressed: goToNextPage,
                            ),
                          );
                  },
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
