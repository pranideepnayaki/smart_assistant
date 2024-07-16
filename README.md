# Smart Assistant Flutter App

## Overview

The Smart Assistant Flutter App is a user-friendly application designed to provide instant translations from English to German using an AI language model. This app leverages the T5 model hosted on Hugging Face to translate user inputs, providing a seamless and interactive user experience.

## Features

- **Real-Time AI Translations**: Users can type their queries in English, and the app will fetch and display the translated response in German in real-time.
- **User-Friendly Interface**: The app features a clean and intuitive interface with a central input field, submit button, and display area for responses.
- **Error Handling**: The app is equipped with robust error handling mechanisms to manage different types of errors gracefully, ensuring a smooth user experience.
- **Mobile-Friendly Design**: Built with Flutter, the app is optimized for mobile devices, offering a responsive and adaptive UI.

## Installation

1. **Clone the repository**:
   ```sh
   git clone https://github.com/pranideepnayaki/smart-assistant-flutter-app.git
   cd smart-assistant-flutter-app
   ```

2. **Install dependencies**:
   ```sh
   flutter pub get
   ```

3. **Run the app**:
   ```sh
   flutter run
   ```

## Usage

1. **Open the App**: Launch the app on your mobile device or emulator.
2. **Enter Query**: Type your English text in the input field.
3. **Submit**: Press the 'Submit' button to send your text to the AI model for translation.
4. **View Response**: The translated text in German will be displayed on the screen.

## Configuration

- **API Endpoint**: The app uses the Hugging Face API endpoint `https://api-inference.huggingface.co/models/t5-base`.
- **Authorization**: An API key is required to authenticate requests. Set your API key in the `headers` section of the `_fetchAIResponse` method.
  ```dart
  final headers = {
    'Authorization': 'Bearer YOUR_HUGGINGFACE_API_KEY',
    'Content-Type': 'application/json',
  };
  ```

## Dependencies

- **Flutter**: The app is built using Flutter for cross-platform compatibility.
- **http**: The `http` package is used for making API requests.
- **dart:convert**: The `dart:convert` library is used for JSON encoding and decoding.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## Contact

For any questions or feedback, please contact n.pranideepreddy1999@gmail.com
