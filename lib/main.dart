import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

///TODO: CUstom snack bar across

///TODO: Otp screen naivagting again when resending otp, might ask golden to provide resend otp

///TODO:Look for a package phone number to use, tried the 2 package to see which one suit my purpose most
///TODO:Use gorouter redirection for auto login
///TODO: Create something went wrong widget
///TODO: Used David code to customize error message
///TODO: Create not network or internet connection widget and how to detect it. Test bu switching off the internet when fetching
////TODO: Access the notification service with provider
///TODO: Test the route navigation of push notification
///TODO: Update invoice pdf UI

// cchPp_BvSWaTkHQ7ZrTPGG:APA91bHLfyo3-1seGuky7ASEFXKVEdAMuz-Tb1hC-R9nADTa3EUCeoE-SbK3AyV1NzwB0KSpwj5DCcXwYUr9rliuI_ktefTrirQHotSPrZEm3lTRingTBjfKjUNps1va51fnm1998S-y
///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  log('A Background message : ${message.messageId}');
  log('A Background message Data : ${message.data}');
  log('A Background message routeName : ${message.data['routeName']}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'high_importance_channel',
  description: 'Repore',
  importance: Importance.max,
  playSound: true,
);
// A Foreground message Data : {time_to_live: 3600, ticketID: 199000, routeName: ticket}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // await dotenv.load(fileName: '.env');
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ///Set to prod when pushing to store for production
  await initializeCore(environment: Environment.dev);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  Stripe.publishableKey = AppConfig.stripeTestKey;
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  actionOnMessage(BuildContext context, RemoteMessage message) {
    final route = message.data['routeName'];
    if (route == "ticket") {
      //TODO: Remove refremce, ask him to return subject
      context.pushNamed(
        AppRoute.viewTicketScreen.name,
        queryParams: {
          'id': message.data['ticketID'],
          'ref': '',
          'title': '',
        },
      );
    }
  }

  ///TODO: Move into the notification service file
  void requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        Console.print('User granted ios notification  permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        Console.print('User granted provisional ios notification permission');
      } else {
        Console.print(
            'User declined or has not accepted ios notification permission');
      }
    }

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      FlutterNativeSplash.remove();
    });
    LocalNotificationService.initialize(context);
    requestNotificationPermission();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        actionOnMessage(context, message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        final route = message.data['routeName'];
        if (route == "ticket") {
          //TODO: Remove refremce, ask him to return subject
          context.pushNamed(
            AppRoute.viewTicketScreen.name,
            queryParams: {
              'id': message.data['ticketID'],
              'ref': '',
              'title': '',
            },
          );
        }
      }
    });

    ///Foregroundnotification, when the app is currently running
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        RemoteNotification notification = message.notification!;
        AndroidNotification? android = message.notification?.android;
        log('A Foreground message routeName : ${message.data['routeName']}');
        // AndroidNotification android = message.notification!.android!;
        if (message.notification != null) {
          final route = message.data['routeName'];
          if (route == "ticket") {
            //TODO: Remove refremce, ask him to return subject
            context.pushNamed(
              AppRoute.viewTicketScreen.name,
              queryParams: {
                'id': message.data['ticketID'],
                'ref': '',
                'title': '',
              },
            );
          }
        }

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              // color: Colors.blue,
              playSound: true,
              icon: android!.smallIcon,
              // icon: '@mipmap/ic_launcher',
              importance: Importance.max,
              priority: Priority.high,
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
        );
      },
    );

    // Future.delayed(const Duration(milliseconds: 3000), () async {
    //   FlutterNativeSplash.remove();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,
          title: 'Repore',
          theme: ThemeData(
            textTheme: GoogleFonts.interTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: AppBarTheme(
              // iconTheme: IconThemeData(color: Colors.black),
              // color: Colors.deepPurpleAccent,
              foregroundColor: AppColors.primaryColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                //<-- SEE HERE
                // Status bar color
                statusBarColor: AppColors.primaryColor,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
            ),

            // bottomSheetTheme: BottomSheetThemeData(
            //   modalBackgroundColor: AppColors.primaryTextColor.withOpacity(0.7),
            // ),
            // textTheme: GoogleFonts.outfitTextTheme(
            //   Theme.of(context).textTheme,
            // ),
          ),

          // home: const OnBoardingScreen(),
        );
      },
    );
  }
}
