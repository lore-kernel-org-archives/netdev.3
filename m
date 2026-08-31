Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6EC3BE652
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160447; cv=none; b=plP6WWV5Z5mB3ThKR4VU8IMkumpRnXTXSr7nAmljdU3pS2/z2nHXJ4NSWcB7VLL9/UAXG2DTSjhza4YTSMyeSGDeHuqz/7eQlrRK7b5hzL3dj45UqBlSx+4IDJsdcrizQ1UZ6ckRvI3ZGgiJw7aFYQHFhQylrajDzVRKkcFf/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160447; c=relaxed/simple;
	bh=cDe6t6uSU0qTbd5SXGCuHJkpjoXknmbDdfHMRVyqOZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUogTtlnSx2Z2yN+GzpfGECDHE3lCww/zO7rxx8HwGuSvPR18fo1AJmVCtAoULwJN5li6GrXGeNr6UWPsKtiTAzLgliKjxsLv9gPmHwonhZW39pRAelascfGoXJxrz4Eksf8NAUDRd0OORg3n1jsHd+9cInIEE0EDmR9vy8yuYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TmCatwwp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TmCatwwp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B864A1A18E7;
	Mon, 31 Aug 2026 07:14:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 83F7B601E1;
	Mon, 31 Aug 2026 07:14:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B1C8511C783B9;
	Mon, 31 Aug 2026 09:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788160437; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qlPqoJPgIkCWBESIwo+W3ZhE4k1gInL1GY5y/IW8siY=;
	b=TmCatwwpCK0wEnmc9d6A64/0qZSh/VPxzvBcIjz+siqfP/XJpNS6qnl0dUaSAOPSGzxrek
	y7gE0GBH+VoX5tfA+ZJBZ7nYrZf60TEF/oPiDTrE3wJ/uzyd38Xi4k9uchdXfm28iFz0dX
	CxXk68wLLkj0rTtYR5/d2023JxNSuW0pki6ac98rPp5eZGNurmsGQRjB6vvZJhCyznKb7A
	P6jc8MSpziEIOApOp8qrfQP3uDJ4UHcnIxmAY+6tHLmSoTlvQBUxYHBl5BnzWznZ8zHbDR
	1whYRe0MB2fk3P01cipdH0DLz3ScetGwPCxbzWYtg6FtsvFCGD3jLmquD4HMQw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next] net: stmmac: Remove ARP offload code
Date: Mon, 31 Aug 2026 09:13:50 +0200
Message-ID: <20260831071351.354255-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

dwmac can do ARP offloading, where the HW replies to incoming ARP
requests. This requires multiple steps to work well :
 - Program the local IP address in a dedicated register
 - Enable ARP offloading

This is halfway implemented in stmmac, as it's only ever used by
selftests, and these selftests are failing on at least 2 platforms :
stm32mp1, and jh7110.

There have been some attempts in the past to support this feature, but
this never made it upstream. Let's just remove the test and that code,
until someone actually wants that to work. We should likely have a
proper API for that so that drivers can use it.

Let's also not mention ARP offload in the stmmac documentation.

Leave the defines in place and the capability detection, this doesn't
hurt and gives some information about how the IP is synthesized.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../ethernet/stmicro/stmmac.rst               |   1 -
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  19 ---
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  18 ---
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |   3 -
 .../stmicro/stmmac/stmmac_selftests.c         | 112 ------------------
 5 files changed, 153 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst b/Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst
index 5d46e5036129..ea347b7e93a2 100644
--- a/Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst
+++ b/Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst
@@ -69,7 +69,6 @@ The following features are available in this driver:
  - Pulse-Per-Second Output (PPS)
  - MDIO Clause 22 / Clause 45 Interface
  - MAC Loopback
- - ARP Offloading
  - Automatic CRC / PAD Insertion and Checking
  - Checksum Offload for Received and Transmitted Packets
  - Standard or Jumbo Ethernet Packets
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index fb5b96a43505..cd6c5d6f42b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -819,22 +819,6 @@ static void dwmac4_sarc_configure(void __iomem *ioaddr, int val)
 	writel(value, ioaddr + GMAC_CONFIG);
 }
 
