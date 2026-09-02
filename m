Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A424B3F44D0;
	Wed,  2 Sep 2026 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338853; cv=none; b=QmaLyh7nBQMsn03YJ6QXoufjqmbQO60j2EHT4xDhFvLVW3eVnm5CjfsrdDaXwl+hh8FEFQTJDjJTvIaT0e/osQGvWttJMkk2C1TTLcWIssaG0m+4bFhQxiV4Yn+8BKGbU/INoV/Pht0n+OfEblokbPLzW+Zrw8tVdagMw8iFJVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338853; c=relaxed/simple;
	bh=dhlxiGjrLUGHlJXpb2dlG2sEi65tZ2riSQDSjXSMeAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEvpzYPQ6+hJM+uNiC+79o5TmslFOdUSw9b9hzeRyiXcYKWJvkubyjQ8CxLO3cGbnyKUPaARALRJBFztwW7dypXsZSD13GD1q9b9PCoAKFSO3N4Vli2rBFH9PFoqHlZ6MXpsXnPQii7WVVipB+gw93M2hRIv1p8JpbK4bymgWRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=PLuPo/ga; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CPCC5/Jp; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="PLuPo/ga";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CPCC5/Jp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0C5D5EC01AC;
	Wed,  2 Sep 2026 04:47:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 04:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788338851;
	 x=1788425251; bh=FHzBs/nA07B3oI6xHsMBW1+r1gXxFg4r8/9iMWdsUSs=; b=
	PLuPo/ga3b3aSwi/A4B51YJVm7v+lLQVmBEkDybeF7fyVZnyfCiJpjT7EC1dSPrV
	aLGldONcVhDRzh8XJe403Qxlh9DnhiHhtepeOGHpv0BkWAW7uh/TsCK219pEsSAl
	DifCTb6AAzOZnkch7lfaxpqJG+TTrEZ4VK6WkAa8hekMSIxCDapz5qLsosbmTPV+
	CTJ5oFCSpWCybJhxO5uTlp7mxTc7RxvVFtu0cWmhwLm5suq5xoURsVNAcjSa7r5e
	grvz07JVBy0r5gGt8JlX3ETq8EKet0YAz3N6jRJB+UDBfEkm4Dz3zWPBHToTPaqN
	Hp6WMgSw2JCPK1tSGFMbFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788338851; x=
	1788425251; bh=FHzBs/nA07B3oI6xHsMBW1+r1gXxFg4r8/9iMWdsUSs=; b=C
	PCC5/JpD0hfhPyWcPEFNQWBrcyE/49nxcdV8rY/LRINTHNezm+QVpfvmqCbjYwQV
	R5y02dlh4PSwcV4oIoRCsQaWkqOt/BZ2bP9HGYPT2BsiJTTLyhcsL5+HKTkiOMZy
	+w4kQyI5MU7kf0+SheDgcFMfurFPoE+AqYl+P/bZ3VpCFTtfVkLpgziiidCDLvgO
	S5UP9IyYYEgcwb4HmUrQhxizVTZ47cg0fnIWrWC9bxi9N4yEnvAwCXMACrsco/Sp
	xzQW1w71+bYbu/zUEVElfRzprw8zWWTg5+otEWbsJo+tT8Km3zIuOi7AS8mlX0mw
	xRQMw/28/YV6SRz6DWXRg==
X-ME-Sender: <xms:ouKXakCQ5-L3bcwr7cjf8k2UCP7rAVxaWGzbXq_0HfbgpOprRjlQwg>
    <xme:ouKXavSGWsCiPyIPlpfAGLCfnCyNfks06lXfFcThH0ZDXMpdOuDzFAQEyjRWldMkN
    DaHs-HAYn6YiDb9Yr0bmku1g0py1QnrgNcUvMoAGAqdwXrUAZczZw>
X-ME-Received: <xmr:ouKXamTNWYeJ9fil0Nrn9Ab0kAZlSyxhp600GWgU99NE0Y7xi3U3WmMk0Gq8zterzURx9f-HInB5Y8SQnVGLQQwqj_1qlpQ>
X-ME-Proxy-Cause: dmFkZTFHjnUyY1U5BS7KEyYHW6mbLs/20m2EnmpCTZEDUSYJbgHxuLzNcdkHb69EViapIK
    BaRfAzM7q7Li/vZA1mzh5vVkh/IJJYNfi70rWRpeeskGmVZMY1YGMFy3rK3dT5ZIvKTU1u
    ZOepoGcTZ9JrI8vZNeHxr8c6r9W5IE9t+6GJsNqs9uIBRD/gNlDL9XaNaCpNxqqjn73QRN
    zG0EtIshYxy79GfwETpB6wmPHMH7GJZ2QsDNn3VXqpRcxD9NLQcLiy6RxKczE2KnZ1d1Ap
    yh1ZuQ+N/yULsJ67JSFZ5GoxaP5eRHHlSPkL+HXexWhOJY5HJA4xzkTRjbjbsxxwdnlPI6
    VpKE1fGtxaTdQdD1RKG/63MBG0yud4rMtGKYB693J5pBlrYEkFTM9QoWjVsUMaVCHJSzBq
    0yF8cg1sUEuM/Od3Rhn7ottYrAabq4MJyGcZ0vojNc8axR5P2UVLgnfe/BbyCb/C9w+LVE
    /MmAbkL9bk/S+bMfQ+cTleIBeA2hVYZWRpR85S4yQ7BmvmQmvR5OCPVgpYPuecTY7y67A4
    Dk9V8zbPDv5mf+mkYHsq3cXLUGtRZVVaeZzoOoUI24VqcgwjkSG4HGTJwmpGx1peBGL3lh
    MEcSIDE6K1d6d5+xo1g1dE7820QDqy6qIw4f5QZYmOXH9AtU7QxsJXWJxxSw
X-ME-Proxy: <xmx:ouKXatLiDsJ6lVLylEmEk0WSkBCOm1dEuWZ31OscnWCyvR-eLsE2gQ>
    <xmx:ouKXatH-bdGiMxGq7TA-UZsndUS2dr0uIdw-aR0WaZ5YTuyQRfEVAQ>
    <xmx:ouKXaqT7ZymLPsZOKRF9bbpOoic1YxNBbRa3X4CAzxxs_Ij4O03q6A>
    <xmx:ouKXamWGMVbMSdAs9RV5ae27Mb6ufwNvT38R1oDIenev3prjZX58-A>
    <xmx:o-KXalYyxh1WoqUP-un2J-kPAJwRRSmxlaO9SKC4HKecI8m9KcyG3Pbd>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:47:30 -0400 (EDT)
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
Subject: [PATCH net-next v3 06/10] net: ethernet: ravb: Replace gPTP flags with callbacks
Date: Wed,  2 Sep 2026 10:46:59 +0200
Message-ID: <20260902084703.3228504-7-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
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
index 7c7b3ac81e5d..5d5b9c0e2f45 100644
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

