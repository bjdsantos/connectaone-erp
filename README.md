# ConnectaOne ERP

Planejamento e desenvolvimento do ERP online da ConnectaOne (C1).

## Status

Projeto em definição. Ainda não existe aplicação instalada ou publicada. Desenvolvimento local autorizado; sem publicação nesta fase. ERPNext é a proposta para o piloto, ainda sujeita à validação técnica local. Este repositório coordena o trabalho; não conecta automaticamente conversas ou executa agentes.

## Objetivo

Centralizar clientes, fornecedores, contratos, serviços e controles financeiros gerenciais. Começar com controles internos; emissão fiscal, cobrança bancária automática e portal do cliente ficam para fases posteriores.

## Comece aqui

1. Leia [regras e escopo](docs/ESCOPO.md).
2. Consulte [tarefas](docs/TAREFAS.md).
3. Para implementação com Claude, leia [CLAUDE.md](CLAUDE.md).

## Fluxo de trabalho

Bruno define prioridades e valida o resultado. ChatGPT ajuda a especificar e revisar. Claude implementa as tarefas no ambiente conectado ao repositório. O acionamento de cada ferramenta é manual nesta fase.

Cada implementação deve ocorrer em uma branch própria e ser entregue em pull request com descrição, testes realizados e limitações. Não considerar uma tarefa concluída sem evidências. Não alterar os mesmos arquivos simultaneamente em agentes diferentes.

## Decisões pendentes

- Hospedagem atual: Locaweb, plano não informado. Não é bloqueio para o piloto local.
- Destino futuro: VPS ainda não definida; nenhum deploy autorizado nesta fase.
- Validar ERPNext localmente, preferencialmente em ambiente reproduzível com Docker. Não iniciar um ERP do zero por padrão.
- Confirmar sistema operacional e recursos do computador de desenvolvimento.
- Ambiente de execução do Claude e suas permissões no repositório.
- Perfis de acesso e regras financeiras detalhadas.

## Dados

Usar apenas dados fictícios no código, exemplos e testes. Credenciais, contratos assinados, dados de clientes e backups não devem ser adicionados ao repositório.
