import 'package:flutter/material.dart';
import 'package:lds/src/core/services/requests.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> validUrls = [];
  bool _isLoading = false; // <-- variável para controlar o loader

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LookDirSerch", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 3, 2, 2),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(Icons.arrow_forward_sharp, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
      ),

      drawer: Drawer(
        backgroundColor: Color(0xFF2E2E2E),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "URLs válidas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: validUrls.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        validUrls[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      leading: Icon(Icons.check_circle, color: Colors.green),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      body: Stack(
        children: [
          // Imagem de fundo
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background/background2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Campo de texto central
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: 'Digite a url alvo...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: const Color(0xFF424242),
                  prefixIcon: Icon(Icons.search, color: Colors.white),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed:
            _isLoading
                ? null
                : () async {
                  setState(() {
                    _isLoading = true;
                  });

                  final input = _controller.text.trim();

                  if (!Requests.isValidUrl(input)) {
                    setState(() {
                      _isLoading = false;
                    });
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("URL inválida.")));
                    return;
                  }

                  final requester = Requests(url: input);
                  final results = await requester.testPayloads();

                  if (results.isNotEmpty) {
                    setState(() {
                      validUrls.addAll(results);
                      _isLoading = false;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("URLs válidas adicionadas!")),
                    );
                  } else {
                    setState(() {
                      _isLoading = false;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("URL inválida ou sem resposta.")),
                    );
                  }
                },
        label:
            _isLoading
                ? Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "Carregando...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
                : Text("Iniciar", style: TextStyle(color: Colors.white)),
        icon: _isLoading ? null : Icon(Icons.flash_on, color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 29, 29, 29),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
