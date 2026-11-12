# Orientações para implementação

Leia README.md, docs/ESCOPO.md e docs/TAREFAS.md antes de trabalhar.

## Papel

Implementar uma tarefa por vez, preservando decisões e requisitos registrados. Bruno é o responsável pelas decisões de negócio. A proposta é validar ERPNext em um piloto local antes de confirmar a base.

## Primeiro passo

Comece por T001. Locaweb é a hospedagem atual, mas Bruno autorizou desenvolvimento local até a VPS definitiva. Não aguarde dados da Locaweb para avançar. Confirme o ambiente local, valide os requisitos oficiais do ERPNext e prepare uma instalação reproduzível para desenvolvimento com extensões próprias. Não publicar a aplicação nem abrir túneis públicos nesta fase. Se não tiver acesso ao computador de Bruno, entregue o roteiro local e declare onde os testes realmente foram executados.

## Entregas

- Trabalhar em branch específica e abrir pull request quando o ambiente permitir.
- Se não houver acesso de escrita ou execução, informar a limitação; não afirmar que publicou ou testou.
- Priorizar recursos nativos e extensões da base open source selecionada.
- Evitar modificar diretamente o núcleo da base.
- Incluir testes proporcionais, especialmente para valores, recorrência, permissões e integridade dos dados.
- Documentar comandos executados e resultados, sem expor segredos.
- Não adicionar dados reais, credenciais, arquivos .env, contratos privados ou dumps de banco ao GitHub.
- Não contratar serviços pagos nem publicar em produção automaticamente.
- Não remover histórico nem executar migração destrutiva sem revisão.

## Comunicação

O repositório é a fonte compartilhada de especificação e código. Ele não ativa automaticamente ChatGPT ou Claude. Registrar dúvidas e resultados na entrega para revisão posterior.
