# Tarefas

## T001 — Validar piloto local

Status: pronto para levantamento do ambiente local; não depende da Locaweb.

Bruno autorizou desenvolvimento local e adiou o deploy até a VPS definitiva. Locaweb é a hospedagem atual, sem obrigação de instalar nela.

Proposta: ERPNext como primeiro candidato. Confirmar sistema operacional, RAM, espaço livre e disponibilidade de Docker no computador de desenvolvimento. Consultar a documentação oficial de instalação e desenvolvimento da versão selecionada antes de gerar comandos. Validar se o ambiente suporta extensões próprias, não apenas uma demonstração descartável. Registrar versão fixa, requisitos e limitações. Se houver impedimento concreto, documentar e comparar Dolibarr antes de mudar a base.

Aceite: decisão técnica registrada com evidências e roteiro local reproduzível. Não afirmar que uma instalação em ambiente remoto de IA foi feita no computador de Bruno.

## T002 — Preparar ambiente de testes

Status: pendente de T001.

Instalar localmente a versão estável selecionada, documentar execução, configurar variáveis por exemplo sem segredos e criar dados fictícios. Preferir ambiente reproduzível com volumes persistentes e instruções para iniciar, parar e restaurar. Acesso apenas local no piloto; não publicar na Locaweb, VPS ou por túnel público. Preparar o projeto para futura migração, sem executá-la. Personalizações em extensão própria sempre que a base permitir. Preservar avisos e licenças do projeto original.

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
