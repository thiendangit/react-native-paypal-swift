import * as React from 'react';

import { StyleSheet, View, Text, TouchableOpacity } from 'react-native';
import { Paypal } from 'react-native-paypal-swift';

export default function App() {

  return (
    <View style={styles.container}>
      <TouchableOpacity onPress={() => {
        Paypal.requestOneTimePayment((result: string) => console.log({ result }));
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
