Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700332;
	b=ZQiaE6W1qbdWATwX3SzAjW81XzAKrlF/MguDlV9rpQOWQwrnRD86qZPaAhvGsX5Uj4ow
	 zuItu2grmZlnIKRp6s+JOeM/fmg2i70XA1RLFeKCXbGlPkwgpiYdWRekdM1EJ+JAG7fYv
	 P8OHJXPPT/30G8CCZCl5WlR5QtSCIXWi1gOMmH4sakl9Yr2yjVVUCXXDbqC7S3zftnBbl
	 laMatZpO58Sg8w9Pol/oXxGyBB8jO+lIJOYr1Ney4EjQJx81B8p0UCor6JV6kgFK5wRjw
	 NGAOOBuVxk2OIc9I7ra0VFr4bXfwgVN1q5zUG1Bv/bBIkmA28ubNsDmkOg+h0SqAWlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700332;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=crorAxXvnKsE7T5XLx1xJ9nM/l4kKcvMxg6tXRH0Qrk=;
	b=nv7oyp8KeO9vh1ipbftcmZbOw64h9ctOjorE5Kkd3/absZFSmR+HnC1YZUc4vkY5tNYf
	 w8+FIphTUUsTtdXRp6oFW8K5v/lDgDa9iAJyKu1k6iEXePsXa+COkxkbzGduFt/J6tYL4
	 7AP1RUoV9QD0rvfuxKiMTUrmyUtKdA5TujujCyoK02a09PSefvALQcAbbvCaFHiP+PK0D
	 7VcDeXpC88zx3+0ZeQ4dMQWfsEsHSEbfynb71It45Uw4RP/s1qX3bnkRAb/lcY6U5Bn3u
	 uUh+oDXiNtpiUQ3tgUUbc7XvrGEUxBFsWOXxn8Mo/7OK7tomWC326fhoLYTkqVFDxFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=497tw1HG;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F55606A827;
	Tue,  3 Nov 2026 10:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33F55606A827
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=497tw1HG
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 08C1FA1651;
	Tue, 03 Nov 2026 11:05:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793700330; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=crorAxXvnKsE7T5XLx1xJ9nM/l4kKcvMxg6tXRH0Qrk=;
	b=497tw1HG5tTvPHnKBcyLAHMQUIaLSVTHFgVkIHqnaFIwgR8ebbEXDhdlkHxi9jPN9+84an
	MBs6izTJyvlsQE7oAqluFd6srtrXEWr4Hcv+k2HiZkutjMEYEZLWombC3ZvWGujIpCjald
	x4vXIYF396TC1SxAQU4EBuylC3oErp1wJXfRnchjOwei0V/WQBE03v+VLFSSuhLAq3vESz
	3w6hmPaeTNAfakkI8AyzxR57uoqJQlr6byagRjp3qPEC94AiQvL1bNf3wmHGwMGyIKG4vH
	8Wwl/xstxV2OAAiPzPvcf0HCIsXFK2kn4QN53VTt1prcIsA+vLp9Hw/iZMVssw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 03 Nov 2026 11:05:02 +0100
Subject: [PATCH net-next v6 8/9] net: bcmgenet: allow the MTU to be changed
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-nb-genet-mtu-nn-v2-v6-8-61d5631676e5@tipi-net.de>
References: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
In-Reply-To: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The driver never sets dev->max_mtu, so the MTU is stuck at ETH_DATA_LEN.

One descriptor reaches as far as the packet ready threshold, so derive the
maximum from it. The threshold registers are 8 bit in units of 16 bytes and
want a multiple of the 256 byte burst size. A descriptor is one page and
also holds skb_shared_info behind the frame. On 4K pages the page is the
tighter limit and leaves 3564 bytes. That includes room for a VLAN tag so a
VLAN interface can run at the parent MTU. The MAC accepts a little more
than one descriptor holds, so a double tagged frame at that maximum is
dropped as fragmented until a later patch reassembles those.

The PHY keeps running across the change so the link stays up, with its
lock held so that a link event cannot enable the MAC while the registers
change. Two MTUs at or below ETH_DATA_LEN derive the same values, so a
change between them needs no restart at all.

Only a DMA that refuses to halt still takes the interface down, nothing is
left to run on then.

Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Link: https://github.com/raspberrypi/linux/issues/5561
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 88 ++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index f6ed15bb1a91c..e42de63fac14d 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -84,6 +84,12 @@
 				      ENET_THLD_MAX * ENET_THLD_UNIT, \
 				      ENET_THLD_PAGE_LEN)
 
