# Escopo e regras iniciais

## Confirmado por Bruno

- ERP exclusivo para ConnectaOne.
- Acesso online e possibilidade de personalização.
- Preferência por base open source e execução assistida por IA usando os planos existentes.
- Começar com controles; emissão fiscal fica para depois.
- GitHub como local compartilhado para especificações e código.
- Hospedagem ainda não informada. FTP é um meio de transferência, não define o ambiente da aplicação.

## Proposta de entregas

1. Clientes e fornecedores.
2. Catálogo, contratos e serviços contratados.
3. Contas a pagar e receber com baixas manuais.
4. Painel gerencial.

## Modelo proposto

- Cliente: cadastro único por identificação fiscal normalizada, razão social, nome fantasia, contatos financeiros e técnicos, endereço e status.
- Fornecedor: cadastro e contatos; permitir que uma mesma empresa exerça os dois papéis sem duplicação desnecessária.
- Produto: tipo de serviço e unidade comercial. Exemplos: IP, DDoS, transporte, colocation, energia e combos.
- Contrato: pertence a um cliente; possui referência, vigência, condições comerciais e anexos privados.
- Serviço contratado: pertence a um contrato; possui designação única, produto, quantidade/capacidade, localização, mensalidade, instalação e custos vinculados.
- Um cliente pode ter vários contratos; um contrato pode ter vários serviços.
- Assinatura, ativação e início de faturamento são datas distintas.
- Status sugeridos: planejado, em implantação, ativo, suspenso, cancelado. Suspensão não determina automaticamente a regra de cobrança; exigir regra explícita.

## Controles financeiros propostos

- Valores em BRL com representação decimal exata.
- Separar receita contratada, valores previstos, títulos emitidos internamente e recebimentos efetivos.
- Baixas manuais com data, valor, usuário e histórico; admitir pagamentos parciais.
- Geração recorrente deve impedir duplicação do mesmo serviço e competência, inclusive após nova execução.
- Cancelamento preserva histórico e títulos existentes; não apaga recebimentos.
- Margem gerencial deve explicitar receita e custos considerados; não chamar de lucro líquido.
- Não implementar cálculo de pró-rata, multa ou reajuste antes de registrar suas regras e exemplos aprovados.

## Critérios essenciais de aceitação

- Mesmo documento fiscal com pontuação diferente não cria cliente duplicado.
- Dois serviços do mesmo cliente podem ter datas e valores diferentes.
- Acesso restrito por usuário e função, validado também no servidor.
- Alterações relevantes deixam histórico de autor, data e valores alterados.
- Exportações permitem conferir cadastros e totais.
- Testar restauração do backup antes da entrada em produção.

## Fora da primeira fase

Emissão de notas fiscais, integrações bancárias, envio automático de cobranças, assinatura eletrônica, portal externo, provisionamento de rede e migração de dados reais.

## Decisões ainda necessárias

Hospedagem, usuários e permissões, convenção de designações, vencimentos, competência de cobrança, pró-rata, suspensão, cancelamento e método de apropriação dos custos compartilhados.
