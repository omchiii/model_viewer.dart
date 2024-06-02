import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:model_viewer_plus/src/model_viewer_plus_web.dart';
import 'package:model_viewer_plus/src/shim/dart_web_fake.dart'
    if (dart.library.js_interop) 'dart:html';

void main() => runApp(const MyApp());

String js = '''
const modelViewerColor = document.querySelector("model-viewer#color");

document.querySelector('#color-controls').addEventListener('click', (event) => {
  const colorString = event.target.dataset.color;
  const [material] = modelViewerColor.model.materials;
  material.pbrMetallicRoughness.setBaseColorFactor(colorString);
});

''';

String html = '''
  <div class="controls" id="color-controls">
    <button data-color="#ff0000">Red</button>
    <button data-color="#00ff00">Green</button>
    <button data-color="#0000ff">Blue</button>
  </div>
''';

NodeValidatorBuilder myNodeValidatorBuilder = defaultNodeValidatorBuilder
  ..allowElement(
    'button',
    attributes: ['data-color'],
    uriPolicy: AllowAllUri(),
  );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Model Viewer')),
        body: ModelViewer(
          id: 'color',
          src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
          alt: 'A 3D model of an astronaut',
          touchAction: TouchAction.panY,
          ar: true,
          orientation: '20deg 0 0',
          relatedJs: js,
          innerModelViewerHtml: html,
          overwriteNodeValidatorBuilder: myNodeValidatorBuilder,
        ),
      ),
    );
  }
}
