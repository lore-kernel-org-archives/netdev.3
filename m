Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E35042CB08;
	Mon, 21 Sep 2026 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013085; cv=none; b=IUGZP6oMirF6/Wsv0OwURCTf2VrRKbK9zxYq5+jSNpbh14FXTNcESnN4AbB3ZDxcuFZIK34qJRkDjhupO5qgeBBhTmZEKv3PQ5IT6Yk0LRgD0pXtE0x7E3UE4VHVJSFtKaldMi2sFlrgkuaxwRxQEsEeYfOTT6EKUkbRK/WFKDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013085; c=relaxed/simple;
	bh=AmOxELWrLpRNOOEvuK76rWVP0rdipn8VwhP888W6Ndc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aN1WuOhRzeUfjdAKPZ8PYjZmGF3AJ8UN2lf9sWZAM10SW+YEL8vDNaQ3uJJxUsyPjHtTmHFooh/cqfi5xfoLIZ1rdh0HJfsMGZ0uUwldhXhM8kAwiQ8ZFV+XGeTUcbwzMXLRj+jHY/VdFiChOccZLMCnMTXoRu7/SjpzUfFYn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=DKz9ELD5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MuR0zDE6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="DKz9ELD5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MuR0zDE6"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B52BF7A010D;
	Mon, 21 Sep 2026 13:51:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 21 Sep 2026 13:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790013081;
	 x=1790099481; bh=zlZFTCaCBi4pH01alg4KYleEqNE5ncM5Y8ZIm694iK8=; b=
	DKz9ELD5kfEXegnLqnQrBk7ZQpF/+n2Q1ahs8f7mjW91fJfZHf3GGi+Ymaj5vK4x
	KO8rSPZf59fMhjY5MBey+SBpT94WTWuaWLIdZOhub0oM8v9f/zWzCVNv3twOWnsQ
	PrpXFd4v6UEyQhGCbCb2CromLF2N5A6F3Dr3QooFbVF/G405ISl1MoYWGQZwzMzU
	EVdEBbOR7uHOSNi7xo5DGLRPVYyi6uqS/0OWZXSdaFRWJ+SFA8ZCoGJQJdGLdMhW
	Fzgcf4DjEBLncOxeT6romdYJdCtu6l8fnjZlWH1JNs/cNMI0HYl2zlCqGUQ6iO4+
	yCvkT232+bZ74x8oLkdrmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790013081; x=
	1790099481; bh=zlZFTCaCBi4pH01alg4KYleEqNE5ncM5Y8ZIm694iK8=; b=M
	uR0zDE6A2nkPdJ6LzSr/9l8eLaLzrLtvpsHhTrOKOuWKoL2gHeXgeuz13ZIhL/mq
	RMt/US4vKhjHCucEmCcfPezaFPHluh9brj2qo4fSpaPODK2jG9JgJgO0DZt9+N8h
	3603ItUteKvT0Rsfitt4yJN8/h8lfu7c+pbNOflYl8Ai4Wu4FKbDWDzdMMyM0OV4
	VkSaZG3aC3ffkNt1V5wkjIiw5YSWrgnpKdJII2RiSwbjbWzEr3f7rZjRg1zLCiT7
	t0Adqv8VNY93Q5SdpMDcZwlpvERZd0PbiUpirAAiHWCcjDoxru80YljB8faW8b3U
	rlwnEhfa3JDcHmjAL9Kpg==
X-ME-Sender: <xms:mW6xamaXPq7gwfdmdEYWxBFzlcaWSpCIxfD71atBTQhqojhmZHXCuQ>
    <xme:mW6xagV4l4dePFW4kybjhtdkbueULQU0_np172gDSU-1HdUnJeFqJQvK3jDIGocnA
    a-jfXBWhD3scktOsHsB9758CEBiB9jizPfSkivYP5Glom08dQJcFTif>
