import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/disciplina_selector.dart';
import 'package:flutter_app/widgets/turma_selector.dart';
import 'package:flutter_app/views/correcao_gabarito_page.dart';

class SelecaoDisciplinaTurmaPage extends StatefulWidget {
  const SelecaoDisciplinaTurmaPage({super.key});

  @override
  State<SelecaoDisciplinaTurmaPage> createState() => _SelecaoDisciplinaTurmaPageState();
}

class _SelecaoDisciplinaTurmaPageState extends State<SelecaoDisciplinaTurmaPage> {
  Map<String, dynamic>? selectedDisciplina;
  Map<String, dynamic>? selectedTurma;
  List<Map<String, dynamic>> disciplinas = [];
  List<Map<String, dynamic>> turmas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadDisciplinas();
  }

  Future<void> _loadDisciplinas() async {
    // Simulação de carregamento de disciplinas do backend
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      disciplinas = [
        {'id': 1, 'nome': 'Matemática'},
        {'id': 2, 'nome': 'Português'},
        {'id': 3, 'nome': 'História'},
        {'id': 4, 'nome': 'Geografia'},
        {'id': 5, 'nome': 'Ciências'},
      ];
      isLoading = false;
    });
  }

  Future<void> _loadTurmas(int disciplinaId) async {
    setState(() {
      isLoading = true;
      selectedTurma = null;
    });

    // Simulação de carregamento de turmas do backend
    await Future.delayed(const Duration(milliseconds: 500));
    
    setState(() {
      turmas = [
        {'id': 1, 'nome': 'Turma A', 'disciplinaId': disciplinaId},
        {'id': 2, 'nome': 'Turma B', 'disciplinaId': disciplinaId},
        {'id': 3, 'nome': 'Turma C', 'disciplinaId': disciplinaId},
      ];
      isLoading = false;
    });
  }

  void _onDisciplinaChanged(Map<String, dynamic>? disciplina) {
    setState(() {
      selectedDisciplina = disciplina;
      selectedTurma = null;
      turmas = [];
    });

    if (disciplina != null) {
      _loadTurmas(disciplina['id']);
    }
  }

  void _onTurmaChanged(Map<String, dynamic>? turma) {
    setState(() {
      selectedTurma = turma;
    });
  }

  void _navigateToCorrecao() {
    if (selectedDisciplina != null && selectedTurma != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CorrecaoGabaritoPage(
            disciplina: selectedDisciplina!,
            turma: selectedTurma!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Correção de Gabaritos'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Selecione a disciplina e turma para iniciar a correção',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                DisciplinaSelector(
                  disciplinas: disciplinas,
                  selectedDisciplina: selectedDisciplina,
                  onChanged: _onDisciplinaChanged,
                ),
                if (selectedDisciplina != null && turmas.isNotEmpty)
                  TurmaSelector(
                    turmas: turmas,
                    selectedTurma: selectedTurma,
                    onChanged: _onTurmaChanged,
                  ),
                const Spacer(),
                if (selectedDisciplina != null && selectedTurma != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: _navigateToCorrecao,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Continuar para Correção',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            ),
    );
  }
}

