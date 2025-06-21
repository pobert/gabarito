import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/questao_multipla_escolha.dart';
import 'package:flutter_app/widgets/questao_dissertativa.dart';

class GabaritoCorrecaoPage extends StatefulWidget {
  final Map<String, dynamic> disciplina;
  final Map<String, dynamic> turma;
  final Map<String, dynamic> aluno;

  const GabaritoCorrecaoPage({
    super.key,
    required this.disciplina,
    required this.turma,
    required this.aluno,
  });

  @override
  State<GabaritoCorrecaoPage> createState() => _GabaritoCorrecaoPageState();
}

class _GabaritoCorrecaoPageState extends State<GabaritoCorrecaoPage> {
  List<Map<String, dynamic>> questoes = [];
  Map<int, String?> respostasMultiplas = {};
  Map<int, double?> respostasDissertativas = {};
  bool isLoading = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadGabarito();
  }

  Future<void> _loadGabarito() async {
    // Simulação de carregamento do gabarito do backend
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      questoes = [
        {
          "questao_numero": 1,
          "tipo": "Múltipla Escolha",
          "valor": 2.0,
          "resposta_correta": "A"
        },
        {
          "questao_numero": 2,
          "tipo": "Dissertativa",
          "valor": 3.0
        },
        {
          "questao_numero": 3,
          "tipo": "Dissertativa",
          "valor": 1.0
        },
        {
          "questao_numero": 4,
          "tipo": "Múltipla Escolha",
          "valor": 2.0,
          "resposta_correta": "C"
        },
        {
          "questao_numero": 5,
          "tipo": "Dissertativa",
          "valor": 4.0
        },
        {
          "questao_numero": 6,
          "tipo": "Múltipla Escolha",
          "valor": 1.5,
          "resposta_correta": "B"
        },
        {
          "questao_numero": 7,
          "tipo": "Múltipla Escolha",
          "valor": 2.5,
          "resposta_correta": "D"
        },
        {
          "questao_numero": 8,
          "tipo": "Dissertativa",
          "valor": 3.0
        },
        {
          "questao_numero": 9,
          "tipo": "Múltipla Escolha",
          "valor": 1.0,
          "resposta_correta": "E"
        },
        {
          "questao_numero": 10,
          "tipo": "Dissertativa",
          "valor": 2.0
        },
      ];
      isLoading = false;
    });
  }

  void _onRespostaMultiplaChanged(int questaoNumero, String? resposta) {
    setState(() {
      respostasMultiplas[questaoNumero] = resposta;
    });
  }

  void _onRespostaDissertativaChanged(int questaoNumero, double? valor) {
    setState(() {
      respostasDissertativas[questaoNumero] = valor;
    });
  }

  double _calcularNotaTotal() {
    double total = 0.0;
    
    for (var questao in questoes) {
      final numero = questao['questao_numero'] as int;
      final tipo = questao['tipo'] as String;
      final valorMaximo = (questao['valor'] as num).toDouble();
      
      if (tipo == 'Múltipla Escolha') {
        final respostaSelecionada = respostasMultiplas[numero];
        final respostaCorreta = questao['resposta_correta'] as String;
        
        if (respostaSelecionada == respostaCorreta) {
          total += valorMaximo;
        }
      } else if (tipo == 'Dissertativa') {
        final valorAtribuido = respostasDissertativas[numero];
        if (valorAtribuido != null) {
          total += valorAtribuido;
        }
      }
    }
    
    return total;
  }

  bool _isGabaritoCompleto() {
    for (var questao in questoes) {
      final numero = questao['questao_numero'] as int;
      final tipo = questao['tipo'] as String;
      
      if (tipo == 'Múltipla Escolha') {
        if (respostasMultiplas[numero] == null) {
          return false;
        }
      } else if (tipo == 'Dissertativa') {
        if (respostasDissertativas[numero] == null) {
          return false;
        }
      }
    }
    return true;
  }

  Future<void> _salvarGabarito() async {
    if (!_isGabaritoCompleto()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, complete todas as questões antes de salvar'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    // Simulação de salvamento no backend
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isSaving = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gabarito salvo com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      // Voltar para a tela anterior
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Correção de Gabarito'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          if (!isLoading)
            TextButton(
              onPressed: isSaving ? null : _salvarGabarito,
              child: Text(
                'SALVAR',
                style: TextStyle(
                  color: _isGabaritoCompleto() ? Colors.white : Colors.grey.shade300,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Cabeçalho com informações do aluno
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aluno: ${widget.aluno['nome']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Código: ${widget.aluno['codigo']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Disciplina: ${widget.disciplina['nome']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Turma: ${widget.turma['nome']}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Nota atual: ${_calcularNotaTotal().toStringAsFixed(1)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Cabeçalho do gabarito
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  color: Theme.of(context).primaryColor,
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: Text(
                          'Questão',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Respostas / Valor',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Text(
                          'Status',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Lista de questões
                Expanded(
                  child: ListView.builder(
                    itemCount: questoes.length,
                    itemBuilder: (context, index) {
                      final questao = questoes[index];
                      final numero = questao['questao_numero'] as int;
                      final tipo = questao['tipo'] as String;
                      final valor = (questao['valor'] as num).toDouble();
                      
                      if (tipo == 'Múltipla Escolha') {
                        final respostaCorreta = questao['resposta_correta'] as String;
                        return QuestaoMultiplaEscolha(
                          numeroQuestao: numero,
                          respostaSelecionada: respostasMultiplas[numero],
                          respostaCorreta: respostaCorreta,
                          onChanged: (resposta) => _onRespostaMultiplaChanged(numero, resposta),
                        );
                      } else {
                        return QuestaoDissertativa(
                          numeroQuestao: numero,
                          valorMaximo: valor,
                          valorAtribuido: respostasDissertativas[numero],
                          onChanged: (valor) => _onRespostaDissertativaChanged(numero, valor),
                        );
                      }
                    },
                  ),
                ),
                
                // Botão de salvar
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: isSaving || !_isGabaritoCompleto() ? null : _salvarGabarito,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: _isGabaritoCompleto() ? Colors.green : Colors.grey,
                    ),
                    child: isSaving
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text('Salvando...'),
                            ],
                          )
                        : Text(
                            'Salvar Gabarito (${_calcularNotaTotal().toStringAsFixed(1)} pontos)',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
    );
  }
}

