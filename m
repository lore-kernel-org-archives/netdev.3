Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01204F30D9;
	Mon, 21 Sep 2026 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013081; cv=none; b=EtE2DZIUKks2JFTVbUVjgisA8IrYpGSP6FED3CjtGXHF69KtPb5H0tGRC/oyTF6uGQ7F4xvNBhVo5xV13ngGuRbMQFIfe+LK/A4otrKGIN1NN4sjGl64nder4gK7OTbKWfDJ6c82WBcgIUOmpCqJ66wkhdUtVNbEPKmny98yNoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013081; c=relaxed/simple;
	bh=6EeNiIB/cWlzlYzv3WRadrrHMUqyPhqeFZm7gxBhrFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uu0LVsxsq9EgEXVjmHljxtzozWt7VhdZTxA9qSuq4DFsD8ZgiE3UUkB+HbpvqVw/t3zkZgkiwRrpB+mrPBvo5k7i2JK97nMUUHobQ/0LhPUqnpCaIFxZ5By325f4IveCd82yuTQFSaZFDWfbISB//f+V0M6njRvsnTh6E0M9dfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=KHqhkqcI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BmTfoa0i; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="KHqhkqcI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BmTfoa0i"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 862EB7A00C2;
	Mon, 21 Sep 2026 13:51:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 21 Sep 2026 13:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790013078;
	 x=1790099478; bh=jBtMlQMWcvBYE/2p3rhF3jRLyp1sF7Jm5ovtkkdH9wE=; b=
	KHqhkqcI3q4rTLJbjS5arvUy913sQfD3WZE6nvOAvUfYDl0MKvFON+2i7c/Yjb98
	0ukVTzkSgwPlr3N90rmp73lMGkvAKIYMSHidH++S7zTl1W7zuu12ikNDwgyjwAjf
	sSk+SAtUP7mCCShEsyrh4bLSX0tgBJOW10PDOjPxsp96GnrrOPPQFodzSHSYMBQ4
	zK0T/DdX9AWiyF24PcDmqZXjjnOuwR5hMGCM0ErWpluv8+oSgHaIyUbrQ1GG4g2j
	+phWdDfnrmI9ym67ccjAGnqw4gBMe6/bnzFwwgCR0pohcz+syZ32EZfKSmZt0w3Z
	Hza4tNtH6g+FHSpU63imdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790013078; x=
	1790099478; bh=jBtMlQMWcvBYE/2p3rhF3jRLyp1sF7Jm5ovtkkdH9wE=; b=B
	mTfoa0it0+kIcTHequ99G/sV3pMf2B2ZERSuyFKQjxmOsMi/zObrqkoKbTsaNLiz
	0Gov2ruKdi4TcQE1f4s3SrfWEnRn+e//wG5u6N9ReADdFeI7w0IoXNEdrNXAx58L
	RILYcsvSXexyG5Zdkx9ITCj8dAf2s69hyWX3MxvbeuIlowmU/wzJ5T+zfUR01P16
	D3Wzus4nVtmlBHf8ZcXNdPFPqaB2sQZdYALBb1duFYakzUgq/IgExJgINI3MOlBx
	DdqEl3hGLk1jy5Sa2qlWUOIJ3wjuDMSaMEDVgWTEdyEOXV7YC5j9msmdq0RnGBVc
	CVsjuwKog77VMzE2TEkPw==
X-ME-Sender: <xms:lm6xahndH-R4cQE72RG2IijPR1v7lyZkleaO11zwaO-oa0741HQiTg>
    <xme:lm6xauTrMPVcbHgJdUVB_GublPFPFraId3zl5yEFHBFh8ETcvrT6HeyF5K0mCf648
    QXUCyeuupHGbMFK_0DNcMGeRe3s0GTRiat1EC596vf-9MOY1AMpow>
