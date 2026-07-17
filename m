Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8225B21A
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317727; cv=none; b=N2lZ0zjswPklxgmulCD0aN2usfrfdaqXBvWT38qYv1GSL1/88anB5BLEOT/0FVG8vS8iHsXRH6iOakhUJau1+l66xUdZ9KkVVnnAtZJohkAQ9XBepzi1jmvWAT2sCniMr0wXxvIkdg9GdOAA26HtsY6a+tAYdHzCxZYUGh3XrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317727; c=relaxed/simple;
	bh=C+ojZmXBU0QYTJ7+g6RcVPC3pcKd7tXNMI8XJkf/TRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBm5m+aVqJs9D8tmjCASKiKyT7ixL9gHIqhPk3FG3uSTlC6td9It0z5f8Rv5zIMAalXQzLfoTjhnAENTJQ6KwFYg+y1K3z7+H0S2hE1fWrxgurbuB47NohCLLOqh/N2Lj35tY/W36/4MUU3SL8OCss9x5OvoD1YmO7Jhm9gN3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ijmisg8I; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ijmisg8I"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C9EB94E40E25;
	Fri, 17 Jul 2026 19:48:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9E89A60361;
	Fri, 17 Jul 2026 19:48:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17D1A11BD2964;
	Fri, 17 Jul 2026 21:48:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784317722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=e0wSWz1k4z2UbN3YLQw5n0S45oGEjbOFn/gAjWgHwuU=;
	b=ijmisg8IzVJ4vEp3AvjTfokeYpn3thmVB5Ko4i3khPqJ7+cXarMDPCxGMX21MQJUps5qEX
	lx10mi4u6cJM/WuAj1SB9482K3P+edur7CLuY2YpBnVjWnTwoue0buVTS3NPaLy5FaDS65
	CB2qx5d8v0qUmV2d+95LNGHLgntln/JXiKuw9QN2sWiSUrERucsP+3Hqqr1GF6IkyIAdVx
	N0ecxRjB2wDZPiTXSCYTSv8lS1MbqIXw4dGorJj0kT/DgXCwvlTa57EXYeem9difFDwN+i
	xdwN2Tj5KHZLvzPTUd7grsf/caG9V6aibr/5ybr3WL0JbCz/OtsRZCEhP57PKg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 17 Jul 2026 21:48:12 +0200
Subject: [PATCH net-next v4 09/15] net: macb: make `struct macb` subset
 reachable from macb_context struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-macb-context-v4-9-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
In-Reply-To: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

For parallel MACB context to start become a reality, many functions need
to stop operating on bp->ctx (the currently active context) and instead
work on a context they get passed. That context might be
(1) the new one that is getting allocated and initialised, or,
(2) the old one to be freed.

To reduce bug surface area, we will taint those functions to *only* take
a context and no `struct macb *bp`. That way, no bug of using `bp->ctx`
instead of `ctx` will ever occur.

For that, we need to embed a subset of `struct macb` information into
each context so that all helpers can still do their jobs. That subset
must be constant once probe is completed. Do this by taking a pointer
to a subset of macb called `struct macb_info`.

That subset is accessible from context (ctx->info->caps) or
from bp (bp->caps) using `-fms-extensions` option, thanks to
commit c4781dc3d1cf ("Kbuild: enable -fms-extensions").
https://gcc.gnu.org/onlinedocs/gcc/Unnamed-Fields.html

Add the structure and assign ctx->info at alloc,
but nothing uses it yet.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      | 31 ++++++++++++++++++++++---------
 drivers/net/ethernet/cadence/macb_main.c |  5 +++++
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 452b2c8f8641..2db01fa81559 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1290,6 +1290,17 @@ struct ethtool_rx_fs_list {
 	unsigned int count;
 };
 
