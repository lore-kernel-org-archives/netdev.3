Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A723B3A3E76;
	Wed,  9 Sep 2026 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975083; cv=none; b=eSBxkuDr5eVOG3g7iUu57dNJFVCHc/UZPbUFZWQO4XY7dHPqXILKYgiwyiAMca0R+lILFwAIQAnVf2AO9lsR2B61GKwPhuiFccrrw6N1lUMuWaKzPuS2hjQ10CiRI/eSxdT3H/7eNAXd74KlsW4XRFNSlwOsda5IAAmJxlzuLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975083; c=relaxed/simple;
	bh=93JsYLxWf43Z4lB44N6XlCD1AtrDkTa1YbfZxKouPFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzND3Jz+FjSNA5VWYW3FLdTtfDYEV2YuhwpeK36t1eInqJ3NkKtATUu7GRQ+hJ6bFnI4qg1Ib1/TW7giQLCiOdyGM2c45CcaKc8TtUPmdNXEJDEPxigAl/bz6TQmgrQKf9xT8s/PEaQmEbxIVxB0iHQBHSd0AIM2s5uqL2d/7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=o/Wpv8ln; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sQuV9hnl; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="o/Wpv8ln";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sQuV9hnl"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 797A27A00D5;
	Wed,  9 Sep 2026 13:31:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 09 Sep 2026 13:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788975080;
	 x=1789061480; bh=3As11Y4/j4vd5fRYoUyxOaAShGEnhOe+hveBHuRB/W0=; b=
	o/Wpv8lnLoNUrQX6mo/9sG3h19xFiJC2zR3johSrsRMhYqvsXhOT1NWPROmpkkk2
	EDvAOias9t66ujJ6wN8ys0oPxtoTO09+AEXN6Xx5XxzXCGBdxmAciNlEBgebGCT/
	0h4wCTTP8BGBRYvXj0bBahgFaimE+5skMsMfQC3Wrs4kttXZmkl6T118vrmIn23T
	AF/KQut1nc4xoqB/JYDx0X4z5hKV6oP3eX3O0WJ8o437PswW7Nx9628uTARmnFYR
	ttkY9tYnbhUp0QhozznRPe0Kvea82qflVCytcC+vMlzi/2/rpn09ghoc+ywuvAhc
	STkT1h4cYD28SWERRHx4LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788975080; x=
	1789061480; bh=3As11Y4/j4vd5fRYoUyxOaAShGEnhOe+hveBHuRB/W0=; b=s
	QuV9hnl0HtusgbiKgJsME79BFJiP0DhC3DeHclUqwWau7Kzcq3fO9eqj9h+vzCid
	itbdRs3OcrVIN6wKmH0wWmybbYoQ7G/DEapp+lkAQwEq81h5DxyB3+TXhnIXr5TZ
	Va+67SVP5DeGZGCsgmxowP5JJfedNUIbe1MqF8/NuULRZ6i5QUPuj70uxQcJ0HeY
	twFZaGaMHLEfOb019Vfn/WKu3SG1SUxeF45NwBa9hQkkgHnwrY3UeXQ17UlgMnVL
	PragoiNADJBRk00ZzTB8poImFAeX2TuBtq9lV/LRVPgjpofmIQiOm6ylzv3PxMq1
	o9fW7A7tWESKzU43hMC+w==
X-ME-Sender: <xms:6JehapBawUfUA7aCPJgq67sazsPoOYzcaZAe-JR9ZDWp8L98OeH5yw>
    <xme:6JehaudMVLaoORWKLVAFqvoggYIdytWE7nQCdEjrB9XjFsZyMzJWtijkeHuALdhSw
    cWWzKfMxV05WAXL3KBcAjyaky_C_2KjYwWo2A1ZvOHbf7OotnD2zhTi>
X-ME-Received: <xmr:6Jehapqa30fp6TkuLUPK0sAhBi2sC_Xa6SXFUIq18ivFXG45BxAozTMcR5H7dHzN2jpyA7ZCwDM2ZOdNwmCR0z87JruMTGw>
X-ME-Proxy-Cause: dmFkZTFpKuOoHA8K6npXM0EyPQ3B6fuJj1V92yxTkRTwTvOrGLmaogCPSGJNdxe3w3n+ts
    3Bnq9S0gANJKKK31pjNWK50OZ9a7PMq2fNO8DZXCQ+/ff2Kmc+UHBXNITlDnGREVxg/f50
    czaZu7ewfHhQ8KEOahciUDlJaktTnHuAyQxRzBwFm86u+eYYubMr2Wb9/todjLgmh5z450
    82zfjBukuoe9N1IpciNBSfLDvZO88JgjH/tASHI61YFG/pSFyNvmg0AvAJCBYM82e580+H
    IntiqdDAd7FDyLCJPHSk55kS+5m53Gxxbft8dJNI3qmcm7XJFRCQyhfwNMEehhg0cLBjn3
    1FXMrH2iGxIIyuhcsC8vaqNVJNAN6u0+/yXgMpsQYahv35X9RyamMX3hF3mchImcRo9Jf3
    rNvai9/DccOg8InC/rN/THdCLScIF5/V75dj4s4izcfq93rkMQqrwGHRAR46Nqy823qP6C
    fbMTCkorDbRtMv6EJnENY5kpX370cox0IBa+TY1Wjuhljeh5rKO9imwmLm7+mkP6tuRe6F
    4pcuQxlHpQO0mOlqCMxx8uL4NFe7LdJ0xp/PWNMi1xjoksiz+OYd62XuLWd1DQO/ZQwFe/
    +44U8Yud13y5qWeSvvuh/SHQzfWaQJWW3DfnDsOccppbIzunL8+y2eKZoXSw
