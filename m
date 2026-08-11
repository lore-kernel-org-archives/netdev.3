Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6639E4562A1;
	Tue, 11 Aug 2026 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464316; cv=none; b=GuFYXo7jC9i7MC5D4UI5SbF5FnvPilgsFJ2WSeopiH5fWaj/ee2k8qVnqiDmKwWgnMIpamSuYonm7VIxRkkuhj0JmD5+fp6eza2G0XDjoFHOekj4SbQklHBGR+9+SDYyiJ3YRSFAVcc6px60LspnacWRcADg37bMm40ZwLFg3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464316; c=relaxed/simple;
	bh=nWazujuYm7EJMkiX1SzLlPFuVQiA1PBM3rE/df54fMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gX7ZpsVYvmy4ekYcYzy/t0MzhxMqJOiyTO4sAwJ7ccbdYVMSmg4N6a8QO/WHmKdT2IWS8Utu+o3nQGwtrGByvBx7hv4WNweA1NFcjAbErx3RFsP/w5k844EDsyJFPTDnEhHyYl9ksRPlXjdpDpQDRHGLAuRuHB6WCgNqIXae/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=L1uS6+17; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V3dtQFN0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="L1uS6+17";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V3dtQFN0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AEF2AEC0230;
	Tue, 11 Aug 2026 12:05:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 11 Aug 2026 12:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786464314;
	 x=1786550714; bh=T87g0o4PfeNDwnQQwA1TgvqU6AZkLPfc7ZKKPDzPkOk=; b=
	L1uS6+17DTh7fYn8vRJwuv+Rs+L5fgE3nF+PfpSPEMH7QBlT4xfytKJH8SG7KLSi
	i1DOLGpYuSLp2bAgPzWJmO20bLY2k+KjjXoPrPDp1ack/AQR2CdbeKhqDHwlAjWE
	W8WA39uQFrB68xxuHIoYWtLszDTw2r1V2FiO/ZDcf/IqupjLCAU6Sd8EbqiJkNKu
	p2z9SKh+/W+IxjkvLyf/4PvDpGoFKWK+KdHsZsa1l6lxsGcuqVLawZllORIGr3JF
	JKV9968c8/7CZm11c1AG5GsSKcXVUWI/5rKy8Mgi3+0jnaTcjLUAEKQoWeUC9bNg
	3fUeJHN+UI/Gqwkk54AmOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786464314; x=
	1786550714; bh=T87g0o4PfeNDwnQQwA1TgvqU6AZkLPfc7ZKKPDzPkOk=; b=V
	3dtQFN0c5V1ahKXBa2xh4dySn1YzwBeeanB0wxR32pw84jXr+Npm9RPLJUCMU23j
	+4wHBTbdonNYSp8dWHKrRFutfgPZo5Y5fx6sWKEYgp7EAbQDrn+pGBvqFqKFxzrA
	TPzK1mBJ93X3KMEqfViT5li+r2i1m8P9g3Rmt+dwUKjRmgSRND+qLHlFFsaFi5PV
	XoE+G0Cq0kjUp56GGpT6+smXEpwAiNxY3484SdUD7hVgABYojDD15qzHe90zbcKR
	gertETdKTYvYX7v39Huj3qyr6ku4Y1uWYqQ8gOQoVhYem698556s9y8lh8Osp4Hz
	oJWO9oOQ/5LOIZpF7dZzA==
X-ME-Sender: <xms:Okh7agJLLALx1zV2SDPA5UMN87cNkqxioE0OZ4UAdYEAte1Aim3PAA>
    <xme:Okh7ao5XQDecudwpwFNh29BD3qO_tzNC3Qk2sTHWp9KKg0uWsYVE_GR9DmaV7D4Ur
    -rllU30qkYinw45gAkTAvwcpWta3SaaNgkU6Sy1iHkDnpQkYe2QH2Y>
