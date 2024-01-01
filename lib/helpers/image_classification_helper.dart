import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:my_diet/services/firestore_service.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';
import 'isolate_inference.dart';

class ImageClassificationHelper {
  // static const modelPath =
  //     'assets/models/lite-model_aiy_vision_classifier_food_V1_1.tflite';
  static const modelPath = 'assets/models/foodModels.tflite';
  static const labelsPath = 'assets/models/foodLabels.txt';
  //static const labelsPath = 'assets/models/food_labels.txt';

  // static const modelPath = 'assets/models/EfficientNet_model.tflite';
  // static const labelsPath = 'assets/models/efficientNet_labels.txt';

  late final Interpreter interpreter;
  late final List<String> labels;
  late final IsolateInference isolateInference;
  late Tensor inputTensor;
  late Tensor outputTensor;

  // Load model
  Future<void> _loadModel() async {
    final options = InterpreterOptions();

    // Use XNNPACK Delegate
    if (Platform.isAndroid) {
      options.addDelegate(XNNPackDelegate());
    }

    // Use Metal Delegate
    if (Platform.isIOS) {
      options.addDelegate(GpuDelegate());
    }
    // Load model from assets
    //interpreter = await Interpreter.fromAsset(modelPath, options: options);
    log("Start loading model");
    var model = await FireStoreSerivce().loadModel();
    log("Model ${model.file}");
    interpreter = await Interpreter.fromFile(model.file);

    // Get tensor input shape [1, 224, 224, 3]
    inputTensor = interpreter.getInputTensors().first;
    // Get tensor output shape [1, 1001]
    outputTensor = interpreter.getOutputTensors().first;

    log('Interpreter loaded successfully');
  }

  // Load labels from assets
  Future<void> _loadLabels() async {
    log("Load labels");
    final labelTxt = await rootBundle.loadString(labelsPath);
    labels = labelTxt.split('\n');
  }

  Future<void> initHelper() async {
    _loadLabels();
    _loadModel();
    isolateInference = IsolateInference();
    await isolateInference.start();
  }

  Future<Map<String, double>> _inference(InferenceModel inferenceModel) async {
    ReceivePort responsePort = ReceivePort();
    isolateInference.sendPort
        .send(inferenceModel..responsePort = responsePort.sendPort);
    // get inference result.
    var results = await responsePort.first;
    return results;
  }

  // inference camera frame
  Future<Map<String, double>> inferenceCameraFrame(
      CameraImage cameraImage) async {
    var isolateModel = InferenceModel(cameraImage, null, interpreter.address,
        labels, inputTensor.shape, outputTensor.shape);
    return _inference(isolateModel);
  }

  // inference still image
  Future<Map<String, double>> inferenceImage(Image image) async {
    var isolateModel = InferenceModel(null, image, interpreter.address, labels,
        inputTensor.shape, outputTensor.shape);
    return _inference(isolateModel);
  }

  // Future<List<Map<String, dynamic>>> runInference(Uint8List imageInput) async {
  //   // Perform inference
  //   // var inputs = [inputImageData];
  //   var inputShape = interpreter.getInputTensor(0).shape;
  //   log('Expected Input Shape: $inputShape');
  //   var inputData = imageInput.buffer.asFloat32List();
  //   var inputType = interpreter.getInputTensor(0).type;
  //   log('Expected Input Data Type: $inputType');
  //   var outputShape = interpreter.getOutputTensor(0).shape;
  //   log('Expected Output Shape: $outputShape');
  //   // final imageMatrix = List.generate(
  //   //   imageInput.height,
  //   //   (y) => List.generate(
  //   //     imageInput.width,
  //   //     (x) {
  //   //       final pixel = imageInput.getPixel(x, y);
  //   //       return [pixel.r, pixel.g, pixel.b];
  //   //     },
  //   //   ),
  //   // );

  //   // Set tensor input [1, 224, 224, 3]
  //   var inputs = [inputShape];

  //   var outputs = List.filled(1, Float32List(2));
  //   interpreter.run(inputs, outputs);

  //   // Process the output
  //   var output = outputs[0];
  //   var predictions = output
  //       .asMap()
  //       .entries
  //       .map((entry) => {'index': entry.key, 'label': entry.value})
  //       .toList();

  //   // Sort predictions by confidence
  //   predictions.sort((a, b) => b['label']!.compareTo(a['label']!));

  //   return predictions;
  // }

  Future<void> close() async {
    isolateInference.close();
  }
}