X-ME-Proxy: <xmx:6Jehaq5nybUJtl1q9UqjaLUc7tyFIrFSone67JDHXdrlScTpnm57MQ>
    <xmx:6JehapBtruyEoQGnSMab5iwFZSDhzkg8MEGrYtDZdzwvHefglWsqbA>
    <xmx:6JehasbdRdpsFMAABZhaN2ARwcGOerPBuZtSg5UzBJqBlws9WSkgKA>
    <xmx:6JehatKZ0w6qyECSJzeui378EON4sTaQQ1KlrVyRvfcdaxQTUuOyKg>
    <xmx:6JehatymmbTq9Z7E_lOOTqQ1SjSpdflODM7aWjC-qKDYL4fPkPok4gLo>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:31:19 -0400 (EDT)
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
Subject: [PATCH net-next v4 08/10] net: ethernet: ravb: Add callback for gPTP clock index
Date: Wed,  9 Sep 2026 19:30:25 +0200
Message-ID: <20260909173027.2201560-9-niklas.soderlund+renesas@ragnatech.se>
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

Prepare for adding Gen4 support which have an optional external gPTP
clock. Add a callback to get the clock index and use it to determine if
the device shall report gPTP support.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
* Changes since v3
- Add check to feed sashiko.
---
 drivers/net/ethernet/renesas/ravb.h      |  2 ++
 drivers/net/ethernet/renesas/ravb_main.c | 22 ++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b788e8f5260d..27e2b31955ba 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1042,6 +1042,7 @@ struct ravb_ptp {
  * critical points in the RAVB driver.
  *
  * @probe:		Probe the gPTP clock
+ * @clock_index:	Get the PTP clock index, if any
  * @set_config_mode:	Enter config mode
  * @dmac_start:		Called when the DMAC starts
  * @dmac_stop:		Called when the DMAC stops
@@ -1050,6 +1051,7 @@ struct ravb_ptp {
  */
 struct ravb_gptp_info {
 	int (*probe)(struct net_device *ndev);
+	int (*clock_index)(struct net_device *ndev);
 	int (*set_config_mode)(struct net_device *ndev);
 	int (*dmac_start)(struct net_device *ndev);
 	void (*dmac_stop)(struct net_device *ndev);
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 1092e8ada188..8617c30dbb14 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1773,8 +1773,13 @@ static int ravb_get_ts_info(struct net_device *ndev,
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *hw_info = priv->info;
+	int index = -1;
 
-	if (priv->ptp.clock && hw_info->ptp) {
+	if (hw_info->ptp && hw_info->ptp->clock_index)
+		index = hw_info->ptp->clock_index(ndev);
+
+	/* Only advertise ptp clock if present. */
+	if (index >= 0) {
 		info->so_timestamping =
 			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_TX_HARDWARE |
@@ -1785,7 +1790,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 			(1 << HWTSTAMP_FILTER_NONE) |
 			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			(1 << HWTSTAMP_FILTER_ALL);
-		info->phc_index = ptp_clock_index(priv->ptp.clock);
+		info->phc_index = index;
 	}
 
 	return 0;
@@ -2653,6 +2658,16 @@ static int ravb_gen2_ptp_probe(struct net_device *ndev)
 	return ravb_compute_gti(ndev, priv->clk);
 }
 
+static int ravb_gen2_ptp_clock_index(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	if (!priv->ptp.clock)
+		return -ENODEV;
+
+	return ptp_clock_index(priv->ptp.clock);
+}
+
 static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 {
 	int ret;
@@ -2669,6 +2684,7 @@ static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_gen2_ptp_info = {
 	.probe = ravb_gen2_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen2_ptp_set_config_mode,
 	.dmac_start = ravb_ptp_init,
 	.dmac_stop = ravb_ptp_stop,
@@ -2706,6 +2722,7 @@ static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_gen3_ptp_info = {
 	.probe = ravb_gen2_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen3_ptp_set_config_mode,
 	.ndev_open = ravb_ptp_init,
 	.ndev_close = ravb_ptp_stop,
@@ -2778,6 +2795,7 @@ static int ravb_rzv2m_ptp_probe(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_rzv2m_ptp_info = {
 	.probe = ravb_rzv2m_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen2_ptp_set_config_mode,
 	.dmac_start = ravb_ptp_init,
 	.dmac_stop = ravb_ptp_stop,
-- 
2.55.0

