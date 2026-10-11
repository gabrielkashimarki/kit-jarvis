---
name: handoff
description: Escreve o documento de passagem de bastão da sessão atual e entrega o prompt para uma sessão nova continuar dali. Use quando o contexto estiver perto do limite, quando o usuário pedir para passar o bastão, ou antes de encerrar um trabalho que vai continuar outro dia.
---

# Passagem de bastão

Objetivo: encerrar a sessão sem perder contexto. Você escreve um documento e a sessão
nova começa lendo ele. Se uma informação não estiver no documento, ela se perde.

## Passos

1. **Escreva o documento** em `~/.claude/handoffs/AAAA-MM-DD-HHMM-<slug>.md`, com a data e a
   hora reais (`date +%Y-%m-%d-%H%M`) e um `<slug>` que diga o trabalho
   (ex: `2026-10-11-1642-deploy-crm.md`). Use o modelo em `~/.claude/handoffs/MODELO.md`.

2. **Registre a sessão** na pasta de notas, conforme a seção "Registro de sessão" do
   `~/.claude/CLAUDE.md`, antes de abrir a sessão nova. Se a pasta for um repositório git,
   commit e push.

3. **Entregue o prompt** para a sessão nova:

   ```
   Leia <caminho absoluto do handoff> e continue o trabalho descrito ali.
   ```

   No terminal, dá para abrir a sessão nova direto:
   `claude "Leia <caminho absoluto do handoff> e continue o trabalho descrito ali."`

4. **Pare.** O handoff existe porque o contexto acabou. Não comece tarefa nova nesta sessão.
   Se estiver no meio de algo que não pode ficar pela metade (escrita, commit, push),
   termine só isso, anote o resultado no documento e pare.

## Regras do documento

- Separe **fato medido** (com número, data e como foi medido) de **plano**.
  Plano que ainda não foi testado leva "(a validar)" e o motivo da dúvida.
- Não repita o que já está em outro lugar (spec, commit, PR, nota). Aponte o caminho.
- Segredo nunca entra. Só a referência do gerenciador de senhas (`op://...`).
- Caminhos sempre absolutos.
