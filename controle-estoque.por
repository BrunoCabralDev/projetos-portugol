programa
{
    // O mesmo índice representa o mesmo produto em todos os vetores.
    const inteiro LIMITE = 100

    inteiro codigos[LIMITE]
    cadeia nomes[LIMITE]
    inteiro quantidades[LIMITE]
    inteiro estoquesMinimos[LIMITE]
    real precos[LIMITE]

    inteiro totalProdutos = 0

    funcao inicio()
    {
        inteiro opcao = -1

        enquanto (opcao != 0)
        {
            escreva("\n========== CONTROLE DE ESTOQUE ==========\n")
            escreva("1 - Cadastrar produto\n")
            escreva("2 - Listar produtos\n")
            escreva("3 - Buscar produto por código\n")
            escreva("4 - Registrar entrada\n")
            escreva("5 - Registrar saída\n")
            escreva("6 - Mostrar estoque baixo\n")
            escreva("7 - Mostrar resumo do estoque\n")
            escreva("0 - Sair\n")
            escreva("Escolha uma opção: ")
            leia(opcao)

            escolha (opcao)
            {
                caso 1:
                    cadastrarProduto()
                    pare

                caso 2:
                    listarProdutos()
                    pare

                caso 3:
                    consultarProduto()
                    pare

                caso 4:
                    movimentarEstoque(verdadeiro)
                    pare

                caso 5:
                    movimentarEstoque(falso)
                    pare

                caso 6:
                    mostrarEstoqueBaixo()
                    pare

                caso 7:
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

    // Retorna o índice do produto ou -1 quando não encontra.
    funcao inteiro buscarIndice(inteiro codigo)
    {
        para (inteiro i = 0; i < totalProdutos; i++)
        {
            se (codigos[i] == codigo)
            {
                retorne i
            }
        }

        retorne -1
    }

    // Reutilizada para ler códigos e quantidades de movimentação.
    funcao inteiro lerInteiroPositivo(cadeia mensagem)
    {
        inteiro valor

        escreva(mensagem)
        leia(valor)

        enquanto (valor <= 0)
        {
            escreva("Digite um número inteiro maior que zero: ")
            leia(valor)
        }

        retorne valor
    }

    // Estoque inicial e estoque mínimo podem ser zero.
    funcao inteiro lerInteiroNaoNegativo(cadeia mensagem)
    {
        inteiro valor

        escreva(mensagem)
        leia(valor)

        enquanto (valor < 0)
        {
            escreva("Digite um número inteiro igual ou maior que zero: ")
            leia(valor)
        }

        retorne valor
    }

    funcao cadastrarProduto()
    {
        se (totalProdutos >= LIMITE)
        {
            escreva("\nLimite de produtos atingido.\n")
        }
        senao
        {
            inteiro codigo
            cadeia nome
            real preco

            escreva("\n--- CADASTRO DE PRODUTO ---\n")
            codigo = lerInteiroPositivo("Código do produto: ")

            se (buscarIndice(codigo) != -1)
            {
                escreva("\nJá existe um produto com esse código.\n")
            }
            senao
            {
                escreva("Nome do produto: ")
                leia(nome)

                enquanto (nome == "")
                {
                    escreva("O nome não pode ficar vazio. Digite novamente: ")
                    leia(nome)
                }

                escreva("Preço por unidade (exemplo: 2.50): R$ ")
                leia(preco)

                enquanto (preco <= 0)
                {
                    escreva("Digite um preço maior que zero: R$ ")
                    leia(preco)
                }

                quantidades[totalProdutos] =
                    lerInteiroNaoNegativo("Quantidade inicial: ")

                estoquesMinimos[totalProdutos] =
                    lerInteiroNaoNegativo("Estoque mínimo para alerta: ")

                codigos[totalProdutos] = codigo
                nomes[totalProdutos] = nome
                precos[totalProdutos] = preco

                totalProdutos++

                escreva("\nProduto cadastrado com sucesso!\n")
            }
        }
    }

    funcao exibirProduto(inteiro indice)
    {
        escreva("\n----------------------------------------\n")
        escreva("Código: ", codigos[indice], "\n")
        escreva("Nome: ", nomes[indice], "\n")
        escreva("Preço por unidade: R$ ", precos[indice], "\n")
        escreva("Quantidade: ", quantidades[indice], "\n")
        escreva("Estoque mínimo: ", estoquesMinimos[indice], "\n")
        escreva("Valor em estoque: R$ ",
            precos[indice] * quantidades[indice], "\n")

        se (quantidades[indice] <= estoquesMinimos[indice])
        {
            escreva("ALERTA: estoque no mínimo ou abaixo dele.\n")
        }
    }

    funcao listarProdutos()
    {
        se (totalProdutos == 0)
        {
            escreva("\nNenhum produto cadastrado.\n")
        }
        senao
        {
            escreva("\n--- PRODUTOS CADASTRADOS ---\n")

            para (inteiro i = 0; i < totalProdutos; i++)
            {
                exibirProduto(i)
            }
        }
    }

    funcao consultarProduto()
    {
        se (totalProdutos == 0)
        {
            escreva("\nNenhum produto cadastrado.\n")
        }
        senao
        {
            inteiro codigo, indice

            escreva("\n--- CONSULTAR PRODUTO ---\n")
            codigo = lerInteiroPositivo("Código do produto: ")
            indice = buscarIndice(codigo)

            se (indice == -1)
            {
                escreva("\nProduto não encontrado.\n")
            }
            senao
            {
                exibirProduto(indice)
            }
        }
    }

    // verdadeiro registra entrada; falso registra saída.
    funcao movimentarEstoque(logico entrada)
    {
        se (totalProdutos == 0)
        {
            escreva("\nNenhum produto cadastrado.\n")
        }
        senao
        {
            inteiro codigo, indice, quantidade

            se (entrada)
            {
                escreva("\n--- ENTRADA DE ESTOQUE ---\n")
            }
            senao
            {
                escreva("\n--- SAÍDA DE ESTOQUE ---\n")
            }

            codigo = lerInteiroPositivo("Código do produto: ")
            indice = buscarIndice(codigo)

            se (indice == -1)
            {
                escreva("\nProduto não encontrado.\n")
            }
            senao
            {
                escreva("Produto: ", nomes[indice], "\n")
                escreva("Estoque atual: ", quantidades[indice], "\n")

                quantidade =
                    lerInteiroPositivo("Quantidade da movimentação: ")

                se (entrada)
                {
                    quantidades[indice] =
                        quantidades[indice] + quantidade

                    escreva("\nEntrada registrada com sucesso!\n")
                }
                senao
                {
                    se (quantidade > quantidades[indice])
                    {
                        escreva("\nEstoque insuficiente. Saída cancelada.\n")
                    }
                    senao
                    {
                        quantidades[indice] =
                            quantidades[indice] - quantidade

                        escreva("\nSaída registrada com sucesso!\n")
                    }
                }

                escreva("Estoque atual: ", quantidades[indice], "\n")

                se (quantidades[indice] <= estoquesMinimos[indice])
                {
                    escreva("ALERTA: estoque no mínimo ou abaixo dele.\n")
                }
            }
        }
    }

    funcao mostrarEstoqueBaixo()
    {
        se (totalProdutos == 0)
        {
            escreva("\nNenhum produto cadastrado.\n")
        }
        senao
        {
            inteiro encontrados = 0

            escreva("\n--- PRODUTOS COM ESTOQUE BAIXO ---\n")

            para (inteiro i = 0; i < totalProdutos; i++)
            {
                se (quantidades[i] <= estoquesMinimos[i])
                {
                    exibirProduto(i)
                    encontrados++
                }
            }

            se (encontrados == 0)
            {
                escreva("\nTodos os produtos estão acima do estoque mínimo.\n")
            }
            senao
            {
                escreva("\nProdutos em alerta: ", encontrados, "\n")
            }
        }
    }

    funcao mostrarResumo()
    {
        inteiro totalUnidades = 0
        inteiro produtosEmAlerta = 0
        real valorTotal = 0.0

        para (inteiro i = 0; i < totalProdutos; i++)
        {
            totalUnidades = totalUnidades + quantidades[i]
            valorTotal = valorTotal + precos[i] * quantidades[i]

            se (quantidades[i] <= estoquesMinimos[i])
            {
                produtosEmAlerta++
            }
        }

        escreva("\n========== RESUMO DO ESTOQUE ==========\n")
        escreva("Produtos cadastrados: ", totalProdutos, "\n")
        escreva("Total de unidades: ", totalUnidades, "\n")
        escreva("Produtos em alerta: ", produtosEmAlerta, "\n")
        escreva("Valor total em estoque: R$ ", valorTotal, "\n")
    }
}
