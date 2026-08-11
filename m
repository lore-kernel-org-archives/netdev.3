Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084345517F;
	Tue, 11 Aug 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464314; cv=none; b=i40CFQPOVhboVAcWBZ2TfipHOyoNOZa89GtZbmd1iq+sXHdmVLjU73QmEjAtRcc64uAgtuQzq3mMh3MtqE8hlt8DXIfYl7ILa+qmU4TAv4Guc/VbHM3nkdk94XS6q8gGBvRxzBMe7eKsro5vX4DGMO5S5s7Z12XV1sSuLz4NFqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464314; c=relaxed/simple;
	bh=+UMHKj/AWl5U6q9pADmuXw1UjjzwxMkzhUqlc4qJWuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/jsfvjnVtAfVWgd7zGuMv0ncHjJ92eJeDsPXO4HJDiO9qdHw5vvJ4iUiWMUiJ58R+iqu0FSlMiqrUvhRbtj/wZRtPOqXdMlniuNa2eExHIS5IiGvAq9MohiWE9BbnSeKuYNES+LbxrapVuyYFrryqb2qQUeoRSO14uBEEPw09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=WczuC7U0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hExtp4+l; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="WczuC7U0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hExtp4+l"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B8BDEC022F;
	Tue, 11 Aug 2026 12:05:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 12:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786464312;
	 x=1786550712; bh=w0Sw+ild8QY9toLUgs+gVmzJiPLIByLt/ibJ9mXLaek=; b=
	WczuC7U0/tyo+z7+9XzBWQCoCuWNOJVLSoWRMAXRbt+mBNSfq7G1qJqpxsiYJfQ2
	WUDBGKumtI+AWkpAsrntLZ520osCbH1VNq75ql70DTXi0Uu3YFlXB3yuWoH7Rn38
	nhsg2/ft29vEJ+txhUhnNGcsx1ZsKNsCs/5xm0iL3sYwFqXIUD394Fx7WkOg11IG
	hxgjq81rkEjq4taxzr1SMqmIzMbavlqSN81laPjaamjRK9mRGODlaGXJBUxS4EBh
	/ElHOM/z5+Da6rmWQkEV1t+NkS+3Lh0uNeqoeOSzANc7IyevLEJib74f6Jmdh/WB
	26tW28k3zLQNvZ+9dLXZ8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786464312; x=
	1786550712; bh=w0Sw+ild8QY9toLUgs+gVmzJiPLIByLt/ibJ9mXLaek=; b=h
	Extp4+lCaWw5eyJ2WP/RWxKny4G5R199q1xuS6HlCB59PX1RsjPZ7/PLKSy9tHbI
	9zzimY2lt2YCsv32V22hepRe9mkllb89HaVhNUOWRHL0D8giDdBihXRnPK2RZ/Yv
	sZwhPfbDbueWQb0Lu9rKOzAKg3KNEAE3K4Sl3XejVz5PWrnSmpvypNw6nE76QM46
	eQmmb/NCo+yiiCtj+9q7ztshvT3/0Y2+DeGYTo1i+ByZPn7/zA2wlcCEiE4E6hC3
	yBtrfrfsFzNaLjvhQkSSLCmNK26RGQ/G52B6bMEwyqQMDo30GwdYPZKhBCA/ge/g
	HOriF1pcYiXzlj+fBNy1w==
X-ME-Sender: <xms:N0h7aidnQOIBeqEk3uRnnBRoEQ-ksFt-YGdnfGKbBkLQ6dRFIreFnQ>
    <xme:N0h7ak-RNbnvbLMxCPBrttp5N8iIeduPbF4DGIkfffSSkNw8519VwnPOj1rtzJsAx
    91hnfV2GX2K59buupN2JLBnGV3gryLnORSroJLDG8jGwwvgsWi1gEU>
X-ME-Received: <xmr:N0h7aiP4zr3uyJ-UK3u5dc_9v4Fqd-1rFj4qEh2Synpe5dRfZuoh-j2-fdZvDUmsag3G13QgQl3U1fprWEV8Z3rDmP_Uxg8>
X-ME-Proxy-Cause: dmFkZTElhGmTjMe+fJdnLcemYDcYEsJ6/4gOw6LADCE/XJkMOGvB/IPGYEOE1YO7IB27US
    4g0FhhwmKY3dwTFzGtO1HXPO9EFEOP/UkCak44OHPa6GIimycY9J4lPbuNW0vnGFOnBnBM
    /tFkcoaJPPcfZUu886mslGP6LPpETS48cLJncBCRtXKB97CyqjjM/dDZHjP2L0itpKpp2V
    nkqgHNxJYFswdFmSZh005rtUE1byr4L6m+aUWbZDwNYeW2AwAeFy+MwQay3sWVo9cs1YHq
    yNq3EkCYRKkqUiSx/jZT5sXXZ4CKef49kQQGKS5OyMYD8j/NtFs89/if56QZV8gJjeSgpC
    VB8jBLWXkf/dfZ1kyevJswVjBOwXPqEpmx2zfFQewbmQU/FY0Pt+7+Q2y+vHnPLb7RcTDR
    nG3HicSa4gvBWK01Plxy+N6hiihIHlkMojyVyVXPDzYrhModtRPF02WGPZ3Q58Tq6cx++q
    HqYxsLbSuT+oaEuoG399ItitZuMzc//u73TtxJuGC9Ov/9Op2bPS8YlfKed/wK50gFRhEr
    nB0ZbcerKtmPPY+4Dud8LrnKxpnUJYRP+b1gF5gcAuTGl95RGXVHRlxL7lyjQhdES9cAGh
    wDE9NzDeWYHp9VcPSVpad8fftVMmt0hWMovtkV4TvepGklXRP+l1orUwfPgA
X-ME-Proxy: <xmx:N0h7aiWwbUBy5atYYzEIYNieQc8oriLC-qEVSaQoTEW9SfCGWwpHZA>
    <xmx:OEh7aij9xw4IO98rnjIig8hWQ-3In9xx6xlYCyN10vyIQXPQ7v7KyA>
    <xmx:OEh7aq9wbw1GYA5zGQamLQWg0I2bm1Pb_9X8t65x21sVhgrQr4tqsg>
    <xmx:OEh7ahQ-qpDuZkgHvCx5WejRoFzVcKNLGsmpWMopcNB6nCVf27jwKA>
    <xmx:OEh7aq2pwOPWDK7vywWVSq0AVn2k4r1BvWOZNxd9Y2cQ3f7TFwgJYk5i>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:05:11 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
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
Subject: [PATCH net-next v2 06/10] net: ethernet: ravb: Replace gPTP flags with callbacks
Date: Tue, 11 Aug 2026 18:01:56 +0200
Message-ID: <20260811160200.2049987-7-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
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
index 39892f0f8e62..c98228cfdda9 100644
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
index b3cc4c79b29f..d4d03de381db 100644
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

