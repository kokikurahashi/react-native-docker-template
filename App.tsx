import { StatusBar } from 'expo-status-bar';
import { useState } from 'react';
import { Pressable, StyleSheet, Text, View } from 'react-native';

export default function App() {
  const [count, setCount] = useState<number>(0);

  return (
    <View style={styles.container}>
      <Text style={styles.title}>React Native × TypeScript</Text>
      <Text style={styles.count}>{count}</Text>
      <Pressable style={styles.button} onPress={() => setCount((c) => c + 1)}>
        <Text style={styles.buttonText}>+1</Text>
      </Pressable>
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 16,
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  count: {
    fontSize: 48,
  },
  button: {
    backgroundColor: '#2563eb',
    paddingHorizontal: 24,
    paddingVertical: 12,
    borderRadius: 8,
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
});
