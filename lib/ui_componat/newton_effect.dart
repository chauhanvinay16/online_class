import 'package:flutter/material.dart';
import 'package:newton_particles/newton_particles.dart';

class NewtonScreen extends StatefulWidget {
  const NewtonScreen({super.key});

  @override
  State<NewtonScreen> createState() => _NewtonScreenState();
}

class _NewtonScreenState extends State<NewtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Newtom'),
      ),
      body: Newton(
        // Add any kind of effects to your UI
        // For example:
        activeEffects: [
          RainEffect(
            particleConfiguration: ParticleConfiguration(
              shape: CircleShape(),
              size: const Size(5, 5),
              color: const SingleParticleColor(color: Colors.black),
            ),
            effectConfiguration: const EffectConfiguration(),
          )
        ],
      ),
    );
  }
}
