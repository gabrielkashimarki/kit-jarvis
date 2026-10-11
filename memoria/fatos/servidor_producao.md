---
name: servidor_producao
description: Onde a produção roda, como fazer deploy e o que já quebrou; ler antes de qualquer deploy
type: reference
---

Produção em VPS `<provedor>` (`<IP ou host>`), app em `/opt/<app>`, compose com web, worker e navegador.
Senha root em `op://<Cofre>/<Item>/password` (nunca imprimir).

Deploy: `./scripts/deploy.sh <imagem-web:sha> <imagem-worker:sha>`.

**Por quê:** o `.env` fica em `/run` (tmpfs) e some no reboot; gerar de novo com `op inject` antes do deploy.
**Como aplicar:** reiniciar o container do navegador exige recriar o worker que usa a rede dele junto.

Relacionados: [[autonomia]]
