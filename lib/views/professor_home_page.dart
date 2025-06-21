import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/correcao_gabarito_button.dart';
import 'package:flutter_app/views/selecao_disciplina_turma_page.dart';

class ProfessorHomePage extends StatefulWidget {
  const ProfessorHomePage({super.key});

  @override
  State<ProfessorHomePage> createState() => _ProfessorHomePageState();
}

class _ProfessorHomePageState extends State<ProfessorHomePage> {
  void _navigateToCorrecaoGabarito() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelecaoDisciplinaTurmaPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Área do Professor'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Bem-vindo, Professor!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          CorrecaoGabaritoButton(
            onPressed: _navigateToCorrecaoGabarito,
          ),
          const SizedBox(height: 20),
          // Aqui podem ser adicionados outros botões/funcionalidades
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.assignment),
                title: const Text('Gerenciar Provas'),
                subtitle: const Text('Criar e editar provas'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Implementar navegação para gerenciar provas
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.people),
                title: const Text('Gerenciar Turmas'),
                subtitle: const Text('Visualizar e editar turmas'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Implementar navegação para gerenciar turmas
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text('Relatórios'),
                subtitle: const Text('Visualizar estatísticas e relatórios'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Implementar navegação para relatórios
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}