declare module 'react-native-paypal-swift' {

  type IntentType = 'order' | 'sale'
  type LandingPageType = 'login' | 'billing'
  type UserActionType = 'commit' | ''

  interface RequestOneTimePaymentType {
    amount?: string,
    billingAgreementDescription?: string,
    currencyCode?: string,
    displayName?: string,
    intent?: IntentType,
    landingPageType?: LandingPageType,
    localeCode?: string,
    offerCredit?: boolean,
    shippingAddressOverride?: {
      streetAddress: string,
      extendedAddress: string,
      locality: string,
      region: string,
      postalCode: string,
      countryCodeAlpha2: string,
      recipientName: string,
      shippingAddressOverride: string,
    },
    isShippingAddressRequired?: boolean,
    userAction?: UserActionType
  }

  export type Paypal = {
    requestOneTimePayment: (clientToken: string, options: RequestOneTimePaymentType) => Promise<any>
  };
}
