import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/image_provider.dart';

class HomeScreen extends ConsumerWidget {
  static const routeName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(imageProvider);
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image.image != null)
              Expanded(
                flex: 3,
                child: Image.file(image.image!),
              ),
            Expanded(
              flex: 3,
              child: RichText(
                text: TextSpan(
                  text: '${image.ticket?.toJson()}',
                  style: textStyle.bodyLarge,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await ref.read(imageProvider.notifier).setImage();
                    },
                    child: const Text('Load Image'),
                  ),
                  FilledButton(
                    onPressed: () async =>
                        await ref.read(imageProvider.notifier).applyVision(),
                    child: const Text('Apply Vision'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
