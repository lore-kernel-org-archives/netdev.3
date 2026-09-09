Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22239B4BF;
	Wed,  9 Sep 2026 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975079; cv=none; b=Xl9Q4bG7iig+VhuTTDbXvEUq8LtWs7o7xOp97LmGtVRch5FCslNwlhh8iYIRgKnOWgG3ZaNSxYUulPfWTkX/LeGML/tWLspDI7F/1jS6uhnJCcPDqEfTETEfYu4IRGxzn3ers6Yg/jq+K866HpLmkYiRi1XCAmTOqmGKFX+LhXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975079; c=relaxed/simple;
	bh=PxMbZv0PCG64WZi3JTF9f/IhuydEEm5eAfOa7M+FiP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FyVtqAf0Tf08RkwOm2x5rkjfTWp3Gazq+rGTCQT1FyzqaMIvDCvxoqK+IXQC1txsRb3ESPCzmH5z3ryFOKQQMqL5vOCz9N1eagA1vcJa+4uQH7ia5u8NGnN+/Umq7qv8VCVhAO9p3lN1GHVRkg9pM8ObiY0wyVPD4EgOx4RFqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=XyQXRKAW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n89dOpRf; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="XyQXRKAW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n89dOpRf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CBB311D0010B;
	Wed,  9 Sep 2026 13:31:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 13:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788975076;
	 x=1789061476; bh=5cv8y3BXMbHx5oTK4jiSUap3Dq6Hfl1AS26ZX2vIoQo=; b=
	XyQXRKAWtXsoKsHGNY6Zi7I4urMGcGaDzAymieN+YUs84YZFFQBNEVhmuFUKZ8Wo
	frNM8rKFAdSEF2tv4zl5Tnb4WLLg8nZsU6KrTqBSwrEyIO9gbYNCLBCAhXDxWBHo
	xf7sYe9jOgjMiSyyYv0LBgclJnc4t0mkGM3aclDx11RYK7os0UeiYRES6GtVOqeQ
	O9arHkgAsnCfE+ZShu5cT/nWHlGYBGDcKyXOvOYhxAtWXC3e6hHpxXCc22nH1NnX
	oHuAGLwkz4kEPNGtrC+QV++BUECqbuOHoHD4eVBkZ1g6GP9OJXp/aHxxy9gbdPpT
	7O1l+AnteRPTOxvuUBw98A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788975076; x=
	1789061476; bh=5cv8y3BXMbHx5oTK4jiSUap3Dq6Hfl1AS26ZX2vIoQo=; b=n
	89dOpRfqB0PGNFRfh146YqdPjid3Fea2gYvGkGnzm5vGz72FEW8ZE1eF4urhGZvc
	OidExbY1ObCSZ5cRUx66zKmsfrkmCvEB/e6uIeHpj1qxhgKbQPB9Vpgo/SCWx5OF
	e1ZkqgOzze/mUprNW2I62jcQHT2pNc3Bzxjurf8QyHuAz9QiY8i/oToqY8QhnNFc
	p/YBFBFCVHkbEh8JypDtlmwMUZt/qdguZQ9lYpcPs+01fzasyAbTV//dfW7c040t
	Merm1stL0d2twua34ZJimWB83VX1Ut+7HNWHG4EaNcIixItUrLhpP8JgA+SI8eOX
	KKWqIBvLrQivIjRKLq3Fw==
X-ME-Sender: <xms:5JeharmBDfHeUEHKo4PwJxcVajmUXDsKGPheJy_NE_PEOBxOIwaLbA>
    <xme:5JehalzPu95wPPV3t_Mhn4UJ9jv5nCgTNsrteSjYvkXCDQ5c1pSTvcsaPzkxkuyNL
    xJ5SamX4N10lM1CW5efo9Cjiez-HVHUeiNjI3BpVtibJGhGMaGfuSh4>
X-ME-Received: <xmr:5JehamtEAzW88sQbnW5FiH3aQwl2ZS5WzyBlRojSLo9YkXwoXaL3Lq3Ml1fq5d5p5CIMS2vZMHqlszUBrYEBk1EwpEKMXKI>
X-ME-Proxy-Cause: dmFkZTEF01o62KOqUAHAoE+QVORj7r8TaCrIRf5OPWQ9Sp090ondym5bOSJDH9EhDA0N1J
    m6oWrIHZUlXi6Du7gssdeyy+/BlAkuIXaHCAN1uAugotP20y1lNMlpeZQus2Nlz/ti9KgY
    FhB6kaG9EPjkChJBP2fV57Rf5YCpIccezHDvjFb5cYW7BGEV2v4vM6aFtwlMNxZ7lMRyEj
    +cp5LwLEc2MEUsvUI+o18XYg0zrEaWvgxZJMSqPSeKERfPJg0jhZ39Wpp4IzKso4KrZ+Jd
    nafFym7s9udRKlmBiDB8FyT/3eFfMJ58g+x9eInhq64X5vYSgsZjNwy9qzGmVDF5g97HXB
    GLrJwgkjE0yByJgzDn6GtLgw29Pt10aVDF4yWayZo5xdEdXBghTH899wY7ewTUBeFJ6xDh
    vfj7X3ucptvKxRw0BczOUZ0RhZf1WaWWVniimjDwNnoyNkbeT3Z/zG9KX36IElz/j542iA
    dSw6HYSnf38StY0N7wOTVMTsTyAYTx2Y1S7oZzPDV4tzY41qevBT9i98Q1rHMMlUrXSBTu
    vN3uVQq4z7ViWO9caWbpPkmFLbatP5Mmttlx85N1gKY57g9/y5Xe7mKtR7EDkedx6lJ07P
    VwR6frzKgvT5ap+ES7tonvhcic4/acvqE7LldOjEbihZnpXEqwVCHbQN6g9g
X-ME-Proxy: <xmx:5Jehaqt7NoO-BzSNYHVBUzSqGprrmTPhfdVzqjIXSYF63GZPLK1uOQ>
    <xmx:5Jehakk-UTcA7CHH8OU-swDn6PbEGBXOsebN3Aa5by-5sEosutH96w>
    <xmx:5JehaovyqsE8K11LdjnuJqHyVtODKjtKo2ciZM5SFab9Uz1rQOXJPA>
    <xmx:5JeharNvImHuH-MkmAoI38G5rjfK0a6khPzyRCjVZ5KfH-Bm4Gux4Q>
    <xmx:5Jehapkg4rUVmUEZ6sWD8a-9u8TAy0ziqM3QW0u3G3sIn8M8msaDBJKb>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:31:16 -0400 (EDT)
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
Subject: [PATCH net-next v4 07/10] net: ethernet: ravb: Add callback for gPTP probe
Date: Wed,  9 Sep 2026 19:30:24 +0200
Message-ID: <20260909173027.2201560-8-niklas.soderlund+renesas@ragnatech.se>
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
index 9e9b1c4fbe95..1092e8ada188 100644
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
@@ -2976,12 +2995,10 @@ static int ravb_probe(struct platform_device *pdev)
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
@@ -3034,10 +3051,6 @@ static int ravb_probe(struct platform_device *pdev)
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

