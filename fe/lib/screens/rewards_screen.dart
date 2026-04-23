import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/reward_provider.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RewardProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Rewards')),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.rewards.length,
              itemBuilder: (context, index) {
                final r = provider.rewards[index];
                return ListTile(
                  title: Text(r.title),
                  subtitle: Text('${r.points} points'),
                  trailing: ElevatedButton(
                    child: const Text('Claim'),
                    onPressed: () async {
                      final ok = await provider.claim(r.id);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? 'Claimed' : 'Failed')));
                    },
                  ),
                );
              },
            ),
    );
  }
}
