import * as React from 'react';

import { StyleSheet, View, Text, TouchableOpacity } from 'react-native';
import { Paypal } from 'react-native-paypal-swift';
import { useMemo } from 'react';

export default function App() {

  const CLIENT_TOKEN = useMemo(() => 'sandbox_v29bk2j6_7t2b5cz5s3m5gj8v', []);

  return (
    <View style={styles.container}>
      <TouchableOpacity onPress={() => {
        Paypal.requestOneTimePayment(CLIENT_TOKEN,
          {
            amount: '10',
          },
        ).then(r => {
          console.log({r});
        }).catch(e => {
          console.log(e);
        });
      }}>
        <Text>
          RequestOneTimePayment
        </Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
