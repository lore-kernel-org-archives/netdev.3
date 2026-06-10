Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20923F8222;
	Wed, 10 Jun 2026 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781087162; cv=none; b=tV6sGhQ6WcbWZzda8XStonwPBwFUbE5lHh421XIPwUEDoaV5beU5l52dkxTc65hemyQauH5y7P87vWZMFhgdtocMgB2MsQH+s5PK3nu15olXUY07D+8/jEjbOqpUZaudvpytvtVR3fpRon1mgjALMDAyesNPEVjr1aRq1nDYRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781087162; c=relaxed/simple;
	bh=h+I1nrQBBAYtzN9CI4JYcEzOrCnGSrm+nfyVTS0Afl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9ERQZkHTsDK0IvcA0ad3ywU22VnD+Mj+hz9rG9V4qLaY5qN+ElOwyVRZ/HGmipWCj91kvmloRSHF+wokphoYU133nPECkyXgvanWbuF6Dh8Qi8F7YpwQBZ8H8e3xdmiLiJ/fGSmVoz+t3sN0OB+ay7BvoXYKWsGJs5RpWjwVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=0J01y/gU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XlepLbbB; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="0J01y/gU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XlepLbbB"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 87EBD7A0118;
	Wed, 10 Jun 2026 06:25:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 10 Jun 2026 06:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781087159;
	 x=1781173559; bh=3PqXTCo9kaTVKG8V15/jnJzaBUXcooGfCbd6vgCRhsM=; b=
	0J01y/gUSzznfIxQwzHPDztM00uOBeaC9Tq7OMmKV79pMn4kAgDJC48n1T4lAKct
	dhcgECY2bSME/CrVf0PKVuMjzK6WBf7lOHv0XFqQ+32xfbs9uttImyXrikEI0YNP
	hAiPNmoXu/2PeE4+tJJrsjIoFOx4oDPBY87qfPMGurn1zKHFyBrzlG7WcfiDKU8e
	1xxJULyOtQATS67kGpjTQieCKAtow0LqXR/zQ+ZFKIJQP/H2hwXQ4QPyhALHaorM
	qjxdi96l0i73J/WPiQNGp+p0GtC3IAAwOAK5XtpzY/dwK5ZOIzyD0cd3sQlx2mvH
	77TQiBOCnxodwCo3BneaEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781087159; x=
	1781173559; bh=3PqXTCo9kaTVKG8V15/jnJzaBUXcooGfCbd6vgCRhsM=; b=X
	lepLbbBGUf3AXKvpGN8gmQ4HlzjisaiLTqgfJP/FpTACyOmXT8UqcCXUnMt1zk/0
	o6LUp/EHMyWPYwt+XSjnCDTCTqolRav5rsxkyGnOkBSiNTwXg6XPZmw7vQdqqsjW
	bLp29sCEiNHY+oiTth4CxjumgrJ01jYEU1XUB7vESgWrc2Ye64NNblKVvg6HsuG1
	a5YYLO1L1WHFarO+YvosutToXfq3I0PkQXea22fOgBQXaf4AC3v0cxXw0rPkvnnu
	hEq8jdFQe7PAQ6AuhIf1PMA8WBZzFH9/3y0T9aXAzTERYSIgI5AbBh0ILaON492E
	3W0JZXhhHdJ5U5gUlKpxw==
X-ME-Sender: <xms:tzspakbNN6FP9kHr-EpoCKRBTos5dWMVDFgTaT7Y07wljjm-_YnDiA>
    <xme:tzspaoLm31TmdLLelYrVoXJY91xx1wGQE-DSfyOa2e-RKIi-MNpOpN2N8ItzjmXSC
    dSZNmAH5M6TXlwJrfwlJG9EMLj81Z3LnRoDqGeXkG6klSWxtoGi7FL9>
