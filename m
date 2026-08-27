Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.79.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36D381AF0
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.79.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787799337; cv=none; b=rywZh7Vc7MR6Eq5brBjVPjy4K2wsA9VXw9++QeFUGO9Z8WtjLlBP29+ptruxFO/WDgLB0qG9ZIywixc3+TNnKDNmemZ7I3zDdpFJtUL+oJZsR/aLtxl5Clc3k16YyBqyXIOqKdKTaqUEdM/C4czqVKXxkSCD5dhgNNucHROOL5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787799337; c=relaxed/simple;
	bh=CqJYyk93cRk5aUtMm56ZAmFrER7CnGCNWNBB4HXjfz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSQtmEFDgmswjeMEiqyGhBdvGphLE7QoqHIfClfTqKehurLdY5h0iT+3jL+ncE/rXBvx/VzczdJCIxVabQQAxhyprDHZFO/FBd6h9m4pr6pItBUEMttoZWvjO91QglhesdYJvdKVCezEkOGdgAaq8kvjH7eiAxKuSRxcYMkgVkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=cP50c20M; arc=none smtp.client-ip=114.132.79.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="cP50c20M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1787799285;
	bh=zVE2SzTabNG8jcZz0PwA/kz3j8ilu3QHZ2JTIs77byU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=cP50c20MotK2IRTAFxvMSOl+Uc8SHTpOQRHruwxSCyMc/F5lFbyDdGkMwgvpAjtfy
	 3plJl2xvhCooCa9BkkRWQa+fx3m/bi2KdFTyMCeJWofxgdx0PTxWO4skukHSsJi+Oq
	 3EBCpm3iAqY4VJ4T/gc9mkopnRmt7pC3SplLghDs=
X-QQ-mid: esmtpsz17t1787799270td1fb8d54
X-QQ-Originating-IP: RlPSDMQ0IW+5J7jKbMsuzznADAl+ByN6fHqr9Ry+Dps=
Received: from PEN002676 ( [1.202.39.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 27 Aug 2026 10:54:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9149043113890004404
EX-QQ-RecipientCnt: 16
From: ZhaoJinming <zhaojinming@uniontech.com>
To: netdev@vger.kernel.org,
	maxime.chevallier@bootlin.com
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	boon.leong.ong@intel.com,
	weifeng.voon@intel.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	ZhaoJinming <zhaojinming@uniontech.com>,
	joabreu@synopsys.com,
	f.fainelli@gmail.com
Subject: [PATCH] net: stmmac: stop DMA before freeing descriptors on open
Date: Thu, 27 Aug 2026 10:54:15 +0800
Message-ID: <32EB352EB66D74E7+20260827025415.2684733-1-zhaojinming@uniontech.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NZ7AOwlfFyuSKHOsjpI4cG5tTQH3WKvmY1HT+hHT6M6honuBAGe3Ulo2
	iFI58335+I3u/0azEMdhAYwxSfAHmMlKqmNwBu+ZJSivA743SaqC1ZBDRxu5Ba1JJ4VuWpG
	zBYdFMWg7XTc/Kn4dxEIzKo8b/zJlzp9jWesMbnvftzNzpkmMQkh/TdbooRLVoWfM+gV5XI
	n5YqKAoXDW/9EnbCT02PY6JbVPEkhzHvxHHFYENwGAqaCvhHxigA1rSnImgLPCMwghEIUCD
	c5TjqwSSC5F6cXGlP9EKVn7ZBte2w/Sj6nlN56aRQISTVeVdVT0rmxkE0tkkoAQzZ+szziI
	VQjZUuz5DkE7Ms4lhYWNwdHNxgO6Re/YjiVsjTYT06Wru1tL0oMPURCiPDpovvCT8nUJHuX
	t9a69UMJWMn194/ziKUoHGIgC76kv0PZwl/QOAIiCVtYOtYlfiKZ1U11oxs1mc7sQkDTcxE
	n3Nd1jW37II16/zXj1FyhGDknFcTyyFKB9gW51Vek4mUAVKFYWuy00juV8cf4UOFvXXzBbK
	Rl5w9ubm9ImciX7292NoVMFq8v2efbezWMSKZ5rZBnUEMCe3KYKTxMxJAQRzQPscuXw7kh6
	ZOd9l1yaKVK7ySbbQhMbwOCDT8tV//leM/t8MuCNBWGJAubT73rQSs4PILTgVF62xNYSYGK
	ifG8PFdKVuG/ljcZFa/hITRYZ3HlfHTkz1oKqITWrKx9eB4YRtl330/9frBKAiSmFGsKAW7
	GXGQTBjRHw6ee8Xoh6mGAnCvdMEVTyBBXnO5OIyJUhjvcESpeXk3nbjzjEX+Qd9QohAG8Qb
	ZeiWtKiKj9CVnBTrXSo2mB8JBJskZGzIql1XOdBvl10iq87IaAmaDd8Zos4HWlAA2c/+cRs
	8tvBtMs5vQ7fIYqOM3c3RIYyO4KFr4PRsLAYLpNwrxsisMyFhdttIwDnsQMLTPUe6BIIAZb
	Rmd7FWzD4V9kW2tzdN7xDqOXxLaJ7tyb7JPcrw94z9oyj69swPAQ/G0lg6c5fazMFeuI/G5
	erfDh2IOf63mmzPJ2oWiLClZNYfQ0=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

In __stmmac_open() and stmmac_xdp_open(), the DMA engine is started
before stmmac_request_irq() is called.  If the IRQ request fails, the
clean-up paths free the DMA descriptor rings via dma_free_coherent()
without stopping the DMA engine first.

With the DMA engine still running, hardware may continue to access the
descriptor ring memory after it has been freed.  Add stmmac_stop_all_dma()
to both error paths, matching the teardown order in __stmmac_release().

Fixes: 8532f613bc78b ("net: stmmac: introduce MSI Interrupt routines for mac, safety, RX & TX")
Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b2b7d0242dd3..f76d762c314c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4176,6 +4176,8 @@ static int __stmmac_open(struct net_device *dev,
 irq_error:
 	phylink_stop(priv->phylink);
 
+	stmmac_stop_all_dma(priv);
+
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
@@ -7203,6 +7205,8 @@ int stmmac_xdp_open(struct net_device *dev)
 	return 0;
 
 irq_error:
+	stmmac_stop_all_dma(priv);
+
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
-- 
2.51.0

