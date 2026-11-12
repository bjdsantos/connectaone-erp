# Tarefas

## T001 — Confirmar infraestrutura e escolher base

Status: aguardando informação de hospedagem.

Levantar provedor/plano, PHP/Python disponíveis, MySQL/MariaDB, SSH, processos persistentes, tarefas agendadas, HTTPS e backups. Não pedir credenciais no chat ou registrá-las no GitHub.

Comparar ERPNext e Dolibarr contra os requisitos de ESCOPO.md e as capacidades confirmadas da hospedagem. Consultar documentação oficial da versão escolhida. Registrar recursos nativos, extensões necessárias, licenças aplicáveis, custos operacionais e procedimento de atualização. Não supor compatibilidade com hospedagem apenas por haver FTP.

Aceite: decisão técnica documentada com evidências, limitações e passos reproduzíveis de instalação. Implementação depende desta decisão.

## T002 — Preparar ambiente de testes

Status: pendente de T001.

Instalar a versão estável selecionada, documentar execução, configurar variáveis por exemplo sem segredos e criar dados fictícios. Personalizações em extensão própria sempre que a base permitir. Preservar avisos e licenças do projeto original.

Aceite: instalação reproduzível, login funcional, persistência verificada, acesso sem login bloqueado e instruções de backup/restauração.

## T003 — Clientes e fornecedores

Status: pendente de T002.

Configurar cadastros, contatos, pesquisa e prevenção de duplicação. Reutilizar funcionalidades nativas.

Aceite: cadastrar, editar e localizar dados fictícios; testar duplicação por documento normalizado e permissões entre perfis.

## T004 — Contratos e serviços

Status: pendente de T003.

Configurar catálogo, vínculo cliente/contrato/serviço, designações, valores e datas separadas. Definir regras pendentes com Bruno antes de automatizar cobrança.

Aceite: um cliente com dois serviços de datas distintas; histórico de alteração; preservação de histórico após cancelamento; anexos restritos aos usuários autorizados.

## T005 — Financeiro gerencial

Status: pendente de T004 e definição das regras de cobrança.

Implementar contas a pagar/receber, recorrência e baixas manuais usando a base escolhida.

Aceite: reexecutar uma competência sem duplicação; pagamento parcial; cancelamento sem apagar títulos; conferência dos totais com exemplos conhecidos.

## T006 — Dashboard e preparação para operação

Status: pendente de T005.

Separar receita contratada, previsão, recebimentos, atrasos e margem gerencial. Validar exportação e restauração de backup. Documentar publicação conforme infraestrutura confirmada.

Aceite: indicadores conciliados com títulos e contratos de teste. Publicação e importação real somente após validação de Bruno.

## Registro de entregas

Em cada pull request informar tarefa, alterações, como testar, resultados observados, limitações e próxima ação. Atualizar o status aqui após revisão, sem declarar execução que não ocorreu.
