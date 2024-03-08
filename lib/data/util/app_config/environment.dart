enum Environment { dev, prod }

class AppConfig {
  static Environment environment = Environment.dev;
  static final String devURL =
      'https://staging.api.repore.promptcomputers.io/api/v1/';
  // static final String devURL = dotenv.env['DEV_URL'] ?? '';
  static final String productionURL =
      'https://prod.api.repore.promptcomputers.io/api/v1/';
  // static final String productionURL = dotenv.env['PROD_URL'] ?? '';
  static final String stripeUrl = 'https://api.stripe.com/v1/';
  static final String imgStorageUrl =
      'https://storage.repore.promptcomputers.io/';
  // static final String stripeUrl = dotenv.env['STRIPE_URL'] ?? '';
  static final String stripeTestKey = environment == Environment.prod
      ? 'pk_live_51NsnPDH3aI1kPWD1bmo407B4EGLp6dWfN7Vabs3GIgFrfnL1mPI4rbEH2poQd22oxQ9knCNxUYoMvZZZCzqwPXed00GGFagtwz'
      : 'pk_test_51NsnPDH3aI1kPWD1ACdYWuRM09CDgYzfQKfnBHmJIO2evg8V5Pch5xyfAi2r4Sxe3hzrzjjou2NmbBATGiPgjKZr008T5PSb6R';
  // static final String stripeTestKey = environment == Environment.prod
  //     ? dotenv.env['STRIPE_LIVE'] ?? ''
  //     : dotenv.env['STRIPE_TEST'] ?? '';
  static final coreBaseUrl =
      environment == Environment.prod ? productionURL : devURL;
}

// ACCESSKEYID=AKIAWJKWZKFZZZOVUF7A
// SECRETACCESSKEY=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
// REGION=us-east-1
