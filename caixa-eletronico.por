programa
{
    const inteiro LIMITE = 100

    cadeia tipos[LIMITE]
    inteiro valores[LIMITE]
    inteiro saldosApos[LIMITE]

    inteiro saldo = 0
    inteiro totalMovimentacoes = 0

    funcao inicio()
    {
        inteiro opcao = -1

        enquanto (opcao != 0)
        {
            escreva("\n========== CAIXA ELETRÔNICO ==========\n")
            escreva("1 - Consultar saldo\n")
            escreva("2 - Depositar\n")
            escreva("3 - Sacar\n")
            escreva("4 - Consultar extrato\n")
            escreva("0 - Sair\n")
            escreva("Escolha uma opção: ")
            leia(opcao)

            escolha (opcao)
            {
                caso 1:
                    escreva("\nSaldo disponível: R$ ", saldo, "\n")
                    pare

                caso 2:
                    depositar()
                    pare

                caso 3:
                    sacar()
                    pare

                caso 4:
                    mostrarExtrato()
                    pare

                caso 0:
                    escreva("\nSessão encerrada.\n")
                    escreva("Os dados não foram salvos em arquivo.\n")
                    pare

                caso contrario:
                    escreva("\nOpção inválida.\n")
            }
        }
    }

    funcao inteiro lerValor()
    {
        inteiro valor

        escreva("Digite o valor em reais, sem centavos: ")
        leia(valor)

        enquanto (valor <= 0)
        {
            escreva("Digite um número inteiro maior que zero: ")
            leia(valor)
        }

        retorne valor
    }

    funcao registrarMovimentacao(cadeia tipo, inteiro valor)
    {
        tipos[totalMovimentacoes] = tipo
        valores[totalMovimentacoes] = valor
        saldosApos[totalMovimentacoes] = saldo
        totalMovimentacoes++
    }

    funcao depositar()
    {
        se (totalMovimentacoes >= LIMITE)
        {
            escreva("\nLimite de movimentações da sessão atingido.\n")
        }
        senao
        {
            inteiro valor

            escreva("\n--- DEPÓSITO ---\n")
            valor = lerValor()

            // Limita o saldo para evitar valores excessivos.
            se (valor > 1000000 - saldo)
            {
                escreva("\nDepósito cancelado.\n")
                escreva("O saldo máximo do simulador é R$ 1000000.\n")
            }
            senao
            {
                saldo = saldo + valor
                registrarMovimentacao("Depósito", valor)

                escreva("\nDepósito realizado!\n")
                escreva("Saldo atual: R$ ", saldo, "\n")
            }
        }
    }

    funcao sacar()
    {
        se (totalMovimentacoes >= LIMITE)
        {
            escreva("\nLimite de movimentações da sessão atingido.\n")
        }
        senao se (saldo == 0)
        {
            escreva("\nVocê não possui saldo para saque.\n")
        }
        senao
        {
            inteiro valor

            escreva("\n--- SAQUE ---\n")
            escreva("Cédulas: R$ 100, 50, 20, 10, 5 e 2.\n")
            valor = lerValor()

            se (valor > saldo)
            {
                escreva("\nSaldo insuficiente. Saque cancelado.\n")
            }
            senao se (valor == 1 ou valor == 3)
            {
                escreva("\nNão é possível formar esse valor")
                escreva(" com as cédulas disponíveis.\n")
            }
            senao
            {
                entregarCedulas(valor)

                saldo = saldo - valor
                registrarMovimentacao("Saque", valor)

                escreva("\nSaque realizado!\n")
                escreva("Saldo atual: R$ ", saldo, "\n")
            }
        }
    }

    funcao entregarCedulas(inteiro valor)
    {
        inteiro cedulas[6] = {100, 50, 20, 10, 5, 2}
        inteiro quantidades[6] = {0, 0, 0, 0, 0, 0}
        inteiro restante = valor

        para (inteiro i = 0; i < 6; i++)
        {
            enquanto (restante >= cedulas[i])
            {
                restante = restante - cedulas[i]
                quantidades[i]++
            }

            // Evita deixar R$ 1 ou R$ 3 para as cédulas menores.
            // Exemplo: R$ 6 deve sair em três cédulas de R$ 2.
            se (restante == 1 ou restante == 3)
            {
                se (quantidades[i] > 0)
                {
                    quantidades[i]--
                    restante = restante + cedulas[i]
                }
            }
        }

        escreva("\nCédulas entregues:\n")

        para (inteiro i = 0; i < 6; i++)
        {
            se (quantidades[i] > 0)
            {
                escreva(quantidades[i], " cédula(s) de R$ ",
                    cedulas[i], "\n")
            }
        }
    }

    funcao mostrarExtrato()
    {
        escreva("\n========== EXTRATO ==========\n")

        se (totalMovimentacoes == 0)
        {
            escreva("Nenhuma movimentação registrada.\n")
        }
        senao
        {
            para (inteiro i = 0; i < totalMovimentacoes; i++)
            {
                escreva("\nMovimentação: ", i + 1, "\n")
                escreva("Tipo: ", tipos[i], "\n")
                escreva("Valor: R$ ", valores[i], "\n")
                escreva("Saldo após a operação: R$ ",
                    saldosApos[i], "\n")
            }
        }

        escreva("\nSaldo atual: R$ ", saldo, "\n")
    }
}