X-ME-Received: <xmr:lm6xajCAqaxWSobGLzT4if6BxaCYlH2c9dqszR48SZ5-AVt-uXHTEdhlBIV1y5lHZ673U9f4B_61BrX-Hi1LKYG5cagDriM>
X-ME-Proxy-Cause: dmFkZTFKyuwNHokJCgIndgtoOusqu1/6uPi/0uzv51oOMJoBVzbBuuQBERlY9Rv3NvmA6T
    d/CD1lxyU3UgPnEeJyPNbZpf+4OQPJ3AbFbyzvtJqzJyhSU0WyRw2N3jkO5MC6tTob5H+B
    TCxu9EekrWCaHBw+6MstQGy681MV+L5ictmDPIp7n4+FYelCRH1YJ2M1xfPZF1CqF0smxw
    c4JIURjRlH1wsfm+CyMKRUhHTOncPDoh9a2aZMLd+DzObP2w66sKePqFvy/aIxy5vDMgrD
    fRXTZksUaWctOWTnUr66Aqn0xuMYZyKstCQR4Y6Vusob1m7Y0ettnqm2yu1mZb4HnTRWRn
    XSPBDV8rmEP2oG74r/s6E+nduI4BqSlXJAURNGtP0WI5vsMx+ewJD5MyGgCif7zkC/8G64
    jwy9JTpJH4v1Whbk5MP0SFOnDxT2hVwJdZyUcea2x2bTMFPZuwX8/hhjzrlWNfZk+s4Z8v
    JaCMpEWvJuuwmAT8jhWSxEBLogPZby4LYePk3XRToaORzv0Gz/NSH7ow/9rmq9b9tZx/t4
    UUS+aar+RDMRux5ZvjjVcc5C+usSkXclfTg8E2xj/40ajvBCYSUCb4EcxD+wN8vbcrG5+R
    kx4Z+CmFSG6/vfDDxQ44y8eFCEDeOrzjbMQw9Av95eqd721e7ephMhBVG63Q
X-ME-Proxy: <xmx:lm6xauqo9bNGE_r1Eo5pxo8p24YWVyMw9gUleabr74Ud4YNKDg1AFA>
    <xmx:lm6xahj_5HV1soUuyw17sKIstkkgmjIdOYmb40xMkZN_BCW_a3JwcA>
    <xmx:lm6xarx1HB1OBMdyOAU0x-0Yu9dcwZOpcpwxC3ACx_yCeZUienUn-w>
    <xmx:lm6xavJXOGRkQmR9YzgPnMOr_khZAmwG3Rno3m2G7vUNWae-SM7Gaw>
    <xmx:lm6xajgN1nx6sBPeX7PzwS8PI-dRvaNSUfWTlieD_q-sFJNrhKwA5ltD>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:51:17 -0400 (EDT)
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
Subject: [PATCH net-next v5 06/10] net: ethernet: ravb: Replace gPTP flags with callbacks
Date: Mon, 21 Sep 2026 19:50:33 +0200
Message-ID: <20260921175037.4084310-7-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260921175037.4084310-1-niklas.soderlund+renesas@ragnatech.se>
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
 drivers/net/ethernet/renesas/ravb_main.c | 87 +++++++++++++++---------
 2 files changed, 78 insertions(+), 33 deletions(-)

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
index db3ef87f0991..b558e9f5611e 100644
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
@@ -1981,8 +1974,8 @@ static int ravb_open(struct net_device *ndev)
 
 out_ptp_stop:
 	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
+	if (info->ptp && info->ptp->ndev_close)
+		info->ptp->ndev_close(ndev);
 	ravb_stop_dma(ndev);
 out_set_reset:
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
@@ -2190,7 +2183,7 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	desc->dptr = cpu_to_le32(dma_addr);
 
 	/* TX timestamp required */
-	if (info->gptp || info->ccc_gac) {
+	if (info->ptp) {
 		if (q == RAVB_NC) {
 			ts_skb = kmalloc_obj(*ts_skb, GFP_ATOMIC);
 			if (!ts_skb) {
@@ -2372,8 +2365,8 @@ static int ravb_close(struct net_device *ndev)
 	}
 
 	/* Stop PTP Clock driver */
-	if (info->ccc_gac)
-		ravb_ptp_stop(ndev);
+	if (info->ptp && info->ptp->ndev_close)
+		info->ptp->ndev_close(ndev);
 
 	/* Set the config mode to stop the AVB-DMAC's processes */
 	if (ravb_stop_dma(ndev) < 0)
@@ -2381,7 +2374,7 @@ static int ravb_close(struct net_device *ndev)
 			   "device will be stopped after h/w processes are done.\n");
 
 	/* Clear the timestamp list */
-	if (info->gptp || info->ccc_gac) {
+	if (info->ptp) {
 		list_for_each_entry_safe(ts_skb, ts_skb2, &priv->ts_skb_list, list) {
 			list_del(&ts_skb->list);
 			kfree_skb(ts_skb->skb);
@@ -2663,6 +2656,26 @@ static int ravb_mdio_release(struct ravb_private *priv)
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
@@ -2681,12 +2694,24 @@ static const struct ravb_hw_info ravb_gen2_hw_info = {
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
@@ -2705,11 +2730,11 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
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
@@ -2736,7 +2761,7 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.tx_counters = 1,
 	.multi_irqs = 1,
 	.irq_en_dis = 1,
-	.ccc_gac = 1,
+	.ptp = &ravb_gen3_ptp_info,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
@@ -2761,7 +2786,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
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

