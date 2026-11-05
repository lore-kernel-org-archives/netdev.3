Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895592;
	b=WFsKpeqSCPAv7DHSfd354i8E4QuUlEJWJSN5k+1NNCXnNFiGwdwABOhnJDGkiZXp1dO0
	 cZFIdNp+5ee+KKx7buiBT5D9vMJRdGJBNbIaJcAFYFgeeH8LhiXxoeMExKPg+MUpc8Lqg
	 3/wkbQjNP3D4fuYg89FCA7WCH77uqmYmrGi1xwwBHrI+/KuBFJXkrINsDQoFx9BqAhxEw
	 AHicwVl/lU0HpQ7xr4/lJ9/ScCV0dZ7pZwIiwzkiRNUggyX2/BuLBHmzrv0Jq5JXkYZNX
	 MQ9KyQKdvPY5LC1BjA2lc9f1TJSFxZFoa6yKlWLG/soDd8X3wLodcR5EOm2I9zBjr0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895592;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EoM2i+eQHRF5VV0GC3rNF+d8cUNjkqLJFgpa8Ucl1/Q=;
	b=nHVSFV1gLaWTdUrNc1r/a/7tBBjcr/B6HZfyjlH/8c4LPe38ENP9H8zgiz6yiPOyc/3D
	 pjrfxl2bo5B3kybDMjrcacqZEnY79yHV/d/F4AI1NDd6dAEnyE50kQK1AHGxQC+u60/zk
	 SqU1RHhu848ahgp5ybYX5rQySUBR0T4lPz2Vr0rwtHEr0CipRcW9Hrhyi3aEL7fVVIyaf
	 nn+s1hwj+aNz6EjE6AN0h4CoP3QNWpXkGPgVZKq/nMavn1os5J66YlQuzyk28oRtirRET
	 Qzro1herT8XtsVh5cR2jV/fxVJzr2sk29uq0kfKtIvjy+B7Y8eaUdf3Q+7j5TSEaxoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHYonUDM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F897606A328;
	Thu,  5 Nov 2026 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHYonUDM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B74A1F000C1;
	Thu,  5 Nov 2026 16:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895592;
	bh=EoM2i+eQHRF5VV0GC3rNF+d8cUNjkqLJFgpa8Ucl1/Q=;
	h=From:To:Cc:Subject:Date;
	b=PHYonUDM/KL47elbybyVujQsXJOhFEzJpnzgmE7hfbhFklkCufM3UwAp7TjlIaSaV
	 qD11zn9Vfx/A7FmyUFDNVgjN27E+KDna1Nx94YyV+QFy7/p5mcMgrXhIs1ZGopEWWV
	 lF3Yx/dOvnmyiIysxyP9vN53rnBRQfrbGdw/IZ4dybeZ8SP+N2dDo6c6P1fnUQzyD+
	 i1a/7CyJjY2aYeLZuI1Uk5gVW8vvDRUD7IO+3mGX349wKddusCBMPWR9+UCgA1WEku
	 6YDhX9oOXbVvrx8PbeC4AXxLlAoavcatU+EqDmWOcz6FXDpcGPLEB67UR+wTR/cdDO
	 xzKia5vKu1d0A==
From: Arnd Bergmann <arnd@kernel.org>
To: Sunil Goutham <sgoutham@marvell.com>,
	Ratheesh Kannoth <rkannoth@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Suman Ghosh <sumang@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Nitin Shetty J <nshettyj@marvell.com>,
	Kiran Kumar K <kirankumark@marvell.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] net: octeontx2: fix building without DEBUGFS
Date: Thu,  5 Nov 2026 17:19:13 +0100
Message-ID: <20261105161945.1658464-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This error came up on my randconfig tests this week:

drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c: In function 'npc_cn20k_debugfs_init':
drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c:392:55: error: 'struct rvu' has no member named 'rvu_dbg'; did you mean 'rvu_dl'?
  392 |         debugfs_create_file("mcam_layout", 0444, rvu->rvu_dbg.npc,

The problem here is that the rvu_dbg member is hidden in an #ifdef
block, but the reference to it is not.

Remove the #ifdef and waste a few bytes in the structure in this
config. Note that the debugfs_create_file() call end up ignoring
the arguments, so the actual debugfs implementation is still
ignored here.

Fixes: 528530dff56b ("octeontx2-af: npc: cn20k: add debugfs support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix accidental build regression
    pick a better 'Fixes:' reference

I cannot tell why this showed up now and not earlier, so maybe the
'Fixes' line is misplaced. In randconfig builds, debugfs is almost
always selected by something else, while the octeontx2 driver is
usually disabled, so it does make some sense that this config
would be rate.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index fb4870cd18e9..a6183674c35f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -76,8 +76,6 @@ static inline int rvu_pcifunc_pf_mask(struct pci_dev *pdev)
 
 #define RVU_AFPF           25
 
-#ifdef CONFIG_DEBUG_FS
-
 struct dump_ctx {
 	int	lf;
 	int	id;
@@ -112,7 +110,6 @@ struct rvu_debugfs {
 	int npa_qsize_id;
 	int nix_qsize_id;
 };
-#endif
 
 struct rvu_work {
 	struct	work_struct work;
@@ -649,9 +646,7 @@ struct rvu {
 	int			mcs_blk_cnt;
 	int			cpt_pf_num;
 
-#ifdef CONFIG_DEBUG_FS
 	struct rvu_debugfs	rvu_dbg;
-#endif
 	struct rvu_devlink	*rvu_dl;
 
 	/* RVU switch implementation over NPC with DMAC rules */
-- 
2.53.0