X-ME-Received: <xmr:mW6xamDq3X29hiec17waDjXyY5GI1XmyjiI5r8off7_xEv0xqNH5J_R3Cp9CMw3h5pf81mO7XV14XmoFiAwQTqWy582Iwrs>
X-ME-Proxy-Cause: dmFkZTERb8iWuOaCoZl7Bdy7ms8LtfxU+xjK78I80yyQZdvSwOOOfv5Eh589Pe9RlM06WU
    dDnU8HOY0XEZCSLotd4wkziCSyOMbfYp7QQMcpxqxHGnE0sN+h/hwRsMQX/TPzjkM+eutR
    EyTNwAM1tWMwrq7QvnP58hqr16hBRsM/xWQjxvzbUj3rLPulCyCubKGS8/OfnPdml28WZP
    11HBM2ETQKxQIL8VV/A/GNA6vlfx97xrmJ0/jihnD6jQBVLDZo9wvlSWgasgNowAQLofbi
    uJp5/Pi8DlT51OEeXr8hn2lIL64WOU6L6jZxXkbUv9MeKffjxF51gA/7UnWz5uX+sq6JQ2
    3KgReaCK0ECM7CI/ZwVV0nm/nHR05ce5xFEtvEdXyKkMbgW2zNZ7ywqbG7LqCU3/3Qb5JM
    1ba3ZNdMFI/FIU+VrVTQIAnkN8viqaARtDSjHyIUgKPwqbBknCimaRbUbApl/XxYrcjkih
    97nEfmOQClGDu6DZ2+w9RmmuRgedKMYxIziBYBzp4eSXo4RsneTeSvhev8TRT+7I+JU1CD
    lNKlFa9S29HC5G/XIRYhHfRnhIKw57YwLNfE3N1Pi5w7raHt0/y7LqrTx7G1HzRNk2sNTw
    p2zS7Q+ruVAZc+uySkRSSNUIQlmgPb5slXMfADTtc8lRsu08Vm7Hr0E7PfxA
X-ME-Proxy: <xmx:mW6xavxCRW2XZed5ce4JOQAUNWCF3H25qkZ_tVo2Gnvblp0bCMvw0w>
    <xmx:mW6xasbhWiNJ9vvSm6vGLCapLLwYsTI28-xkXl6c63DMeVnuv5jYUA>
    <xmx:mW6xasTc4wf3zJR3GmapM7ihLRtg_6HCfrnC8Grxx9nK7jGFXgpWvA>
    <xmx:mW6xavhfWcSRSvq9KnGgJgEjSstfAyBxXqPyU-H_avRC4N90UnKG5Q>
    <xmx:mW6xaqpsT9aquZ5jHOOqsMo4gfqwaDf8lOij7qhKPvTuuwZpB994Dqd1>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:51:20 -0400 (EDT)
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
Subject: [PATCH net-next v5 07/10] net: ethernet: ravb: Add callback for gPTP probe
Date: Mon, 21 Sep 2026 19:50:34 +0200
Message-ID: <20260921175037.4084310-8-niklas.soderlund+renesas@ragnatech.se>
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
index 6603f90b19e1..b788e8f5260d 100644
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
index b558e9f5611e..77e66a9870ab 100644
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
 
@@ -2656,6 +2649,13 @@ static int ravb_mdio_release(struct ravb_private *priv)
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
@@ -2671,6 +2671,7 @@ static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 }
 
 static const struct ravb_gptp_info ravb_gen2_ptp_info = {
+	.probe = ravb_gen2_ptp_probe,
 	.set_config_mode = ravb_gen2_ptp_set_config_mode,
 	.dmac_start = ravb_ptp_init,
 	.dmac_stop = ravb_ptp_stop,
@@ -2707,6 +2708,7 @@ static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
 }
 
 static const struct ravb_gptp_info ravb_gen3_ptp_info = {
+	.probe = ravb_gen2_ptp_probe,
 	.set_config_mode = ravb_gen3_ptp_set_config_mode,
 	.ndev_open = ravb_ptp_init,
 	.ndev_close = ravb_ptp_stop,
@@ -2766,6 +2768,24 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
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
@@ -2786,8 +2806,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.dbat_entry_num = 22,
 	.multi_irqs = 1,
 	.err_mgmt_irqs = 1,
-	.ptp = &ravb_gen2_ptp_info,
-	.gptp_ref_clk = 1,
+	.ptp = &ravb_rzv2m_ptp_info,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
@@ -2979,12 +2998,10 @@ static int ravb_probe(struct platform_device *pdev)
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
@@ -3037,10 +3054,6 @@ static int ravb_probe(struct platform_device *pdev)
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

