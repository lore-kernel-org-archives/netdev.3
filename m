Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990530BF5C
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.209.48.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454079; cv=none; b=DhW+kZNTXqzjdEbJObrQjv1XmiCBh+ZdZa/CfyLpt1bN84aEpDIMwebp3w8gkD6cNNuO4QHI1x4vLzYLvuFoDTZrCzirHPcNUgGgGJG4aVdceIFgd0nyUSMYKvgTgeOUw60di5um2wtNU2VmbHMalCPV6PYia/BM0G7ZrnlMXGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454079; c=relaxed/simple;
	bh=LRY7jf5m1KSF/1e0niUt9o6AooBOSZaXqOJ04f0uDTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0Dt/GV9OZn1ESvlmJ6AvrpZ0t/IVCRXTbMwEWR7SBI62McRNSwH77ZKRrQC3z5TDvCap8es0PhWeiNfcojYFyJ8IAkM10He6TA47ojn5YhOLhB/5nrymB7z4AZ7FDJzNvEKmBBmp411w00uJ92CE09I3Z94aRVGAw99L4K57iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agner.ch; spf=pass smtp.mailfrom=agner.ch; dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b=jEWu6VgA; arc=none smtp.client-ip=178.209.48.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=agner.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agner.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="jEWu6VgA"
Received: from allenwind.lan (unknown [IPv6:2a02:169:3c38:10::3a0])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 316905CD106;
	Tue,  7 Jul 2026 21:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1783454074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3NpIc8JZ08lCs6TTHGP7X1cz/YqBmnc+QKbmFf0dIk=;
	b=jEWu6VgA3R7UyzMjcKI1AAh9/uw2KVhDn2V3vKUuP3vWJgafj6du0Q8IQCV2IJiNJjlHT6
	QH2cpRg9WpF1Csu9dbajDtM1xorXMuc+hFkCz7yn1/A4F1a9XXT7NnsSp1x7CHCQRtE3Zg
	6YhopjV6+pbvB1b7ioeUOb2c54Eo1us=
From: Stefan Agner <stefan@agner.ch>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	regressions@lists.linux.dev,
	Stefan Agner <stefan@agner.ch>
Subject: [PATCH net v2] net: stmmac: resume PHY before hardware setup when opening the interface
Date: Tue,  7 Jul 2026 21:54:25 +0200
Message-ID: <20260707195425.405989-1-stefan@agner.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <message-id-of-your-v1-mail>
References: <message-id-of-your-v1-mail>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the referenced commit, changing the MTU on a running interface no
longer disconnects and reconnects the PHY; __stmmac_release() merely
stops phylink, which also suspends the PHY (BMCR power-down) when WoL
is not enabled. __stmmac_open() then performs the DMA software reset in
stmmac_hw_setup() before phylink_start() resumes the PHY again.

IEEE 802.3 22.2.4.1.5 allows a PHY to stop its receive clock while
powered down, and stmmac requires a running receive clock for the DMA
software reset to complete (the phylink config sets mac_requires_rxc).
On such setups, e.g. the RK3566-based Home Assistant Green with an
RTL8211F-VD PHY in RGMII mode, any runtime MTU change now times out and
leaves the interface dead:

  rk_gmac-dwmac fe010000.ethernet end0: Failed to reset the dma
  rk_gmac-dwmac fe010000.ethernet end0: stmmac_hw_setup: DMA engine initialization failed
  rk_gmac-dwmac fe010000.ethernet end0: __stmmac_open: Hw setup failed
  rk_gmac-dwmac fe010000.ethernet end0: failed reopening the interface after MTU change

In the field this is triggered by NetworkManager applying an MTU while
activating the connection, breaking networking entirely.

Resume the PHY in __stmmac_open() before the hardware setup, making it
the counterpart of the phylink_stop() in __stmmac_release(), like
stmmac_resume() already does for the same reason. phylink_start() also
resumes the PHY, but only after stmmac_hw_setup(), and it cannot be
moved before the hardware setup since it may bring the link up
immediately from a workqueue, racing with the initialization (see the
comment in stmmac_resume()). For the regular ndo_open path the PHY has
just been attached and is not suspended, in which case
phylink_prepare_resume() does nothing.

Fixes: db299a0c09e9 ("net: stmmac: move PHY handling out of __stmmac_open()/release()")
Link: https://github.com/home-assistant/operating-system/issues/4858
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v2:
- Move the PHY resume from stmmac_change_mtu() into __stmmac_open() so
  that it also counters the PHY suspend caused by __stmmac_release()
  (suggested by Andrew Lunn), placed before stmmac_reset_queues_param()
  to match the ordering used in stmmac_resume()

 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4147,6 +4147,15 @@
 			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
 	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
 
+	/* The PHY is suspended when the interface is reopened without
+	 * disconnecting the PHY, e.g. on MTU change. IEEE 802.3 allows PHYs
+	 * to stop their receive clock while powered down, but the DMA
+	 * software reset in stmmac_hw_setup() requires a running receive
+	 * clock, and phylink_start() below resumes the PHY only after the
+	 * hardware setup. Resume a suspended PHY here first.
+	 */
+	phylink_prepare_resume(priv->phylink);
+
 	stmmac_reset_queues_param(priv);
 
 	ret = stmmac_hw_setup(dev);
-- 
2.49.0