X-ME-Received: <xmr:Okh7avb6lXr0xG5OuSqHNMd0pptUNyRO74pUntSWJOsPY1iAeahe-IxkTBwrLJJwlcr7l4TOj29gAuMQMPWEX2hiWq3No38>
X-ME-Proxy-Cause: dmFkZTEHSKU/mHe+6lT/LKJ8bgeRk/V053AqRrN1BR5zk1Shu2DOwdZpAbiAy9Gu5V3kwl
    d1h5rYgq3ypc8+YqRDw6+W1dLYGl7xAf/JnE2fouoUr+uQ91a2BYYQH9MIj19hgAFS85bG
    HKLTscK1JcTpPAqcQJWvsSlbtUp0RdE6RTfSS+w1mzdxNe3xP0yAJfQK9V9lP6dWT+dM4P
    mUlTM4aI20t5AwNoSG0JmkMiw/Mr+hK7RWJaGzCv7Qao7/mJJZshfXyd+BX97L+xujDMkI
    ysyzJYX2sNeQaedRdU3MhBFGetibaJ+uJ7gBG5oaNX//F32Vx9hqF9Rh8nKQaqzD+8IAkb
    C/L1QsIjXxELub3bb8ua/FMGI8D89c48hL8nR4jlq75czVB6L8DDRLRDVgGvonqAdgFXfa
    ktS8HVVywHpQ+U/Pld7jpPA7Ylw+2mQGdRI8kt2Z9Vb7uD0zdWtgjDmHdi25GzUMR26BFh
    vz1ysBKqPKmbyY3nbqI5CS+M0EuT6FmE5HSbxOz2nb3W2wjmSnECUljCf7oP1sxOQc6JCZ
    u7EjrQf8ODm/j+7un3FI9R7aC8vFlTLcjGshxyYKqRGtIVITe+aCWhXIBqZ6aJQbO9nHcs
    bwdi/dwQvRv4oajqFTzA+C7qcCyv1Dus/+LskeJqVgSis4PS3zvPv4VV2PzA
X-ME-Proxy: <xmx:Okh7avx1NwL4G_hea2_uhKGjS0-KqX1XwnAB9qQLUt9JBu_RAfQHJw>
    <xmx:Okh7arNjpK12jOPuFwS-8azfePFYKNPhkLIpewMkakoe8jv8uR_hBQ>
    <xmx:Okh7at77i8cDWHRolfYY9GmCDJ0XrCZ3eCuNdGwILXzUZJDojcOeKA>
    <xmx:Okh7ahe7MYWUTikUqhIcdnPJ2uBtnyCfBGKEtD5Po4HCsMlwI7LZZQ>
    <xmx:Okh7asQIg0fzzGCwYBQq0tWZNrS34ibl1hBu2dp9FCZ8hsy6sQ-BXyB8>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:05:13 -0400 (EDT)
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
Subject: [PATCH net-next v2 07/10] net: ethernet: ravb: Add callback for gPTP probe
Date: Tue, 11 Aug 2026 18:01:57 +0200
Message-ID: <20260811160200.2049987-8-niklas.soderlund+renesas@ragnatech.se>
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

Different generations of the RAVB IP have different needs when it probes
the gPTP timer clock. Add a callback in the PTP information to allow
each generation to probe its own way.

With this the last gPTP specific flag (gptp_ref_clk) can be removed.
However the primary motivation for the change is to prepare for Gen4
support, which compared to other generations with gPTP support does not
have the clock as part of the IP itself.

