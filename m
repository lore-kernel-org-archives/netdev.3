Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4C38D6BD;
	Wed,  9 Sep 2026 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975077; cv=none; b=SWVLD20iMfq2ilcws+r0yCEpmBrpieW36LJUsEYtCIq6+2JC5ag15fwUJja15gCmmSdMt7QlZ9wzPw3DpoFPaUb4XD+1uK4J/efJFhZP30SISMMSikBr3mgzz6gRsh2yk0I7COB2zA+izAHx9+GBeL87YjfZ0dEzZtgE7+UdYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975077; c=relaxed/simple;
	bh=7vK78GlO2mGmPsbvEys/WT5uL2xQEz6UezB8GBaChec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtJ79AXI6Ob/AlDzX0NvuEaC0e7ixe2wUK5YK9h6bJpvYTn0gxaGxeqyY3B9ieaG6/pOqbUj1MWMR11KqIwjwQw1k12mDc1MJb+/4RwGP/OocGw61GiF/RuXZ/sB6APnIJXIB0M3X8MEZsR8yKVeifRUqx5AHvt7Fgcjtq/gJIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=u4Dr1RIg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZVVOqLy9; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="u4Dr1RIg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZVVOqLy9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1C87B1D0011D;
	Wed,  9 Sep 2026 13:31:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 09 Sep 2026 13:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788975073;
	 x=1789061473; bh=DZCW3AX4IQy7VtLxOkg1LexBaFGy8OVeG+7z1SNmxkc=; b=
	u4Dr1RIgWUx8wHbljsX1vVFhKlQeDV/rLwIHvqAd3LQ1K01NxhPLpAlOGZU5fTpj
	b1tDMAR5ufoInVzIXh0mvSs35FRAaXgG9ZEtYt5OCrZ6s/pp7stEaDEJBlvkfhPm
	Gx7tPNMH8/4NDSKyvl4Yeh7huz2SYn6XjeSVSxEF+zmBwKy7fbdVkgHgNFAaLeKo
	5PVdX6VGcSRTQ98/gyNTLYbWkO6tchtBiJNEduBXtYIhVtW49+wbqCmvhOuoz4IE
	hbTqWFfsKaPx7fJfPPqKUE6u9yhtbpaSAuXLR+51bm9zqV6k02E2u4AfTvpGtepj
	JPcc2H+jKhdPE9bW8qv/mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788975073; x=
	1789061473; bh=DZCW3AX4IQy7VtLxOkg1LexBaFGy8OVeG+7z1SNmxkc=; b=Z
	VVOqLy9E3XVHmTZoQazDO5a0pK6cHB89ujHvOBxPK3Jmw09IDZyhgEnvbejyzGy6
	N0G9wN3JVzeErI1KsTnV5HDpfKvkhBInidlKdXdSgpVjKwO0//jAbEy/3ig70oSh
	fg4T6MdvS4F8ip6E5uTMK3Pm9OcQDL/YQMy504i7FOVinn8yktuAPYw0jA+XLZt7
	7zr6ygjxKhumOHSuoDGdiVKtWOsu6IzNNmik8lFHUa7YnZgB3p9YnXHcu0PpcyRV
	VGkoUbKIyHr1Iw2mdP4mRaYEgmyeoVJB5Ld6742RheY89EIkwHZOrgawnDrlTnwS
	9wT04RTyPIyr6+gY6STXg==
X-ME-Sender: <xms:4ZeharudP0mmXk-pGJZIN6rtEz-Xex4KKmCKuJFT4T81iN2Uq3iO1Q>
    <xme:4ZehajaIE_-eUDTwDkF4PURi4MHul7Ml_8ysc28nNSiU3EU-4672oOBChZikfM9SJ
    PaE9bCwnYLeRnikRSNCsbAk7ZEzVCsgAHYOX6ZdOwuo6BHLisLLdo_zHA>
X-ME-Received: <xmr:4Zehaj3VaD-6WTbhcKcmSYBPgx_gSJHZb_65KwR2c_xQ-62S7GzX538vmu6Larjy7yQQGR7Hogf-_cSE97KIp6-4gIBLecI>
X-ME-Proxy-Cause: dmFkZTFpKuOoHA8K6npXM0EyPQ3B6fuJj1V92yxTkRTwTvOrGLmaogCPSGJNdxe3w3n+ts
    3Bnq9S0gANJKKK31pjNWK50OZ9a7PMq2fNO8DZXCQ+/ff2Kmc+UHBXNITlDnGREVxg/f50
    czaZu7ewfHhQ8KEOahciUDlJaktTnHuAyQxRzBwFm86u+eYYubMr2Wb9/todjLgmh5z450
    82zfjBukuoe9N1IpciNBSfLDvZO88JgjH/tASHI61YFG/pSFyNvmg0AvAJCBYM82e580+H
    IntiqdDAd7FDyLCJPHSk55kS+5m53Gxxbft8dJNI3qmcm7XJFRCQyhfwNMEehhg0cLBjSw
    dJUTnx9U+x22UZE0O5siuLEVi2dt562Jjl5+bVMISm/KqhrpB4EwHL6gVV+tkVNDi6oehA
    WYTAavGhu3rin3NReO/13BqeXQmv6f5EXrXFwG0ndjgLMHq4+WNnlvmUToKq8mOKrn6moA
    4xpSr3//oFHCrMx00IDjm/vO+s+/E+tzh+2IwXPvcC0Re2sicl6Gyqm2NoNgH2/gA6qEbJ
    MWHY7rZVIywg5oUxzcPTYZpba4g9bRz6K2oPQQZ8LUJDFWBmrLbzHrFKc6p1ZTGJ+645S0
    ZqvEBAhcYV0ydo674scPOfYB7nWhcmlCK75GNpL6ytI4HOzBHeCJl3e7l6cw
