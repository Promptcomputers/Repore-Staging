import 'package:go_router/go_router.dart';
import 'package:repore/lib.dart';
import 'package:repore/src/features/bottom_nav_bar.dart';

enum AppRoute {
  auth,
  login,
  splash,
  autoLogin,
  register,
  registerConfirm,
  forgotPassword,
  changePassword,
  bottomNavBar,
  otpScreen,
  viewTicketScreen,
  invoiceScreen,
  invoicePreviewScreen,
  invoicePaymentScreen,
  invoicePaymentSuccessScreen,
  editProfileScreen,
  changePasswordScreen,
  paymentMethodScreen,
  completeProfileScreen,
  registerOtpScreen,
  createPinScreen,
  confirmCreatePinScreen,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    ///Trying to see if splash screen will show up beforr auth perform
    GoRoute(
      path: '/',
      name: AppRoute.splash.name,
      builder: (context, state) => const SplashScreen(),

      // path: '/',
      // name: AppRoute.auth.name,
      // builder: (context, state) => const AuthHomePage(),
      routes: [
        GoRoute(
          path: 'auth',
          name: AppRoute.auth.name,
          builder: (context, state) {
            return AuthHomePage();
            // return MainScreen(menuScreenContext: context);
          },
        ),
        GoRoute(
          path: 'bottomNavBar',
          name: AppRoute.bottomNavBar.name,
          builder: (context, state) {
            return BottomNavBar();
            // return MainScreen(menuScreenContext: context);
          },
        ),
        GoRoute(
          path: 'register',
          name: AppRoute.register.name,
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: 'login',
          name: AppRoute.login.name,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: 'autoLogin',
          name: AppRoute.autoLogin.name,
          builder: (context, state) {
            final email = state.queryParams['email']!;
            final firstName = state.queryParams['firstName']!;
            return AutoLoginScreen(email: email, firstName: firstName);
          },
        ),
        GoRoute(
          path: 'createPinScreen/:isFromComplete',
          name: AppRoute.createPinScreen.name,
          builder: (context, state) {
            ///1: true, 0:false
            final isFromComplete = state.params['isFromComplete']!;
            return CreatePinScreen(
              isFromComplete: isFromComplete,
            );
          },
        ),
        GoRoute(
          path: 'confirmCreatePinScreen/:pin',
          name: AppRoute.confirmCreatePinScreen.name,
          builder: (context, state) {
            final pin = state.params['pin']!;
            return ConfirmCreatePinScreen(
              pin: pin,
            );
          },
        ),
        GoRoute(
          path: 'forgotPassword',
          name: AppRoute.forgotPassword.name,
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
            path: 'changePassword/:id',
            name: AppRoute.changePassword.name,
            builder: (context, state) {
              final id = state.params['id']!;
              return ChangeForgotPasswordScreen(id: id);
            }),
        GoRoute(
          path: 'otpScreen',
          name: AppRoute.otpScreen.name,
          builder: (context, state) {
            final email = state.queryParams['email']!;
            final id = state.queryParams['id']!;
            return OtpScreen(email: email, id: id);
          },
        ),
        GoRoute(
          path: 'registerOtpScreen/:email',
          name: AppRoute.registerOtpScreen.name,
          builder: (context, state) {
            final email = state.params['email']!;

            return RegisterOtpScreen(email: email);
          },
        ),
        GoRoute(
          path: 'viewTicketScreen',
          name: AppRoute.viewTicketScreen.name,
          builder: (context, state) {
            final id = state.queryParams['id']!;
            final ref = state.queryParams['ref']!;
            final title = state.queryParams['title']!;
            return ViewTicketScreen(
              id: id,
              ref: ref,
              title: title,
            );
          },
        ),
        GoRoute(
          path: 'invoiceScreen/:ticketId',
          name: AppRoute.invoiceScreen.name,
          builder: (context, state) {
            final ticketId = state.params['ticketId']!;
            return InvoiceScreen(
              ticketId: ticketId,
            );
          },
        ),
        GoRoute(
          path: 'invoicePreviewScreen',
          name: AppRoute.invoicePreviewScreen.name,
          builder: (context, state) {
            final invoiceId = state.queryParams['invoiceId']!;
            final invoiceRef = state.queryParams['invoiceRef']!;
            final subject = state.queryParams['subject']!;
            return InvoicePreviewScreen(
              invoiceId: invoiceId,
              invoiceRef: invoiceRef,
              subject: subject,
            );
          },
        ),
        // GoRoute(
        //   path: 'invoicePreviewScreen',
        //   name: AppRoute.invoicePreviewScreen.name,
        //   builder: (context, state) {
        //     final invoiceId = state.queryParams['invoiceId']!;
        //     final invoiceRef = state.queryParams['invoiceRef']!;
        //     final subject = state.queryParams['subject']!;
        //     return InvoicePreviewScreen(
        //       invoiceId: invoiceId,
        //       invoiceRef: invoiceRef,
        //       subject: subject,
        //     );
        //   },
        // ),
        GoRoute(
          path: 'invoicePaymentScreen',
          name: AppRoute.invoicePaymentScreen.name,
          builder: (context, state) {
            final invoiceId = state.queryParams['invoiceId']!;
            final amount = state.queryParams['amount']!;
            final dueDate = state.queryParams['dueDate']!;
            return InvoicePaymentScreen(
              invoiceId: invoiceId,
              amount: amount,
              dueDate: dueDate,
            );
            // pageBuilder: (context, state) {
            //   final invoiceId = state.queryParams['invoiceId']!;
            //   final amount = state.queryParams['amount']!;
            //   final dueDate = state.queryParams['dueDate']!;

            // return CustomTransitionPage(
            //   key: state.pageKey,
            //   child: InvoicePaymentScreen(
            //     invoiceId: invoiceId,
            //     amount: amount,
            //     dueDate: dueDate,
            //   ),
            //   transitionsBuilder:
            //       (context, animation, secondaryAnimation, child) {
            //     // Change the opacity of the screen using a Curve based on the the animation's
            //     // value
            //     return FadeTransition(
            //       opacity: CurveTween(curve: Curves.easeInOutCirc)
            //           .animate(animation),
            //       child: child,
            //     );
            //   },
            // );
          },
        ),
        GoRoute(
          path: 'invoicePaymentSuccessScreen',
          name: AppRoute.invoicePaymentSuccessScreen.name,
          builder: (context, state) {
            return InvoicePaymentSuccessScreen();
          },
        ),
        GoRoute(
          path: 'editProfileScreen',
          name: AppRoute.editProfileScreen.name,
          builder: (context, state) {
            return const EditProfileScreen();
          },
        ),
        GoRoute(
          path: 'changePasswordScreen',
          name: AppRoute.changePasswordScreen.name,
          builder: (context, state) {
            return const ChangePasswordScreen();
          },
        ),
        GoRoute(
          path: 'paymentMethodScreen',
          name: AppRoute.paymentMethodScreen.name,
          builder: (context, state) {
            return const PaymentMethodScreen();
          },
        ),
        GoRoute(
          path: 'completeProfileScreen',
          name: AppRoute.completeProfileScreen.name,
          builder: (context, state) {
            return const CompleteProfileScreen();
          },
        ),
      ],
    ),
  ],
);
