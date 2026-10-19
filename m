Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2554973B7;
	Mon, 19 Oct 2026 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403580; cv=none; b=Scix0jNrysAFI79jNAIENkAJKRHGfG05xtbsD8sdjIkTVeH5TQFYmAjOc9zooIB8GbXyBM6aK61L2Qm8/8fEqMcZH8zS2xp7mcGi0riu/eZh3SMQ/g3YhkOM3i44+ct+r2vJ2jlmEDQfK7lwgmtfC96n0wuMficNrD8xHc12igg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403580; c=relaxed/simple;
	bh=VFYuJAXrjQsTzeG36wAA+0ZLuJ5TGfdekwusZYoOqW4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iZAMHhsWpt7lCZDUTt9hhN1gs4OEc9JLQdMYOk0PQO8tn9UUSXhs+tZO8EYvOx8tABJahK/nu95Tb0K0RnwrLJbjyirU7oQnnAF6MmBx9jY2JnIWMEYHCNtMGG5Ek39bcz9ptQDbFvtU7mLNrETUfsxj59FG7ZsmOshWv/lev7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=LJXi89jo; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="LJXi89jo"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B36F3A02DC;
	Mon, 19 Oct 2026 11:52:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792403576; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Juyv/i4vb/Sxzh2/L0ghawLIYk7uQZQCgmAALNgCVVM=;
	b=LJXi89jo8Y9B8AjP0LGeXGDRFCZY7Lko6hwsZO1lhRLxeAJ1Fww9zUrPmya29HCIElEJIQ
	qkupQuezANCM3Um0iHJ6YL8ieqmYdaoSWGDk1WOjZGXXRv62608NlAADlKNohwsmPCY2j7
	xRW9d7e4Fk9Ky+V2KjwcyDFMFIycv2zN2GghP2VbSRuDEddVwpFtzPx3nPUHwPxv9VELWZ
	hGcSNQhSZmd0S8vDMbHQc347zs6YtLAf8H8c1v2VvoF3mLj6WtuF+zwzm0kOMjkxhJfl4z
	g3jFIegZryzJjXy3fJRbj3laTU89XIoIgCrAc5AA+IsiHkP5QbghP3PgEbHDww==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v2 0/2] net: bcmgenet: fixes for a failed resume and
 the ring rebuild
Date: Mon, 19 Oct 2026 11:52:46 +0200
Message-Id: <20261019-nb-genet-fini-dma-net-v2-0-b85f6b92654a@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2jG0lFZd+R+GBY8BxsRC2ko0h
 H+3Rbcu78y596zgyTF5uGQrOFrY82RjkIcM2rG2AyF3MYPMpRa5KNE2OJClgD1bxu5RYwpa1sW
 ZSCjSJcTu7Kjn1757gwhA9T36Z3OnNqTFhI3sw+Teu30RO/wTmT+iRWCOypBpS9PrU6GugWdOr
 2NHUG3b9gEPLyoG0wAAAA==
X-Change-ID: 20261015-nb-genet-fini-dma-net-62a39ee14e65
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Justin Chen <justin.chen@broadcom.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

This is v2 of my resume and ring fixes for genet. After some further
testing and local LLM review rounds I squashed v1 patches 1 to 3.

Mostly findings sashiko raised during my recent review sessions.

Patch 1 is a resume that fails in bcmgenet_init_dma(), which leaves the
interface up with no datapath and the next ifdown hanging in
napi_disable() with RTNL held. It is one patch because nothing that
resume leaves behind is reachable on its own, the second suspend never
returns until the hang is fixed.

Patch 2 (was patch 4 in v1) is the Tx coalescing threshold going back
to the driver default whenever the rings are rebuilt.

Patch 1 fixes the rebuild path, not the root cause. bcmasp for example
parks the PHY in its WoL suspend and has one deinit with a flag, which
looks like the direction for genet too. But one step at a time :)

Patch 1 is also prep for the next version of my MTU series [1], which
drops the "hallmark of a bad design" flag in favour of the ring pointers
it clears.

[1] https://patch.msgid.link/20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de

For backports: the WoL hunks in patch 1 need 254f3239dd07, on older trees
they can be dropped. The rest applies on its own.

Patch 2 and the hang in patch 1 were tested on BCM2711 (Raspberry Pi CM4)
with the resume allocation forced to fail. Everything on the WoL path is
untested, the board has no wake source.

Florian, Justin: If you have a setup to test this, I'd appreciate it!

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Changes in v2:
- Squashed v1 patches 1 to 3 into one, each was either a no-op or left a
  broken tree on its own
- Turn HFB off on the suspend early return, it stayed armed as a wake
  source (sashiko)
- Second Fixes tag for the WoL hunks
- Let PHY_ERROR reach phy_stop() too (sashiko)
- Link to v1: https://patch.msgid.link/20261017-nb-genet-fini-dma-net-v1-0-47e7c57f6834@tipi-net.de

To: Doug Berger <opendmb@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Justin Chen <justin.chen@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Nicolai Buchwitz (2):
      net: bcmgenet: recover from a failed resume
      net: bcmgenet: restore the Tx coalescing setting when the rings are rebuilt

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 56 +++++++++++++++++++++-----
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  1 +
 2 files changed, 46 insertions(+), 11 deletions(-)
---
base-commit: 8e2fbe0e75d38690d551456658194c632933cb57
change-id: 20261015-nb-genet-fini-dma-net-62a39ee14e65

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

