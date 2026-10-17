Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D308377A9E;
	Sat, 17 Oct 2026 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792238380; cv=none; b=gBYsuWoJAjqg0xExrX7llFyJ523i3QibOf49KibkzwytMkvR95dZneDzGLRDQ4zSuu6oY3o8qoKbv7bYMMyatBR70U7W7Lvk/ht/vrpclB2nB1raQkxvLxPtn0/2X772+jhAL9nzy3Os7pV7ABvGwBOI4diKo/7lqqm51ut5oSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792238380; c=relaxed/simple;
	bh=Rg+O0whlHvGMEyxRlqyGPWW+7RU+DNt9faLEtVqLyeU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k5DmSyB3Ib069zdcwhJpHTt8fK+Q2xYBMDSOP3k6jdOwc5WQFFQxF2l85o2+A3RBRGNasPT3ZF+J9UBGjVfCwwUEimd9ILTj7cXc/++Oy3IrTKKjrcQHaHG+eZMWqRGLYsSC3o2Dobm/jHd+hjSaQgw4nTR0F/H2HrCizabWByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=cpZfCK97; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="cpZfCK97"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 396BBA1568;
	Sat, 17 Oct 2026 13:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792238373; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=7eOadjvXvNY8wRcWPVKDe9x8GwetLNjio5IA6aOhh3g=;
	b=cpZfCK97PHNgLfl5/ThtZd0VN3afcBljc47pNB0iOTn8drPhtepkrkMojlstz/cLid7muT
	p8QeR2MiReHVbfh/laDnYOwGCts5gu2cTPBTUVK4BqB2izqmzYjVP423aWlM+m12dyOqdE
	kbjcOOjOQsW48QpQPiDpohzQAw+JhssRx8qAXJQlpI/jYy+BJfyhFawCCU6nXi0mPbKVnD
	3GvIsDVf+jzQbJVShult3aIdA72BApp03SxaNr2r9qztwT6SMEvfJNhpM3O6+tSxN1RzSq
	fq5qQY3x6TeEe/k1hUSDpsvnZw6iaHdQUH1jQf3p3olLEgbuUnVNjb8arA+RXQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 0/4] net: bcmgenet: fixes for a failed resume and the
 ring rebuild
Date: Sat, 17 Oct 2026 13:59:24 +0200
Message-Id: <20261017-nb-genet-fini-dma-net-v1-0-47e7c57f6834@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqCQBREf0XmuQvumgv1K9HDqqPdoFvsWgjiv
 7fW4xnmnBWZSZlxrlYkfjTr0wq4Q4X+Fm2i6FAYvvbB1a4V62SicZZRTWV4RNkh+NicSHdkaFH
 cV+Koy697QTng+h/zu7uzn/citu0LbXjU2n4AAAA=
X-Change-ID: 20261015-nb-genet-fini-dma-net-62a39ee14e65
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Mostly findings sashiko raised during my recent review sessions.

Patches 2 and 3 are the same failure, a resume that fails in
bcmgenet_init_dma(). The interface stays up with the datapath gone, and
the next ifdown hangs in napi_disable() with RTNL held. Patch 2 stops the
second teardown, patch 3 gets the interface open again instead of leaving
it detached with the clock released twice. Forcing the resume allocation
to fail reproduces the hang, the box then needs sysrq-b.

Patch 1 comes first because patch 2 sends one more case down the WoL
resume path, which calls phy_start() on a PHY the WoL suspend never
stopped.

Patch 4 is about the ring rebuild itself. The Tx coalescing threshold goes
back to the driver default whenever the rings are rebuilt, throwing away
what was set through ethtool. "ethtool -C eth0 tx-frames 16" followed by a
rebuild reports the default again.

Patch 1 fixes the rebuild path, not the cause. bcmasp parks the PHY in its
WoL suspend and has one deinit with a flag, which looks like the direction
for genet too. But one step at a time :)

Patch 2 is also prep for the next version of my MTU series [1], which
drops the "hallmark of a bad design" flag in favour of the ring pointers
it clears.

[1] https://patch.msgid.link/20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be@tipi-net.de

Patches 2 to 4 were tested on BCM2711 (Raspberry Pi CM4) with the resume
allocation forced to fail. The WoL paths in patches 1 and 2 are untested,
the board has no wake source.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Nicolai Buchwitz (4):
      net: bcmgenet: stop the PHY when a WoL resume rebuilds the datapath
      net: bcmgenet: do not tear the datapath down twice after a failed resume
      net: bcmgenet: let the interface be reopened after a failed resume
      net: bcmgenet: restore the Tx coalescing setting when the rings are rebuilt

 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 49 ++++++++++++++++++++------
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  1 +
 2 files changed, 39 insertions(+), 11 deletions(-)
---
base-commit: 8e2fbe0e75d38690d551456658194c632933cb57
change-id: 20261015-nb-genet-fini-dma-net-62a39ee14e65

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

