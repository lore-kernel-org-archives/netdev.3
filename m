Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114266;
	b=ypPxK2n1NwLdBrZ01BCi/PIo9DtzNePLvgI75rojOU88ZEiSqUHnJHTgR1MuB2L94g4w
	 0xscQWGBtfl9+5uyFnQeWjZMqKFub7owHuTReRJNwmoJGjuS0eVnULt4O2F+I5hhG1GwW
	 IMy4Jhm8sUvtxGaGyJdMV4mK3Z6jLW45iu8cEpc0Vw5Eyu5s5Eu3VvyA/Y3UviM/H4nT1
	 YI7O/z7C6inIabDPzVwL3r7drpy2C6lXZI3KMe/w4g8N2VipZz4PeDgWvTNjaQTDyiekr
	 yCh9IukfBEbCgFQtvT1ExCbHEBwT18xEQ1Kr9VMcYLgAsi3yAl5nTquxOUsKX1JGp4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114266;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=47NP/PYX9H8WhXFGuiSEfQYgXCHwbDC0hNK6ORbtpNU=;
	b=Z2qK+uNwBYQm0k8fwYjZ9gedWFOn1mR9AlyRlRvuzpBiifvslYzIeIC1P2UBxbdqpnhc
	 hcX5vZYMLPq8cPhIKA5Mli7/lbhOjmPjyiuHKv6rcOcd8t+oDIYDv+ii7ZKSJWCQmOrij
	 V1JV7fpt04M6COGrI2Puh+TBTdKow5vYInrWGbohYY/ukhW0Pf9w60iRwmRH9zU9ZF2ta
	 Lp6NCsjzSitTVhod3CsR3SlPcqyXiRq0fcYmkgOfduXxUMXAQF6gWk7O5Oev+Z6RTbHso
	 0GJKAYdyRUVJe8yw5lEiEF+nnLPOyUjKYDw1ataFHBqeH41jWshaesDnZKw4aCskaIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="oMTa/ju9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5B9606A31A;
	Tue, 27 Oct 2026 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMTa/ju9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF831F031E2;
	Tue, 27 Oct 2026 15:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793114265;
	bh=47NP/PYX9H8WhXFGuiSEfQYgXCHwbDC0hNK6ORbtpNU=;
	h=From:To:Cc:Subject:Date;
	b=oMTa/ju9Ixd+kJ9VWqX275nUfLHjQf3HaZ/Svrw9+zkX6n2Z3YkZuAppFYezCNXI/
	 xaAi6IcoATVevxfqrFOqn8WR5L+F96+uVe5CEOQWngysqqY5UxJLPDibZTAJcoRccU
	 7wE/txWnaZ0l2mFFp6byoPKkAoihXit2fud8z09xFa5Rc06SB6r914rQoqtZLxsg/e
	 yTFHoHVuVozzfld7fC3DSFivC77MqiWQhOF6VLBUq1fPJkhqZ+/ZLVSj0MAF59b0cz
	 +JunLM9NXVBCNyCqR3iBBhqYhKB2TNAsWB819Lr8e3bv9QdXGmAB9nB/m9J7rl84rn
	 sNuAE7cBLfOnA==
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
	Nitin Shetty J <nshettyj@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: octeontx2: fix building without DEBUGFS
Date: Tue, 27 Oct 2026 16:17:21 +0100
Message-ID: <20261027151737.386155-1-arnd@kernel.org>
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

Remove the #ifdef and waste the 8 bytes in the structure in this
config. Note that the debugfs_create_file() call end up ignoring
the arguments, so the actual debugfs implementation is still
ignored here.

Fixes: 45229e9a9ab5 ("octeontx2-af: Extend debugfs support for cn20k NIX")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I cannot tell why this showed up now and not earlier, so maybe the
'Fixes' line is misplaced. In randconfig builds, debugfs is almost
always selected by something else, while the octeontx2 driver is
usually disabled, so it does make some sense that this config
would be rate.
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index fb4870cd18e9..3b647e7b4bc2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -649,9 +649,7 @@ struct rvu {
 	int			mcs_blk_cnt;
 	int			cpt_pf_num;
 
-#ifdef CONFIG_DEBUG_FS
 	struct rvu_debugfs	rvu_dbg;
-#endif
 	struct rvu_devlink	*rvu_dl;
 
 	/* RVU switch implementation over NPC with DMAC rules */
-- 
2.53.0