Gen4 will not need to compute GTI value as it have nowhere to write it,
as the gPTP clock is external. For this reason move the computation of
it into the newly gPTP probe specific callbacks for the RAVB IP's that
support it.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
* Changes since v1
- Improve spelling in commit message.
---
 drivers/net/ethernet/renesas/ravb.h      |  3 +-
 drivers/net/ethernet/renesas/ravb_main.c | 53 +++++++++++++++---------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index c98228cfdda9..60f32bfa48c6 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1041,6 +1041,7 @@ struct ravb_ptp {
  * with the gPTP clock. This struct provides the callbacks to be called at
  * critical points in the RAVB driver.
  *
+ * @probe:		Probe the gPTP clock
  * @set_config_mode:	Enter config mode
  * @dmac_start:		Called when the DMAC starts
  * @dmac_stop:		Called when the DMAC stops
@@ -1048,6 +1049,7 @@ struct ravb_ptp {
  * @ndev_close:		Called when the ndev is closed
  */
 struct ravb_gptp_info {
+	int (*probe)(struct net_device *ndev);
 	int (*set_config_mode)(struct net_device *ndev);
 	int (*dmac_start)(struct net_device *ndev);
 	void (*dmac_stop)(struct net_device *ndev);
@@ -1084,7 +1086,6 @@ struct ravb_hw_info {
 	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
 	unsigned irq_en_dis:1;		/* Has separate irq enable and disable regs */
 	unsigned err_mgmt_irqs:1;	/* Line1 (Err) and Line2 (Mgmt) irqs are separate */
-	unsigned gptp_ref_clk:1;	/* gPTP has separate reference clock */
 	unsigned nc_queues:1;		/* AVB-DMAC has RX and TX NC queues */
 	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
 	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index d4d03de381db..743f53f61bb8 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1842,21 +1842,14 @@ static int ravb_set_config_mode(struct net_device *ndev)
 	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 }
 
-static int ravb_compute_gti(struct net_device *ndev)
+static int ravb_compute_gti(struct net_device *ndev, struct clk *clk)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	struct device *dev = ndev->dev.parent;
 	unsigned long rate;
 	u64 inc;
 
-	if (!info->ptp)
-		return 0;
-
-	if (info->gptp_ref_clk)
-		rate = clk_get_rate(priv->gptp_clk);
-	else
-		rate = clk_get_rate(priv->clk);
+	rate = clk_get_rate(clk);
 	if (!rate)
 		return -EINVAL;
 
@@ -2653,6 +2646,13 @@ static int ravb_mdio_release(struct ravb_private *priv)
 	return 0;
 }
 
+static int ravb_gen2_ptp_probe(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	return ravb_compute_gti(ndev, priv->clk);
+}
+
 static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 {
 	int ret;
@@ -2668,6 +2668,7 @@ static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 }
 
 static const struct ravb_gptp_info ravb_gen2_ptp_info = {
+	.probe = ravb_gen2_ptp_probe,
 	.set_config_mode = ravb_gen2_ptp_set_config_mode,
 	.dmac_start = ravb_ptp_init,
 	.dmac_stop = ravb_ptp_stop,
@@ -2704,6 +2705,7 @@ static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
 }
 
 static const struct ravb_gptp_info ravb_gen3_ptp_info = {
+	.probe = ravb_gen2_ptp_probe,
 	.set_config_mode = ravb_gen3_ptp_set_config_mode,
 	.ndev_open = ravb_ptp_init,
 	.ndev_close = ravb_ptp_stop,
@@ -2763,6 +2765,24 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.magic_pkt = 1,
 };
 
+static int ravb_rzv2m_ptp_probe(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	priv->gptp_clk = devm_clk_get(&priv->pdev->dev, "gptp");
+	if (IS_ERR(priv->gptp_clk))
+		return PTR_ERR(priv->gptp_clk);
+
+	return ravb_compute_gti(ndev, priv->gptp_clk);
+}
+
+static const struct ravb_gptp_info ravb_rzv2m_ptp_info = {
+	.probe = ravb_rzv2m_ptp_probe,
+	.set_config_mode = ravb_gen2_ptp_set_config_mode,
+	.dmac_start = ravb_ptp_init,
+	.dmac_stop = ravb_ptp_stop,
+};
+
 static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.receive = ravb_rx_rcar,
 	.set_rate = ravb_set_rate_rcar,
@@ -2783,8 +2803,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.dbat_entry_num = 22,
 	.multi_irqs = 1,
 	.err_mgmt_irqs = 1,
-	.ptp = &ravb_gen2_ptp_info,
-	.gptp_ref_clk = 1,
+	.ptp = &ravb_rzv2m_ptp_info,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
@@ -2974,12 +2993,10 @@ static int ravb_probe(struct platform_device *pdev)
 		goto out_reset_assert;
 	}
 
-	if (info->gptp_ref_clk) {
-		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
-		if (IS_ERR(priv->gptp_clk)) {
-			error = PTR_ERR(priv->gptp_clk);
+	if (info->ptp && info->ptp->probe) {
+		error = info->ptp->probe(ndev);
+		if (error)
 			goto out_reset_assert;
-		}
 	}
 
 	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
@@ -3032,10 +3049,6 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &ravb_netdev_ops;
 	ndev->ethtool_ops = &ravb_ethtool_ops;
 
-	error = ravb_compute_gti(ndev);
-	if (error)
-		goto out_rpm_put;
-
 	ravb_parse_delay_mode(np, ndev);
 
 	/* Allocate descriptor base address table */
-- 
2.55.0

