programa
{
    const inteiro LIMITE = 200

    cadeia descricoes[LIMITE]
    real valores[LIMITE]

    // 1 = receita; 2 = despesa
    inteiro tipos[LIMITE]
    inteiro totalLancamentos = 0

    funcao inicio()
    {
        inteiro opcao = -1

        enquanto (opcao != 0)
        {
            escreva("\n======= CONTROLE FINANCEIRO =======\n")
            escreva("1 - Registrar receita\n")
            escreva("2 - Registrar despesa\n")
            escreva("3 - Consultar extrato completo\n")
            escreva("4 - Listar receitas\n")
            escreva("5 - Listar despesas\n")
            escreva("6 - Mostrar resumo financeiro\n")
            escreva("0 - Sair\n")
            escreva("Escolha uma opção: ")
            leia(opcao)

            escolha (opcao)
            {
                caso 1:
                    registrarLancamento(1)
                    pare

                caso 2:
                    registrarLancamento(2)
                    pare

                caso 3:
                    listarLancamentos(0)
                    pare

                caso 4:
                    listarLancamentos(1)
                    pare

                caso 5:
                    listarLancamentos(2)
                    pare

                caso 6:
                    mostrarResumo()
                    pare

                caso 0:
                    escreva("\nPrograma encerrado.\n")
                    escreva("Os dados desta sessão não foram salvos em arquivo.\n")
                    pare

                caso contrario:
                    escreva("\nOpção inválida. Tente novamente.\n")
            }
        }
    }

    funcao registrarLancamento(inteiro tipo)
    {
        se (totalLancamentos >= LIMITE)
        {
            escreva("\nLimite de lançamentos atingido.\n")
        }
        senao
        {
            cadeia descricao
            real valor

            se (tipo == 1)
            {
                escreva("\n--- REGISTRAR RECEITA ---\n")
            }
            senao
            {
                escreva("\n--- REGISTRAR DESPESA ---\n")
            }

            escreva("Descrição: ")
            leia(descricao)

            enquanto (descricao == "")
            {
                escreva("Informe uma descrição: ")
                leia(descricao)
            }

            escreva("Valor (exemplo: 25.50): R$ ")
            leia(valor)

            enquanto (valor <= 0)
            {
                escreva("O valor deve ser maior que zero. Digite novamente: ")
                leia(valor)
            }

            descricoes[totalLancamentos] = descricao
            valores[totalLancamentos] = valor
            tipos[totalLancamentos] = tipo

            totalLancamentos++

            escreva("\nLançamento registrado com sucesso!\n")
            escreva("Número do lançamento: ", totalLancamentos, "\n")
        }
    }

    // Filtro 0 mostra tudo; 1 mostra receitas; 2 mostra despesas.
    funcao listarLancamentos(inteiro filtro)
    {
        inteiro encontrados = 0
        real totalListado = 0.0

        escreva("\n--- LANÇAMENTOS FINANCEIROS ---\n")

        para (inteiro i = 0; i < totalLancamentos; i++)
        {
            se (filtro == 0 ou tipos[i] == filtro)
            {
                escreva("\nLançamento: ", i + 1, "\n")
                escreva("Descrição: ", descricoes[i], "\n")

                se (tipos[i] == 1)
                {
                    escreva("Tipo: receita\n")
                }
                senao
                {
                    escreva("Tipo: despesa\n")
                }

                escreva("Valor: R$ ", valores[i], "\n")
                escreva("----------------------------------\n")

                encontrados++
                totalListado = totalListado + valores[i]
            }
        }

        se (encontrados == 0)
        {
            escreva("\nNenhum lançamento encontrado.\n")
        }
        senao
        {
            escreva("\nLançamentos encontrados: ", encontrados, "\n")

            // No extrato completo, receitas e despesas ficam separadas
            // por tipo. O saldo é calculado na opção de resumo.
            se (filtro != 0)
            {
                escreva("Total desta listagem: R$ ", totalListado, "\n")
            }
        }
    }

    funcao mostrarResumo()
    {
        real totalReceitas = 0.0
        real totalDespesas = 0.0
        real saldo, percentualGasto

        para (inteiro i = 0; i < totalLancamentos; i++)
        {
            se (tipos[i] == 1)
            {
                totalReceitas = totalReceitas + valores[i]
            }
            senao
            {
                totalDespesas = totalDespesas + valores[i]
            }
        }

        saldo = totalReceitas - totalDespesas

        escreva("\n======= RESUMO FINANCEIRO =======\n")
        escreva("Lançamentos registrados: ", totalLancamentos, "\n")
        escreva("Total de receitas: R$ ", totalReceitas, "\n")
        escreva("Total de despesas: R$ ", totalDespesas, "\n")
        escreva("Saldo: R$ ", saldo, "\n")

        se (saldo > 0)
        {
            escreva("Situação: saldo positivo.\n")
        }
        senao se (saldo < 0)
        {
            escreva("Situação: despesas superiores às receitas.\n")
        }
        senao
        {
            escreva("Situação: saldo zerado.\n")
        }

        // Evita divisão por zero.
        se (totalReceitas > 0)
        {
            percentualGasto = (totalDespesas / totalReceitas) * 100

            escreva("Despesas em relação às receitas: ",
                percentualGasto, "%\n")
        }
        senao
        {
            escreva("Percentual não calculado: não há receitas.\n")
        }
    }
}