+/* Largest MTU that fits one descriptor, with room for a VLAN tag so a VLAN
+ * interface can use the parent MTU.
+ */
+#define ENET_MAX_MTU		(ENET_THLD_MAX_LEN - GENET_RBUF_ALIGN - \
+				 ETH_HLEN - VLAN_HLEN)
+
 /* Tx/Rx DMA register offset, skip 256 descriptors */
 #define WORDS_PER_BD(p)		(p->hw_params->words_per_bd)
 #define DMA_DESC_SIZE		(WORDS_PER_BD(priv) * sizeof(u32))
@@ -3965,6 +3971,81 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
 	return 0;
 }
 
+static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+	unsigned int old_mtu = dev->mtu;
+	struct bcmgenet_dma_set set;
+	int ret;
+
+	/* Below ETH_DATA_LEN everything is floored, so there is nothing to
+	 * reprogram. Same when a failed resume left the datapath down.
+	 */
+	if (!netif_running(dev) || !priv->tx_cbs ||
+	    max_t(unsigned int, old_mtu, ETH_DATA_LEN) ==
+	    max_t(unsigned int, new_mtu, ETH_DATA_LEN)) {
+		WRITE_ONCE(dev->mtu, new_mtu);
+		priv->rx_buf_len = bcmgenet_rx_buf_len(new_mtu);
+		return 0;
+	}
+
+	ret = bcmgenet_alloc_dma(priv, bcmgenet_rx_buf_len(new_mtu), &set);
+	if (ret)
+		return ret;
+
+	/* The watchdog trips on an idle queue once the rings are gone */
+	netif_device_detach(dev);
+
+	/* The PHY stays up, hold its lock. A link event would otherwise take
+	 * the MAC out of reset and enable it mid rewrite.
+	 */
+	mutex_lock(&dev->phydev->lock);
+	bcmgenet_netif_stop(dev, false);
+
+	WRITE_ONCE(dev->mtu, new_mtu);
+	priv->rx_buf_len = bcmgenet_rx_buf_len(new_mtu);
+	bcmgenet_set_mtu_regs(priv, new_mtu);
+
+	ret = bcmgenet_init_dma(priv, true, &set);
+	if (ret) {
+		/* Take it down here, or close and suspend tear it down twice */
+		netdev_err(dev, "failed to initialize DMA, closing\n");
+		WRITE_ONCE(dev->mtu, old_mtu);
+		priv->rx_buf_len = bcmgenet_rx_buf_len(old_mtu);
+		mutex_unlock(&dev->phydev->lock);
+		netif_close(dev);
+
+		/* __dev_open() refuses a detached device */
+		netif_device_attach(dev);
+		return ret;
+	}
+
+	bcmgenet_hfb_restore(priv);
+	bcmgenet_netif_start(dev, false);
+	mutex_unlock(&dev->phydev->lock);
+
+	/* bcmgenet_netif_start() only restores the link interrupt */
+	if (bcmgenet_has_mdio_intr(priv))
+		bcmgenet_intrl2_0_writel(priv, UMAC_IRQ_MDIO_EVENT,
+					 INTRL2_CPU_MASK_CLEAR);
+
+	/* Interrupts were off, so a latched link event is lost. Internal PHYs
+	 * on v1-v4 are not polled either.
+	 */
+	phy_mac_interrupt(dev->phydev);
+
+	netif_device_attach(dev);
+
+	/* Filter updates that came in while the device was detached got
+	 * dropped. An IPv6 join does not hold RTNL.
+	 */
+	netif_addr_lock_bh(dev);
+	bcmgenet_set_rx_mode(dev);
+	netif_addr_unlock_bh(dev);
+
+	return 0;
+}
+
 static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_open		= bcmgenet_open,
 	.ndo_stop		= bcmgenet_close,
@@ -3976,6 +4057,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_set_features	= bcmgenet_set_features,
 	.ndo_get_stats64	= bcmgenet_get_stats64,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
+	.ndo_change_mtu		= bcmgenet_change_mtu,
 };
 
 /* GENET hardware parameters/characteristics */
@@ -4329,8 +4411,14 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	/* Mii wait queue */
 	init_waitqueue_head(&priv->wq);
 	bcmgenet_hfb_init(priv);
+
 	priv->rx_buf_len = bcmgenet_rx_buf_len(dev->mtu);
 	priv->tx_thld_len = bcmgenet_tx_pkt_rdy_thld(dev->mtu) * ENET_THLD_UNIT;
+
+	/* v1 cannot program the thresholds, so it stays at the default MTU */
+	if (!GENET_IS_V1(priv))
+		dev->max_mtu = ENET_MAX_MTU;
+
 	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);
 
 	priv->clk_wol = devm_clk_get_optional(&priv->pdev->dev, "enet-wol");

-- 
2.53.0

