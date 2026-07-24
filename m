Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D413E717A
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902749; cv=none; b=sjb5qgDtJEsu++d/dLDC1wmyJaHwdNfFbzMwM8s3SbV71K5OIuaKRfPOHHr59Owstwby+ar6F6KjYsK4gV7u8HhPhupeKGXEqFLWcfQgZjrxZv+4GSPoFKVdnNtmnXXwSEfUphfXwoPMlY2pS8INyJxi3n8GEWSPl4B8nKvsl/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902749; c=relaxed/simple;
	bh=vxLmvV2FPxB3t1qvi92MNcewxDk1OrNRROUGmE2MUMc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p3VUAdIBjKl+sfBR8+qxMiBJnIFArClmFSgchIyokaBMaCZj/i35M6L99Wye4sT1qHAc/3lSGd+FtQPuKcKzZbrp2FaJ4QtnLzIsZW3koJCVMY/QDLnaPcVIVWtvWxJMAc+WpEr9gSD1bDImu/b2eM8B22zJ+vJjo2KUjsi+t4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNa/E+nG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNa/E+nG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE841F000E9;
	Fri, 24 Jul 2026 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784902748;
	bh=w16N+gmlA9SuSN3UmkLfo1vNsAr7c85IjJ3qqIHHzzM=;
	h=From:Subject:Date:To:Cc;
	b=FNa/E+nGHuuP22o4LRiBTvZSk3Xk3iuHfhhGXqphx2rr8jGQO/fBqlqSGLIM/HB82
	 kx9ztVb/rOiwxrEFPgtAvhAuEXwUbf9HP1LvgCSuSxIk5t3T3q9tgL6T9xXFcrzmqs
	 r5T+8v5GR1hQMjanr/XWeqZYlBxtUwaqh2znF8FZWyzqE3uB8Wub+/nJ62VJD+Wrsv
	 /sObQscR693qBxLAMrCsKR3BxeLq5V89Oh7V5nDGeaaH6ZMQ5j7oLxcH3vXLxgJ/3B
	 0DL5NgdN5doTvURpHU4IUYwal9OKkHn1VSLYlN+oTAZf23D8JuOUCi0idaDO8tFW2k
	 H9DGvHSq+fq6A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v11 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Date: Fri, 24 Jul 2026 16:18:55 +0200
Message-Id: <20260724-airoha-ethtool-priv_flags-v11-0-686dea300a40@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43S22rEIBAG4FcpXtfieLZXfY9SiofJrnRJFhPCl
 mXfvZKbWgQpgqCD3/zI3MmKJeNKXp/upOCe17zM9QDw/ETi2c8npDnVC8IZ16wu6nNZzp7idt6
 W5UKvJe+f08WfVhq094bFullG6vtrwSnfDvydzLjRGW8b+aiVc163pXwfXXc46v/wd6BAJYPAo
 5vQTfD2hWXGy8tSTge785YyI4pXykgejfeAYHlHiZayI0pUSqBFkaKYDKiOkg0FbERJyqhmaF2
 cuJ3Qd5RqKRhRqlIRICGz0urU/5VuKO5GlK6U1SFqxpKAEDvK/FKGDVOZSgUJSoQkpeS2o2xLi
 RFlK8VABa98tA6xo1xD8WEqVykXQSUbDHilOwpYa/HhjNZUNHGleVQpOfl3sh6Pxw8U04apcwM
 AAA==
X-Change-ID: 20260606-airoha-ethtool-priv_flags-b6aa70caa780
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Madhur Agarwal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3

Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
offload is created or destroyed.
Make dev->qdma an RCU pointer so the TX path can safely dereference it
without holding RTNL.
Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.

---
Changes in v11:
- Fix possible bql races moving the net_device between different QDMA.
- Use atomic APIs for airoha_gdm_flags.
- Link to v10: https://lore.kernel.org/r/20260722-airoha-ethtool-priv_flags-v10-0-d2562c5dd942@kernel.org

Changes in v10:
- Fix a theoretical race condition between tx completion NAPIs moving the
  net_device between different QDMA.
- Rebase on top of next-next main branch
- Link to v9: https://lore.kernel.org/r/20260721-airoha-ethtool-priv_flags-v9-0-9c15d8b71a56@kernel.org

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

 drivers/net/ethernet/airoha/airoha_eth.c  | 267 ++++++++++++++++++++++++++----
 drivers/net/ethernet/airoha/airoha_eth.h  |  33 +++-
 drivers/net/ethernet/airoha/airoha_ppe.c  |   9 +-
 drivers/net/ethernet/airoha/airoha_regs.h |   1 +
 4 files changed, 265 insertions(+), 45 deletions(-)
---
base-commit: 89d8006259b81dd25c962f6cc8d7ab268d6ea426
change-id: 20260606-airoha-ethtool-priv_flags-b6aa70caa780

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

