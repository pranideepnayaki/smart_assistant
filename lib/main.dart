import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SmartAssistantPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SmartAssistantPage extends StatefulWidget {
  @override
  _SmartAssistantPageState createState() => _SmartAssistantPageState();
}

class _SmartAssistantPageState extends State<SmartAssistantPage> {
  String assistantResponse = '';
  TextEditingController _controller = TextEditingController();

  Future<void> _fetchAIResponse(String query) async {
    final apiUrl = 'https://api-inference.huggingface.co/models/t5-base';
    final headers = {
      'Authorization': 'Bearer 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',
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({'inputs': query});

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: body,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // Check if the response is an error
        if (jsonResponse is Map && jsonResponse['error'] != null) {
          setState(() {
            assistantResponse = 'Error: ${jsonResponse['error']}';
          });
        } else if (jsonResponse is List && jsonResponse.isNotEmpty) {
          // Handle successful response
          final translationText = jsonResponse[0]['translation_text'];
          setState(() {
            assistantResponse = translationText ?? 'No response text';
          });
        } else {
          setState(() {
            assistantResponse = 'Unexpected response format';
          });
        }
      } else if (response.statusCode == 503) {
        // Handle 503 error specifically
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          assistantResponse = 'Service Unavailable: ${jsonResponse['error']}';
        });
      } else {
        setState(() {
          assistantResponse = 'Failed to get response from AI service';
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        assistantResponse = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Smart Assistant')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ask me anything:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(
              width: 300,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Type your query...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _fetchAIResponse(_controller.text),
              child: Text('Submit'),
            ),
            SizedBox(height: 20),
            if (assistantResponse.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Assistant: $assistantResponse',
                  style: TextStyle(fontSize: 18),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
