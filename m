Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F412D0602;
	Thu, 30 Jul 2026 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432954; cv=none; b=EXtGfvcLJAElLOiM0rBcNwzl3wRoGJYL7uLh2OxsxXPPAJhb8T/Lgu9JprRG0dpXz5sfZVk+kkQPO/1vWcEqlSIxM29j3gvzw+agjxeUpWa4MYQCQRm2kFxlMvPIxL2gyBI0MtbDW0zXx0p18ea6Qgb0HRu1SeJbGecrRi++psY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432954; c=relaxed/simple;
	bh=6AKWLtGif7r+vr72wU4kwdqfkXx5/kNLwiBtRyPgSQk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pW+3ierLVhL7BYcQZ45ee/JTmcabENM5jnaL1oGQrrSOKQfoqMAVftKMtXL0v5HZzXD4WhOO7RCJH42We7tBvj31TM+bm9C7rlz3M5bjkAiw/6GZFcfuAxLXUhy/jK4Ac9WwzOFj4QGrOXgYOj7bikzDvGiSr2YBohnxl/t9oAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1QOycIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1QOycIf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFF92C19425;
	Thu, 30 Jul 2026 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785432953;
	bh=6AKWLtGif7r+vr72wU4kwdqfkXx5/kNLwiBtRyPgSQk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=j1QOycIfLP0ggujU+x2BhN1E0ivukpWfOtviDmJQsRFEcTwY74y4LAmxB2PLalf/k
	 txrVKR10udJp60AdUFvZoXXRql/N2KDK//kIPmDD0HwwfBX2l2kkf0JAUpAIGlkC25
	 s1e4r7Y6ytlDQc0AcYMkUiNwsKUG2nrJV6Y8H1PL/8ARP94cYxb7SZEijjcTdDEws5
	 /VrN7YzdE2Nlk+kIvU/XvSjVnUKkArqOukAmy8pcDz3/FKvflFpr2iT4eLzdT5A5m8
	 qv6Qc2e5f0xht48OU/kiQ7++Ss6pbSbVcQApVzEw/TQEtkkmPrEj3yjSnTaJv24cbt
	 /X54hoQElGNJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF0DC5516D;
	Thu, 30 Jul 2026 17:35:53 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Subject: [PATCH v2 0/2] dpll: zl3073x: add Microchip ZL30643 support
Date: Thu, 30 Jul 2026 19:35:34 +0200
Message-Id: <20260730-for-upstream-zl30643-v2-0-0ea0bbd03755@free.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGaLa2oC/4WNQQ6CMBBFr0Jm7ZjS1gKuvIdh0cJUmiiQKTYq4
 e5WLuDyveS/v0IkDhThXKzAlEIM05hBHgroBjveCEOfGaSQRlRSo58Yn3NcmOwDP3cljFZYO6m
 kqVxTaQ95OjP58Nqz1zbzEOIy8Xt/SeXP/gmmEgWSbZSzuq9PXX3xTHT0DO22bV/OVpG0tgAAA
 A==
To: Ivan Vecera <ivecera@redhat.com>, 
 Prathosh Satish <Prathosh.Satish@microchip.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785432952; l=1540;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=6AKWLtGif7r+vr72wU4kwdqfkXx5/kNLwiBtRyPgSQk=;
 b=KPaiveD14ie456lg8mc4KK4inmbmJuzjR6fdxEdOvHIMUzTg/Y02mK50rNLH8MFnblKbfvoAM
 p/3eNgF2IPNAp91X77FGA0RhkkJLLM6bLOqCCu1YojWzp0ZniWl4E25
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

The Microchip ZL30643 (chip ID 0x0E3B) is a 3 DPLL channel member of
the ZL3064x timing family, register compatible with the
ZL30733 of the ZL3073x family.

Patch 1 describes it in the binding as a fallback to the register-
        equivalent microchip,zl30733.
Patch 2 adds the 0x0E3B runtime chip-ID table entry; no new match
        strings, the fallback binds via the existing microchip,zl30733
        entry.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
Changes in v2:
- bindings: describe ZL30643 as a fallback to the ZL30733 instead of a
  standalone compatible (based on Conor's questions).
- driver: drop the SPI/I2C/of_match additions: the fallback binds via
  microchip,zl30733; keep only the 0x0E3B chip-ID table entry needed
  for the runtime channel-count lookup.
- commit messages: comments on the datasheets and identity backing
  the REF_PHASE_COMP_32 flag reuse (Ivan's questions).
- Link to v1: https://lore.kernel.org/r/20260724-for-upstream-zl30643-v1-0-ea93ba4d85c8@free.fr

---
Vincent Jardin (2):
      dt-bindings: dpll: zl3073x: ZL30643 is compatible
      dpll: zl3073x: recognize the ZL30643 chip ID (0x0E3B)

 .../devicetree/bindings/dpll/microchip,zl30731.yaml   | 19 +++++++++++++------
 drivers/dpll/zl3073x/core.c                           |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)
---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260724-for-upstream-zl30643-8b23267b974f

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


