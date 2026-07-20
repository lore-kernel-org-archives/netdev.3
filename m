Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6CB2EEE9D
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784585061; cv=none; b=mFQxkKkN9UQB8Egw2cF9yFDnHZ+JkTbbPqMLEQJIsPnuGYbcJMfykvHDrSohj8H/3/Ks2yIID/03qoIw1mDhnkKCC2fz3wHeQe3jACFaw0lDITQyAli70mUt/vJzPGlORgjngpNY0mPRmH1g2Q5t/X1UGH6r8Vz1CbOZ+h0F/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784585061; c=relaxed/simple;
	bh=RmHCCO+O0pTtoZeK7Fwa5PDy8mEd8EBfWiEAo1m6GHU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F38JWUBPv0MvM9HJCO5hEUQEjmlrmmek9+wRmMKf7uNbPW5VtPhod3cCl3iTYnvQUTkOb5E/6cqgdwH+gdLGR/luV1F+GQxvUryUiQO9NJ4XQYA1r6SUQZNVxMr79ASGRhvY2e0UVkybzHZvvjI2D/6y073O3VpiSkEpZHQ/pXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mpj3oC9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mpj3oC9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2051B1F000E9;
	Mon, 20 Jul 2026 22:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784585060;
	bh=PSplD8jI6MkBmStKJ+eF0cm33f9ueBjexlK28SjZ7v8=;
	h=From:Subject:Date:To:Cc;
	b=Mpj3oC9I/pGmmUm3s105UxPf7olm+f5Sj+2D4WBVVVQu6MYpsc2w6zmhInodSJEWk
	 7Uuzfka4d/J22TwLgSI3fo/eVYW10vYUlsqWoxRAvAtPQFIvKRD2YxRHHGiuhiL1Bs
	 z65F+qkKD4t/k2JMBdRKUUowonunioS4vQgCIC2tvtsxvonZfd7+pURXEUTj+JmLYl
	 K8rPooghUkcXEY9Divg2OFMaEyBPqcIHUMhV8D3lmY2/fuVONWgYKM/4wzZjEMpC6Y
	 GoGtndU0jKdw62P80HDKmFynepwEqYYf4wQrytF+KX7KsdXCdnNuiclP9/JiuxTd3l
	 vAurCAOfihfbw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v9 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Date: Tue, 21 Jul 2026 00:03:34 +0200
Message-Id: <20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QUWvEIAwA4L9y+DxHolbtPe1/jDHUxlZ2tIct5
 cbR/z7pyzoKMgKBEPIl5Mlmyolmdr08WaY1zWkaS9G+XFgY3NgTT12pmQChoQR3KU+D47QMyzT
 d+D2n9TPeXD9zr50zEEqywMr8PVNMj91+ZyMtfKTHwj5KZ0jzMuXvfemKe/8f/oocuQL0IrSR2
 ohvX5RHur1Oud/ZVRwpU6NEoYwSwTiHhFacKHmkbI2ShZJkSXZBRoPNiVIHCqFGKQ5cA9k2RGE
 juRPVHCmsUU2hAmJHYJXV3flX+kCJtkbpQlntgwboJPpwoswvZaB6lSmUV9hI3ymlhD1R9kjJG
 mULBdh417hgW6I/1LZtP3rqGYHaAgAA
X-Change-ID: 20260606-airoha-ethtool-priv_flags-b6aa70caa780
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3

Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
offload is created or destroyed.
Make dev->qdma an RCU pointer so the TX path can safely dereference it
without holding RTNL.
Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.

---
Changes in v9:
- Rebase on top of next-next main branch
- Link to v8: https://lore.kernel.org/r/20260703-airoha-ethtool-priv_flags-v8-0-015ba5ac89ee@kernel.org

Changes in v8:
- Rebase on top of next-next to fix conflicts.
- Link to v7: https://lore.kernel.org/r/20260701-airoha-ethtool-priv_flags-v7-0-b4153bd44428@kernel.org

Changes in v7:
- Fix ETS stats accounting in patch 2/3
- Reset ETS stats accounting in airoha_dev_set_qdma().
- Link to v6: https://lore.kernel.org/r/20260629-airoha-ethtool-priv_flags-v6-0-86bc600d31bc@kernel.org

Changes in v6:
- Rebase on top of next-next
- Add patch 1/3: "rename airoha_priv_flags to airoha_dev_flags"
- Drop patch 2/3: "refactor QDMA start/stop into reusable helpers"
- Link to v5: https://lore.kernel.org/r/20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org

Changes in v5:
- Add patch 1/3: use int instead of atomic_t for qdma users counter
- Protect dev->flags with flow_offload_mutex mutex.
- Introduce AIROHA_PRIV_F_QOS in order to handle better WAN/LAN
  switching.
- Link to v4: https://lore.kernel.org/r/20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org

Changes in v4:
- Move back QDMA TX/RX DMA enable to airoha_dev_open()/airoha_dev_stop().
- Configure GDM3/4 as WAN if GDM2 is not available in ndo_init()
  callback.
- Protect qdma pointer in airoha_gdm_dev struct using RCU.
- Rely on rtnl_dereference() to access qdma pointer in the control path.
- Add airoha_qdma_start() and airoha_qdma_stop() utility routines in
  patch 1/2
- Link to v3: https://lore.kernel.org/r/20260608-airoha-ethtool-priv_flags-v3-1-3e8e3dc3f715@kernel.org

Changes in v3:
- Do not introduce ethtool private flags support to configure LAN/WAN
  for GDM3/4 and rely on tc qdisc offload for it instead.
- Set GDM3/4 ports as LAN by default.
- Move QDMA TX/RX DMA enable from airoha_dev_open() to airoha_probe()
  and the corresponding disable from airoha_dev_stop() to airoha_qdma_cleanup().
- Link to v2: https://lore.kernel.org/r/20260607-airoha-ethtool-priv_flags-v2-1-742c7aa1e182@kernel.org

Changes in v2:
- Rework airoha_dev_set_wan_flag routine
- Enable GDM_STRIP_CRC_MASK in airoha_disable_gdm2_loopback()
- Do not always reset REG_SRC_PORT_FC_MAP6 in
  airoha_disable_gdm2_loopback() but use the same condition used in
  airoha_enable_gdm2_loopback().
- Link to v1: https://lore.kernel.org/r/20260606-airoha-ethtool-priv_flags-v1-1-401b2c9fe9f1@kernel.org

---
Lorenzo Bianconi (3):
      net: airoha: rename airoha_priv_flags to airoha_dev_flags
      net: airoha: fix ETS QoS stats counter underflow and cross-channel corruption
      net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload

 drivers/net/ethernet/airoha/airoha_eth.c  | 253 ++++++++++++++++++++++++++----
 drivers/net/ethernet/airoha/airoha_eth.h  |  26 ++-
 drivers/net/ethernet/airoha/airoha_ppe.c  |   9 +-
 drivers/net/ethernet/airoha/airoha_regs.h |   1 +
 4 files changed, 246 insertions(+), 43 deletions(-)
---
base-commit: 298bb2b8903323f6ef2eab4819a2e477765f0ff1
change-id: 20260606-airoha-ethtool-priv_flags-b6aa70caa780

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