+struct macb_info {
+	struct platform_device	*pdev;
+	struct net_device	*netdev;
+	struct macb_or_gem_ops	macbgem_ops;
+	unsigned int		num_queues;
+	u32			caps;
+	int			rx_bd_rd_prefetch;
+	int			tx_bd_rd_prefetch;
+	struct queue_stats	*queue_stats[MACB_MAX_QUEUES];
+};
+
 struct macb_rxq {
 	struct macb_dma_desc	*ring;		/* MACB & GEM */
 	dma_addr_t		ring_dma;	/* MACB & GEM */
@@ -1309,6 +1320,8 @@ struct macb_txq {
 };
 
 struct macb_context {
+	const struct macb_info	*info;
+
 	unsigned int		rx_buffer_size;
 	unsigned int		rx_ring_size;
 	unsigned int		tx_ring_size;
@@ -1324,6 +1337,15 @@ struct macb {
 	u32	(*macb_reg_readl)(struct macb *bp, int offset);
 	void	(*macb_reg_writel)(struct macb *bp, int offset, u32 value);
 
+	/*
+	 * Give direct access (bp->caps) and
+	 * allow taking a pointer to it (&bp->info) for contexts.
+	 */
+	union {
+		struct macb_info;
+		struct macb_info info;
+	};
+
 	/*
 	 * Context stores all its parameters.
 	 * But we must remember them across closure.
@@ -1335,17 +1357,14 @@ struct macb {
 	struct macb_dma_desc	*rx_ring_tieoff;
 	dma_addr_t		rx_ring_tieoff_dma;
 
-	unsigned int		num_queues;
 	struct macb_queue	queues[MACB_MAX_QUEUES];
 
 	spinlock_t		lock;
-	struct platform_device	*pdev;
 	struct clk		*pclk;
 	struct clk		*hclk;
 	struct clk		*tx_clk;
 	struct clk		*rx_clk;
 	struct clk		*tsu_clk;
-	struct net_device	*netdev;
 	/* Protects hw_stats and ethtool_stats */
 	spinlock_t		stats_lock;
 	union {
@@ -1353,15 +1372,12 @@ struct macb {
 		struct gem_stats	gem;
 	}			hw_stats;
 
-	struct macb_or_gem_ops	macbgem_ops;
-
 	struct mii_bus		*mii_bus;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	struct phylink_pcs	phylink_usx_pcs;
 	struct phylink_pcs	phylink_sgmii_pcs;
 
-	u32			caps;
 	unsigned int		dma_burst_length;
 
 	phy_interface_t		phy_interface;
@@ -1404,9 +1420,6 @@ struct macb {
 	struct delayed_work	tx_lpi_work;
 	u32			tx_lpi_timer;
 
-	int	rx_bd_rd_prefetch;
-	int	tx_bd_rd_prefetch;
-
 	u32	rx_intr_mask;
 
 	struct macb_pm_data pm_data;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 29bf3c497f2a..40ebe20bb40c 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3211,6 +3211,8 @@ static int macb_open(struct net_device *netdev)
 		goto pm_exit;
 	}
 
+	bp->ctx->info = &bp->info;
+
 	/* RX buffers initialization */
 	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
 	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
@@ -5870,6 +5872,7 @@ static int macb_probe(struct platform_device *pdev)
 	u32 wtrmrk_rst_val;
 	void __iomem *mem;
 	struct macb *bp;
+	unsigned int q;
 	int num_queues;
 	bool native_io;
 	int err, val;
@@ -5915,6 +5918,8 @@ static int macb_probe(struct platform_device *pdev)
 	bp->netdev = netdev;
 	bp->regs = mem;
 	bp->native_io = native_io;
+	for (q = 0; q < MACB_MAX_QUEUES; q++)
+		bp->info.queue_stats[q] = &bp->queues[q].stats;
 	if (native_io) {
 		bp->macb_reg_readl = hw_readl_native;
 		bp->macb_reg_writel = hw_writel_native;

-- 
2.55.0