X-ME-Received: <xmr:tzspatoQ5dJxVdUohu-DVX1QOis-RqPd5mWOVu7auQ-eCh71mK_cO0XSKQEsnLc5R2ev2RGkPBy79XJ_DB12TLauOdPV2XhQ3yRA>
X-ME-Proxy-Cause: dmFkZTFUwBTAUIylSDRD/bGl3yGNPD5wJUQnT81UZNe+JWC4FSEgQz4+ANh4fEW2zKTIoI
    KS7kHZjnKpn2CDNJXxmj8ahqhyJ2du6WpXcqG6Yq6P++8nSoW9JAJGyxHIXi6N8QSW0geK
    1OZvtGnj+h4ATXCfV2pJ2bZsJDjK6Cix0kxNFXywfE7yc0I65o7ExBMR85T8XCN47RVqSD
    LBERs5pG2HpNha3RvhFhoCbr7PP+UTxjZRZ32lcxKRHfYWjqTzQA2PjK1twkTT/x75VYM8
    gKt36IwzoDgjN6gLHKb+CCgPd3hqulw0xEPnF/pYbqrzUvQzHhb++BLhMMq5XHTNgDTqrq
    LHAVBWSQvkcUaJDgLstLFcPKdpN4f2ax5RHdOH8aA8lx7NdCjRIXcmACwta7IDnqSKhQIg
    98kyIYKo8Ur0c1qmx+rPdENxpEx0cQOMkGpf3D/RD+uEjhwzRIoIHx2pWmOh3tFu3QpfPP
    48K0VO0U/6YMdrjvhpVwCXKZ4OGw5v7rqW+SZLNQ5wYhQnp7FcGwTh0V39VNssPz/K9tzB
    NB24T6rgAayZ85Bm6ESGBT51aIfGahYHzQEoxwtfBuRnwCWW0MGGiMiXnQY+zXLRyZ/xMb
    dIf5DIFSQlQpk23VpQaRlORMcihoXuOXRQ10xK9ROAO8MH0e34O5GqKYubZw
X-ME-Proxy: <xmx:tzspahCgvo_l9c5d8OphY_rMtWWHHPgXzG3U5EPffhzUl4k0LC1aQA>
    <xmx:tzspajdGb4I3g0uNSHlu1Qwn6U53LVtaGFvsFiLgYm97cOqqRoiCcQ>
    <xmx:tzspahIGIfM7Pm6XOPD6kVpJj_dftVhEpJv6SEi3XAOqf_znT_Xv7g>
    <xmx:tzspajvLwXolM3V017mvSJmf8jLcvF9YxLF4z784xRmvnxGmmYWm1A>
    <xmx:tzspand_tMvcY7fuh83nI543r1kTvJDboihDiaJacgJ3BKua6cbPeERo>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 06:25:58 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [net-next 5/9] net: ethernet: ravb: Replace gPTP flags with callbacks
Date: Wed, 10 Jun 2026 12:24:28 +0200
Message-ID: <20260610102432.3538432-6-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260610102432.3538432-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Prepare for adding Gen4 support which will add a third and new way to
interact with the gPTP clock by replacing the flags for Gen2 behavior
(info->gptp) and Gen3 behavior (info->ccc_gac) with callbacks.

This will make adding Gen4 support cleaner as the code will not have "if
else if else" sprinkled all over to handle each generations special
cases.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/net/ethernet/renesas/ravb.h      | 24 ++++++-
 drivers/net/ethernet/renesas/ravb_main.c | 80 +++++++++++++++---------
 2 files changed, 73 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 013ced6dcf29..70bef3b31d38 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1034,6 +1034,27 @@ struct ravb_ptp {
 	struct ravb_ptp_perout perout[N_PER_OUT];
 };
 
