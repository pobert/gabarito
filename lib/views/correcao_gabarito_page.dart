import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/aluno_autocomplete.dart';
import 'package:flutter_app/views/gabarito_correcao_page.dart';

class CorrecaoGabaritoPage extends StatefulWidget {
  final Map<String, dynamic> disciplina;
  final Map<String, dynamic> turma;

  const CorrecaoGabaritoPage({
    super.key,
    required this.disciplina,
    required this.turma,
  });

  @override
  State<CorrecaoGabaritoPage> createState() => _CorrecaoGabaritoPageState();
}

class _CorrecaoGabaritoPageState extends State<CorrecaoGabaritoPage> {
  List<Map<String, dynamic>> alunos = [];
  Map<String, dynamic>? selectedAluno;
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAlunos();
  }

  Future<void> _loadAlunos() async {
    // Simulação de carregamento de alunos do backend
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      alunos = [
        {
          'id': 1,
          'codigo': '2024001',
          'nome': 'João Silva',
          'jaCorrigido': false,
        },
        {
          'id': 2,
          'codigo': '2024002',
          'nome': 'Maria Santos',
          'jaCorrigido': true,
        },
        {
          'id': 3,
          'codigo': '2024003',
          'nome': 'Pedro Oliveira',
          'jaCorrigido': false,
        },
        {
          'id': 4,
          'codigo': '2024004',
          'nome': 'Ana Costa',
          'jaCorrigido': false,
        },
        {
          'id': 5,
          'codigo': '2024005',
          'nome': 'Carlos Ferreira',
          'jaCorrigido': true,
        },
      ];
      isLoading = false;
    });
  }

  void _onAlunoSelected(Map<String, dynamic>? aluno) {
    setState(() {
      selectedAluno = aluno;
    });

    if (aluno != null && !aluno['jaCorrigido']) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GabaritoCorrecaoPage(
            disciplina: widget.disciplina,
            turma: widget.turma,
            aluno: aluno,
          ),
        ),
      ).then((_) {
        // Recarregar alunos quando voltar da tela de correção
        _loadAlunos();
        setState(() {
          selectedAluno = null;
          searchController.clear();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.disciplina['nome']} - ${widget.turma['nome']}'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Disciplina: ${widget.disciplina['nome']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Turma: ${widget.turma['nome']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total de alunos: ${alunos.length}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Corrigidos: ${alunos.where((a) => a['jaCorrigido']).length}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Pendentes: ${alunos.where((a) => !a['jaCorrigido']).length}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
                AlunoAutocomplete(
                  alunos: alunos,
                  onSelected: _onAlunoSelected,
                  controller: searchController,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Selecione um aluno para iniciar a correção do gabarito',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.info_outline, color: Colors.blue),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Alunos já corrigidos aparecerão desabilitados na busca',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