X-ME-Proxy: <xmx:4ZehahXRKc61N7ywud6trnULueniLb3M6omRSaIkuq2lqzPVle3QaQ>
    <xmx:4ZehamvYYWnsJEPMRTLd-1yd4ywf7nhLAmg2_mZalSgNTaYjfts9-Q>
    <xmx:4ZehagUfj5CL6cFE-mOfSLt1KpYAOipHt68iWE9qCXZSNKpDXkmWnQ>
    <xmx:4ZehaqX7tkR3CBOwBlV3kPnMqVqRjJIfjTNPIpyVpuiJdllT2Z_kFw>
    <xmx:4ZehaoPVMVT0wqrO9t67sTpLF1Ikshuz9b3J7ejfAuxpnkb5RhS_oLZu>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:31:13 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: paul@pbarker.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v4 06/10] net: ethernet: ravb: Replace gPTP flags with callbacks
Date: Wed,  9 Sep 2026 19:30:23 +0200
Message-ID: <20260909173027.2201560-7-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909173027.2201560-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260909173027.2201560-1-niklas.soderlund+renesas@ragnatech.se>
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
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
* Changes since v1
- Handle error from starting the PTP clock.
---
 drivers/net/ethernet/renesas/ravb.h      | 24 ++++++-
 drivers/net/ethernet/renesas/ravb_main.c | 83 +++++++++++++++---------
 2 files changed, 76 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 0c122a815840..6603f90b19e1 100644
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
+	int (*dmac_start)(struct net_device *ndev);
+	void (*dmac_stop)(struct net_device *ndev);
+	int (*ndev_open)(struct net_device *ndev);
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
index 5ba322593a01..9e9b1c4fbe95 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -712,8 +712,8 @@ static int ravb_dmac_init(struct net_device *ndev)
 		return error;
 
 	/* Initialise PTP Clock driver */
-	if (info->gptp)
-		ravb_ptp_init(ndev);
+	if (info->ptp && info->ptp->dmac_start)
+		return info->ptp->dmac_start(ndev);
 
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
 
-	if (priv->ptp.clock && (hw_info->gptp || hw_info->ccc_gac)) {
+	if (priv->ptp.clock && hw_info->ptp) {
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
@@ -1967,8 +1957,11 @@ static int ravb_open(struct net_device *ndev)
 	ravb_emac_init(ndev);
 
 	/* Initialise PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_init(ndev);
+	if (info->ptp && info->ptp->ndev_open) {
+		error = info->ptp->ndev_open(ndev);
+		if (error)
+			goto out_ptp_stop;
+	}
 
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
@@ -2187,7 +2180,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	desc->dptr = cpu_to_le32(dma_addr);
 
 	/* TX timestamp required */
-	if (info->gptp || info->ccc_gac) {
+	if (info->ptp) {
 		if (q == RAVB_NC) {
 			ts_skb = kmalloc_obj(*ts_skb, GFP_ATOMIC);
 			if (!ts_skb) {
@@ -2369,8 +2362,8 @@ static int ravb_close(struct net_device *ndev)
 	}
 
 	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
+	if (info->ptp && info->ptp->ndev_close)
+		info->ptp->ndev_close(ndev);
 
 	/* Set the config mode to stop the AVB-DMAC's processes */
 	if (ravb_stop_dma(ndev) < 0)
@@ -2378,7 +2371,7 @@ static int ravb_close(struct net_device *ndev)
 			   "device will be stopped after h/w processes are done.\n");
 
 	/* Clear the timestamp list */
-	if (info->gptp || info->ccc_gac) {
+	if (info->ptp) {
 		list_for_each_entry_safe(ts_skb, ts_skb2, &priv->ts_skb_list, list) {
 			list_del(&ts_skb->list);
 			kfree_skb(ts_skb->skb);
@@ -2660,6 +2653,26 @@ static int ravb_mdio_release(struct ravb_private *priv)
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
@@ -2678,12 +2691,24 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
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
@@ -2702,11 +2727,11 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
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
@@ -2733,7 +2758,7 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.tx_counters = 1,
 	.multi_irqs = 1,
 	.irq_en_dis = 1,
-	.ccc_gac = 1,
+	.ptp = &ravb_gen3_ptp_info,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
@@ -2758,7 +2783,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.dbat_entry_num = 22,
 	.multi_irqs = 1,
 	.err_mgmt_irqs = 1,
-	.gptp = 1,
+	.ptp = &ravb_gen2_ptp_info,
 	.gptp_ref_clk = 1,
 	.nc_queues = 1,
 	.magic_pkt = 1,
-- 
2.55.0

