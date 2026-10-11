# Regras globais

Este arquivo é lido por todo agente do Claude Code, em qualquer projeto, antes de começar.
Troque o que está entre `<>` e apague as seções que não servem para você.

@~/.claude/memoria/MEMORY.md
@~/.claude/regras/sessoes-paralelas.md

## Quem eu sou
- `<Seu nome>`, `<o que você faz>`. Empresas: `<Empresa A>`, `<Empresa B>`.
- Responda sempre em português brasileiro.

## Comunicação
- Seja conciso e direto. Sem preâmbulo, sem repetir o que acabou de fazer.
- Faça sozinho tudo que der (CLI, API, leitura de arquivo; backup antes de mexer).
- Só me pergunte decisão importante de verdade ou o que exige autorização minha:
  apagar sem volta, force push, gasto, painel em que você não tem acesso.
- Relatório com número absoluto e variação %, sem esconder piora.

## Código
- Prefira solução simples e legível a abstração prematura.
- Comente só o que não é óbvio.
- Ao editar código existente, siga o estilo do arquivo.
- Rode testes e lint antes de dizer que terminou.
- Em bug, ache a causa raiz antes de corrigir.
- Não crie README ou documentação extra sem eu pedir.

## Git
- Commits pequenos, mensagem curta no imperativo (ex: "corrige validação do formulário").
- Ao terminar uma tarefa, commit e push, mas só depois que testes e lint passarem.
- Nunca commite segredo, `.env` ou credencial.
- Nunca use `push --force` sem perguntar.

## Credenciais
- Credencial nunca passa pelo chat, nem em log, nem em código.
- Busque no gerenciador de senhas pelo CLI. Exemplo com 1Password:
  `op read "op://<Cofre>/<Item>/<campo>"`.
- Ao citar uma credencial, use só a referência (`op://...`), nunca o valor.
- Para rodar app que precisa de segredo, use `op run --env-file .env`, com o `.env`
  contendo só referências `op://`.
- Credencial nova vai para o gerenciador na hora, no cofre do cliente.
- Se o CLI tiver limite diário de requisições, peça tudo de uma vez, no começo.

## Memória
Regra completa em `~/.claude/memoria/COMO-USAR.md`. O resumo:
- Fato técnico durável sobre mim ou sobre a máquina vira um arquivo em
  `~/.claude/memoria/fatos/`, um fato por arquivo, e uma linha no `MEMORY.md`.
- O `MEMORY.md` é índice, não conteúdo. Teto de 5 KB.
- Antes de criar, procure um arquivo que já cubra o assunto e atualize esse.
- Memória errada se apaga. Memória que cita arquivo, função ou flag se confere antes de usar.

## Registro de sessão
- A cada marco (commit, decisão fechada, número medido), anote em
  `<pasta de notas>/logs/AAAA-MM-DD-<assunto>.md` o que mudou, por quê, e o commit.
- Não deixe para o fim: a nota é o que sobrevive quando a sessão enche ou cai.
- Se a pasta de notas for um repositório git, commit e push a cada registro.

## Passagem de bastão
- Quando a sessão estiver perto do limite de contexto, ou quando eu pedir, use a skill
  `handoff`. Ela escreve `~/.claude/handoffs/AAAA-MM-DD-HHMM-<slug>.md` e me dá o prompt
  para a sessão nova continuar.

## Contexto
- Busca ampla em código: delegue a um subagente e peça só a síntese com `arquivo:linha`.
- Leitura pontual, comando curto, edição direta: faça direto.
