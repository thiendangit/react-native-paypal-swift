import { NativeModules } from 'react-native';

console.log({ NativeModules });

const Paypal: {
  requestOneTimePayment: (callback: (result: string) => void) => void
} = NativeModules.Paypal;

export {
  Paypal,
};
