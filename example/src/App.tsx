import * as React from 'react';

import {
  StyleSheet,
  View,
  Text,
  TouchableOpacity,
  ActivityIndicator,
  useColorScheme,
} from 'react-native';
import { Paypal } from 'react-native-paypal-swift';
import { useCallback, useMemo, useState } from 'react';

export default function App() {
  const CLIENT_TOKEN = useMemo<string>(() => 'sandbox_v29bk2j6_7t2b5cz5s3m5gj8v', []);
  const [spinner, setSpinner] = useState<boolean>(false);
  let background = useColorScheme();

  const requestOneTimePayment = useCallback(() => {
    setSpinner(true);
    Paypal.requestOneTimePayment(CLIENT_TOKEN,
      {
        amount: '10',
      },
    ).then(resOneTimePayment => {
      console.log({ resOneTimePayment });
    }).catch(err => {
      console.log(err);
    }).finally(() => setSpinner(false));
  }, []);

  const requestBillingAgreement = useCallback(() => {
    setSpinner(true);
    Paypal.requestBillingAgreement(CLIENT_TOKEN,
      {
        billingAgreementDescription: 'Your agreement description',
        currencyCode: 'GBP',
        localeCode: 'en_GB',
      },
    ).then(resBillingAgreement => {
      console.log({ resBillingAgreement });
    }).catch(err => {
      console.log(err);
    }).finally(() => setSpinner(false));

  }, []);

  const requestDeviceData = useCallback(() => {
    setSpinner(true);
    Paypal.requestDeviceData(CLIENT_TOKEN).then(resDeviceData => {
      alert(`Your correlation id: ${resDeviceData?.deviceData?.correlation_id}`);
      console.log({ resDeviceData });
    }).catch(err => {
      console.log(err);
    }).finally(() => setSpinner(false));
  }, []);

  return (
    <View style={[styles.container, { backgroundColor: background !== 'light' ? 'white' : 'black' }]}>
      {/* Request One Time Payment */}
      <TouchableOpacity style={[styles?.button, {
        backgroundColor: '#2025c9',
      }]}
                        onPress={requestOneTimePayment}>
        <Text style={styles.text}>
          RequestOneTimePayment
        </Text>
      </TouchableOpacity>

      {/* Request Billing Agreement */}
      <TouchableOpacity style={[styles?.button, {
        backgroundColor: '#39cc42',
      }]}
                        onPress={requestBillingAgreement}>
        <Text style={styles.text}>
          requestBillingAgreement
        </Text>
      </TouchableOpacity>

      {/* Request Device Data */}
      <TouchableOpacity style={[styles?.button, {
        backgroundColor: '#ca2a24',
      }]}
                        onPress={requestDeviceData}>
        <Text style={styles.text}>
          requestDeviceData
        </Text>
      </TouchableOpacity>
      {spinner && <View style={{
        position: 'absolute',
        backgroundColor: 'rgb(0,0,0,0.3)',
      }}>
        <ActivityIndicator size={'large'} color={background !== 'light' ? 'black' : 'white'}/>
      </View>}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  button: {
    height: 60,
    marginVertical: 20,
    justifyContent: 'center',
    paddingHorizontal: 20,
    borderRadius: 15,
  },
  text: { color: 'white' },
});