-static void dwmac4_set_arp_offload(struct mac_device_info *hw, bool en,
-				   u32 addr)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-
-	writel(addr, ioaddr + GMAC_ARP_ADDR);
-
-	value = readl(ioaddr + GMAC_CONFIG);
-	if (en)
-		value |= GMAC_CONFIG_ARPEN;
-	else
-		value &= ~GMAC_CONFIG_ARPEN;
-	writel(value, ioaddr + GMAC_CONFIG);
-}
-
 static int dwmac4_config_l3_filter(struct mac_device_info *hw, u32 filter_no,
 				   bool en, bool ipv6, bool sa, bool inv,
 				   u32 match)
@@ -966,7 +950,6 @@ const struct stmmac_ops dwmac4_ops = {
 	.set_filter = dwmac4_set_filter,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
 	.sarc_configure = dwmac4_sarc_configure,
-	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
 };
@@ -1003,7 +986,6 @@ const struct stmmac_ops dwmac410_ops = {
 	.flex_pps_config = dwmac5_flex_pps_config,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
 	.sarc_configure = dwmac4_sarc_configure,
-	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
 	.fpe_map_preemption_class = dwmac5_fpe_map_preemption_class,
@@ -1045,7 +1027,6 @@ const struct stmmac_ops dwmac510_ops = {
 	.flex_pps_config = dwmac5_flex_pps_config,
 	.set_mac_loopback = dwmac4_set_mac_loopback,
 	.sarc_configure = dwmac4_sarc_configure,
-	.set_arp_offload = dwmac4_set_arp_offload,
 	.config_l3_filter = dwmac4_config_l3_filter,
 	.config_l4_filter = dwmac4_config_l4_filter,
 	.fpe_map_preemption_class = dwmac5_fpe_map_preemption_class,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index fc6ddb51c682..1a88cbaed70c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1410,22 +1410,6 @@ static int dwxgmac2_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 	return 0;
 }
 
-static void dwxgmac2_set_arp_offload(struct mac_device_info *hw, bool en,
-				     u32 addr)
-{
-	void __iomem *ioaddr = hw->pcsr;
-	u32 value;
-
-	writel(addr, ioaddr + XGMAC_ARP_ADDR);
-
-	value = readl(ioaddr + XGMAC_RX_CONFIG);
-	if (en)
-		value |= XGMAC_CONFIG_ARPEN;
-	else
-		value &= ~XGMAC_CONFIG_ARPEN;
-	writel(value, ioaddr + XGMAC_RX_CONFIG);
-}
-
 const struct stmmac_ops dwxgmac210_ops = {
 	.core_init = dwxgmac2_core_init,
 	.irq_modify = dwxgmac2_irq_modify,
@@ -1464,7 +1448,6 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.sarc_configure = dwxgmac2_sarc_configure,
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
-	.set_arp_offload = dwxgmac2_set_arp_offload,
 	.fpe_map_preemption_class = dwxgmac3_fpe_map_preemption_class,
 };
 
@@ -1519,7 +1502,6 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.sarc_configure = dwxgmac2_sarc_configure,
 	.config_l3_filter = dwxgmac2_config_l3_filter,
 	.config_l4_filter = dwxgmac2_config_l4_filter,
-	.set_arp_offload = dwxgmac2_set_arp_offload,
 	.fpe_map_preemption_class = dwxgmac3_fpe_map_preemption_class,
 };
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 04dafec021b4..fe18f98fae45 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -407,7 +407,6 @@ struct stmmac_ops {
 	int (*config_l4_filter)(struct mac_device_info *hw, u32 filter_no,
 				bool en, bool udp, bool sa, bool inv,
 				u32 match);
-	void (*set_arp_offload)(struct mac_device_info *hw, bool en, u32 addr);
 	int (*fpe_map_preemption_class)(struct net_device *ndev,
 					struct netlink_ext_ack *extack,
 					u32 pclass);
@@ -491,8 +490,6 @@ struct stmmac_ops {
 	stmmac_do_callback(__priv, mac, config_l3_filter, __args)
 #define stmmac_config_l4_filter(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, config_l4_filter, __args)
-#define stmmac_set_arp_offload(__priv, __args...) \
-	stmmac_do_void_callback(__priv, mac, set_arp_offload, __args)
 #define stmmac_fpe_map_preemption_class(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, fpe_map_preemption_class, __args)
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 6372ec7c3f31..664d7cfde2f1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -215,24 +215,6 @@ static struct sk_buff *stmmac_test_get_udp_skb(struct stmmac_priv *priv,
 	return skb;
 }
 
-static struct sk_buff *stmmac_test_get_arp_skb(struct stmmac_priv *priv,
-					       struct stmmac_packet_attrs *attr)
-{
-	__be32 ip_src = htonl(attr->ip_src);
-	__be32 ip_dst = htonl(attr->ip_dst);
-	struct sk_buff *skb = NULL;
-
-	skb = arp_create(ARPOP_REQUEST, ETH_P_ARP, ip_dst, priv->dev, ip_src,
-			 NULL, attr->src, attr->dst);
-	if (!skb)
-		return NULL;
-
-	skb->pkt_type = PACKET_HOST;
-	skb->dev = priv->dev;
-
-	return skb;
-}
-
 struct stmmac_test_priv {
 	struct stmmac_packet_attrs *packet;
 	struct packet_type pt;
@@ -1603,97 +1585,6 @@ static int stmmac_test_l4filt_sa_udp(struct stmmac_priv *priv)
 	return __stmmac_test_l4filt(priv, 0, dummy_port, 0, ~0, true);
 }
 
-static int stmmac_test_arp_validate(struct sk_buff *skb,
-				    struct net_device *ndev,
-				    struct packet_type *pt,
-				    struct net_device *orig_ndev)
-{
-	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
-	struct ethhdr *ehdr;
-	struct arphdr *ahdr;
-
-	ehdr = (struct ethhdr *)skb_mac_header(skb);
-	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->src))
-		goto out;
-
-	ahdr = arp_hdr(skb);
-	if (ahdr->ar_op != htons(ARPOP_REPLY))
-		goto out;
-
-	tpriv->ok = true;
-	complete(&tpriv->comp);
-out:
-	kfree_skb(skb);
-	return 0;
-}
-
-static int stmmac_test_arpoffload(struct stmmac_priv *priv)
-{
-	unsigned char src[ETH_ALEN] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06};
-	unsigned char dst[ETH_ALEN] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
-	struct stmmac_packet_attrs attr = { };
-	struct stmmac_test_priv *tpriv;
-	struct sk_buff *skb = NULL;
-	u32 ip_addr = 0xdeadcafe;
-	u32 ip_src = 0xdeadbeef;
-	int ret;
-
-	if (!priv->dma_cap.arpoffsel)
-		return -EOPNOTSUPP;
-
-	tpriv = kzalloc_obj(*tpriv);
-	if (!tpriv)
-		return -ENOMEM;
-
-	tpriv->ok = false;
-	init_completion(&tpriv->comp);
-
-	tpriv->pt.type = htons(ETH_P_ARP);
-	tpriv->pt.func = stmmac_test_arp_validate;
-	tpriv->pt.dev = priv->dev;
-	tpriv->pt.af_packet_priv = tpriv;
-	tpriv->packet = &attr;
-	dev_add_pack(&tpriv->pt);
-
-	attr.src = src;
-	attr.ip_src = ip_src;
-	attr.dst = dst;
-	attr.ip_dst = ip_addr;
-
-	skb = stmmac_test_get_arp_skb(priv, &attr);
-	if (!skb) {
-		ret = -ENOMEM;
-		goto cleanup;
-	}
-
-	ret = stmmac_set_arp_offload(priv, priv->hw, true, ip_addr);
-	if (ret) {
-		kfree_skb(skb);
-		goto cleanup;
-	}
-
-	ret = dev_set_promiscuity(priv->dev, 1);
-	if (ret) {
-		kfree_skb(skb);
-		goto cleanup;
-	}
-
-	ret = dev_direct_xmit(skb, 0);
-	if (ret)
-		goto cleanup_promisc;
-
-	wait_for_completion_timeout(&tpriv->comp, STMMAC_LB_TIMEOUT);
-	ret = tpriv->ok ? 0 : -ETIMEDOUT;
-
-cleanup_promisc:
-	dev_set_promiscuity(priv->dev, -1);
-cleanup:
-	stmmac_set_arp_offload(priv, priv->hw, false, 0x0);
-	dev_remove_pack(&tpriv->pt);
-	kfree(tpriv);
-	return ret;
-}
-
 static int __stmmac_test_jumbo(struct stmmac_priv *priv, u16 queue)
 {
 	struct stmmac_packet_attrs attr = { };
@@ -1911,9 +1802,6 @@ static const struct stmmac_test {
 	}, {
 		.name = "L4 SA UDP Filtering        ",
 		.fn = stmmac_test_l4filt_sa_udp,
-	}, {
-		.name = "ARP Offload                ",
-		.fn = stmmac_test_arpoffload,
 	}, {
 		.name = "Jumbo Frame                ",
 		.fn = stmmac_test_jumbo,
-- 
2.55.0

