import 'package:go_router/go_router.dart';
import 'package:labour/src/app/domain/entity/company.dart';
import 'package:labour/src/app/presentation/screens/compony_desc_screen/company_screen.dart';
import 'package:labour/src/app/presentation/screens/contact_us_screen/contact_us_screen.dart';
import 'package:labour/src/app/presentation/screens/create_service_screen/create_service_screen.dart';
import 'package:labour/src/app/presentation/screens/locations_screen/add_locations_screen/add_loaction_screen.dart';
import 'package:labour/src/app/presentation/screens/locations_screen/locations_screen/locations_screen.dart';
import 'package:labour/src/app/presentation/screens/profile_screen/edit_screen/edit_screen.dart';
import 'package:labour/src/auth/presentation/screens/login/login_screen.dart';
import 'package:labour/src/auth/presentation/screens/sign_up/sign_up_screen.dart';
import 'package:labour/src/auth/presentation/screens/verfiy_sent_otp_screen.dart';
import 'package:labour/src/core/presentation/screen/main_home_screen.dart';
import 'package:labour/src/on_boarding/presentation/screen/onBoarding_lang_screen/onBoarding_lang_screen.dart';
import 'package:labour/src/on_boarding/presentation/screen/on_boarding_screen.dart';
import 'package:labour/src/splash/splash_screen.dart';

class Routes {
  Routes._();

  static const splash = '/';
  static const onBoarding = 'onBoarding';
  static const onBoardingLang = 'onBoardingLang';
  static const login = 'login';
  static const signUp = 'signUp';
  static const homeScreen = 'homeScreen';
  static const editScreen = 'editScreen';
  static const serviceScreen = 'serviceScreen';
  static const location = 'location';
  static const addLocation = 'add_location';
  static const verifyScreen = 'verifyScreen';
  static const company = 'company';
  static const contactUs = 'contact_us';
}

class RouterPath {
  RouterPath._();

  static const splash = '/';
  static const onBoarding = '/onBoarding';
  static const onBoardingLang = '/onBoardingLang';
  static const login = '/login';
  static const signUp = '/signUp';
  static const homeScreen = '/homeScreen';
  static const editScreen = '/editScreen';
  static const serviceScreen = '/serviceScreen';
  static const location = '/location';
  static const addLocation = '/add_location';
  static const verifyScreen = '/verifyScreen';
  static const company = '/company';
  static const contactUs = '/contact_us';
}

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: Routes.splash,
        path: RouterPath.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: Routes.onBoarding,
        path: RouterPath.onBoarding,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        name: Routes.onBoardingLang,
        path: RouterPath.onBoardingLang,
        builder: (context, state) => const OnBoardingLangScreen(),
      ),
      GoRoute(
        name: Routes.login,
        path: RouterPath.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: Routes.signUp,
        path: RouterPath.signUp,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        name: Routes.homeScreen,
        path: RouterPath.homeScreen,
        builder: (context, state) => const AppLayOutScreen(),
      ),
      GoRoute(
        name: Routes.location,
        path: RouterPath.location,
        builder: (context, state) => const LocationsScreen(),
      ),
      GoRoute(
        name: Routes.addLocation,
        path: RouterPath.addLocation,
        builder: (context, state) => const AddLocationScreen(),
      ),
      GoRoute(
        name: Routes.editScreen,
        path: RouterPath.editScreen,
        builder: (context, state) => const EditScreen(),
      ),
      GoRoute(
        name: Routes.contactUs,
        path: RouterPath.contactUs,
        builder: (context, state) => const ContactUsScreen(),
      ),
      GoRoute(
        name: Routes.verifyScreen,
        path: RouterPath.verifyScreen,
        builder: (context, state) => VerifySentOtpScreen(
          verifyId: state.queryParameters['verify_id']!,
          phoneNumber: state.queryParameters['phone_number']!,
        ),
      ),
      GoRoute(
        name: Routes.serviceScreen,
        path: RouterPath.serviceScreen,
        builder: (context, state) => CreateServiceScreen(
          image: state.queryParameters['image']!,
          name: state.queryParameters['name']!,
          nameAr: state.queryParameters['nameAr']!,
        ),
      ),
      GoRoute(
        name: Routes.company,
        path: RouterPath.company,
        builder: (context, state) => CompanyScreen(
          company: state.extra as Company,
        ),
      ),
    ],
  );
}