+/**
+ * struct ravb_gptp_info - Platform specific gPTP behavior
+ *
+ * Each generation of RAVB have slightly different behaviors when interacting
+ * with the gPTP clock. This struct provides the callbacks to be called at
+ * critical points in the RAVB driver.
+ *
+ * @set_config_mode:	Enter config mode
+ * @dmac_start:		Called when the DMAC starts
+ * @dmac_stop:		Called when the DMAC stops
+ * @ndev_open:		Called when the ndev is opened
+ * @ndev_close:		Called when the ndev is closed
+ */
+struct ravb_gptp_info {
+	int (*set_config_mode)(struct net_device *ndev);
+	void (*dmac_start)(struct net_device *ndev);
+	void (*dmac_stop)(struct net_device *ndev);
+	void (*ndev_open)(struct net_device *ndev);
+	void (*ndev_close)(struct net_device *ndev);
+};
+
 struct ravb_hw_info {
 	int (*receive)(struct net_device *ndev, int budget, int q);
 	void (*set_rate)(struct net_device *ndev);
@@ -1052,6 +1073,7 @@ struct ravb_hw_info {
 	u32 rx_buffer_size;
 	u32 rx_desc_size;
 	u32 dbat_entry_num;
+	const struct ravb_gptp_info *ptp; /* Callbacks to handle gPTP interactions. */
 	unsigned aligned_tx: 1;
 	unsigned coalesce_irqs:1;	/* Needs software IRQ coalescing */
 
@@ -1062,8 +1084,6 @@ struct ravb_hw_info {
 	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
 	unsigned irq_en_dis:1;		/* Has separate irq enable and disable regs */
 	unsigned err_mgmt_irqs:1;	/* Line1 (Err) and Line2 (Mgmt) irqs are separate */
-	unsigned gptp:1;		/* AVB-DMAC has gPTP support */
-	unsigned ccc_gac:1;		/* AVB-DMAC has gPTP support active in config mode */
 	unsigned gptp_ref_clk:1;	/* gPTP has separate reference clock */
 	unsigned nc_queues:1;		/* AVB-DMAC has RX and TX NC queues */
 	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index b3cc4c79b29f..577cd2245e60 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -712,8 +712,8 @@ static int ravb_dmac_init(struct net_device *ndev)
 		return error;
 
 	/* Initialise PTP Clock driver */
-	if (info->gptp)
-		ravb_ptp_init(ndev);
+	if (info->ptp && info->ptp->dmac_start)
+		info->ptp->dmac_start(ndev);
 
 	return 0;
 }
@@ -1124,8 +1124,8 @@ static int ravb_stop_dma(struct net_device *ndev)
 	}
 
 	/* Stop PTP Clock driver */
-	if (info->gptp)
-		ravb_ptp_stop(ndev);
+	if (info->ptp && info->ptp->dmac_stop)
+		info->ptp->dmac_stop(ndev);
 
 	/* Stop AVB-DMAC process */
 	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
@@ -1774,7 +1774,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *hw_info = priv->info;
 
-	if (hw_info->gptp || hw_info->ccc_gac) {
+	if (hw_info->ptp) {
 		info->so_timestamping =
 			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_TX_HARDWARE |
@@ -1835,21 +1835,11 @@ static int ravb_set_config_mode(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	int error;
 
-	if (info->gptp) {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
-		if (error)
-			return error;
-		/* Set CSEL value */
-		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
-	} else if (info->ccc_gac) {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
-	} else {
-		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
-	}
+	if (info->ptp && info->ptp->set_config_mode)
+		return info->ptp->set_config_mode(ndev);
 
-	return error;
+	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 }
 
 static int ravb_compute_gti(struct net_device *ndev)
@@ -1860,7 +1850,7 @@ static int ravb_compute_gti(struct net_device *ndev)
 	unsigned long rate;
 	u64 inc;
 
-	if (!(info->gptp || info->ccc_gac))
+	if (!info->ptp)
 		return 0;
 
 	if (info->gptp_ref_clk)
@@ -1967,8 +1957,8 @@ static int ravb_open(struct net_device *ndev)
 	ravb_emac_init(ndev);
 
 	/* Initialise PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_init(ndev);
+	if (info->ptp && info->ptp->ndev_open)
+		info->ptp->ndev_open(ndev);
 
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
@@ -2187,7 +2177,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	desc->dptr = cpu_to_le32(dma_addr);
 
 	/* TX timestamp required */
-	if (info->gptp || info->ccc_gac) {
+	if (info->ptp) {
 		if (q == RAVB_NC) {
 			ts_skb = kmalloc_obj(*ts_skb, GFP_ATOMIC);
 			if (!ts_skb) {
@@ -2369,8 +2359,8 @@ static int ravb_close(struct net_device *ndev)
 	}
 
 	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
+	if (info->ptp && info->ptp->ndev_close)
+		info->ptp->ndev_close(ndev);
 
 	/* Set the config mode to stop the AVB-DMAC's processes */
 	if (ravb_stop_dma(ndev) < 0)
@@ -2378,7 +2368,7 @@ static int ravb_close(struct net_device *ndev)
 			   "device will be stopped after h/w processes are done.\n");
 
 	/* Clear the timestamp list */
-	if (info->gptp || info->ccc_gac) {
+	if (info->ptp) {
 		list_for_each_entry_safe(ts_skb, ts_skb2, &priv->ts_skb_list, list) {
 			list_del(&ts_skb->list);
 			kfree_skb(ts_skb->skb);
@@ -2660,6 +2650,26 @@ static int ravb_mdio_release(struct ravb_private *priv)
 	return 0;
 }
 
+static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
+{
+	int ret;
+
+	ret = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
+	if (ret)
+		return ret;
+
+	/* gPTP Clock Select High-speed peripheral bus clock. */
+	ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
+
+	return 0;
+}
+
+static const struct ravb_gptp_info ravb_gen2_ptp_info = {
+	.set_config_mode = ravb_gen2_ptp_set_config_mode,
+	.dmac_start = ravb_ptp_init,
+	.dmac_stop = ravb_ptp_stop,
+};
+
 static const struct ravb_hw_info ravb_gen2_hw_info = {
 	.receive = ravb_rx_rcar,
 	.set_rate = ravb_set_rate_rcar,
@@ -2678,12 +2688,24 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
 			  SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
 	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
 	.dbat_entry_num = 22,
+	.ptp = &ravb_gen2_ptp_info,
 	.aligned_tx = 1,
-	.gptp = 1,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
 
+static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
+{
+	/* Enable gPTP Clock and Select High-speed peripheral bus clock. */
+	return ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
+}
+
+static const struct ravb_gptp_info ravb_gen3_ptp_info = {
+	.set_config_mode = ravb_gen3_ptp_set_config_mode,
+	.ndev_open = ravb_ptp_init,
+	.ndev_close = ravb_ptp_stop,
+};
+
 static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.receive = ravb_rx_rcar,
 	.set_rate = ravb_set_rate_rcar,
@@ -2702,11 +2724,11 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 			  SKB_DATA_ALIGN(sizeof(struct skb_shared_info)),
 	.rx_desc_size = sizeof(struct ravb_ex_rx_desc),
 	.dbat_entry_num = 22,
+	.ptp = &ravb_gen3_ptp_info,
 	.internal_delay = 1,
 	.tx_counters = 1,
 	.multi_irqs = 1,
 	.irq_en_dis = 1,
-	.ccc_gac = 1,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
@@ -2733,7 +2755,7 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.tx_counters = 1,
 	.multi_irqs = 1,
 	.irq_en_dis = 1,
-	.ccc_gac = 1,
+	.ptp = &ravb_gen3_ptp_info,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
@@ -2758,7 +2780,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.dbat_entry_num = 22,
 	.multi_irqs = 1,
 	.err_mgmt_irqs = 1,
-	.gptp = 1,
+	.ptp = &ravb_gen2_ptp_info,
 	.gptp_ref_clk = 1,
 	.nc_queues = 1,
 	.magic_pkt = 1,
-- 
2.54.0

