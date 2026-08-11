Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703145C709;
	Tue, 11 Aug 2026 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464324; cv=none; b=r3d0/Vg1sEez+Vi0OHi09VPaAMbRkEsoGCjA2rJJMiWZA1Pz0qWDehy2KzAsQdY00pr3LmEre5yZxNgHIJ19eGL+Aopv8NG6DPHVsiDj6r2i3OMYvQsvScPUDR/OzrgA6OWXeLadoSeeWMiP8jk0fMytwtXjvDZU9MF17OhWvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464324; c=relaxed/simple;
	bh=N3pjQaNbi3Imr6RAfNZCR66d3jzOY0OvR/G3RRvt1FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfq2WZvF7d0ShWg7T2xHWmOo/n45tzqIEWv3iBoWusUtZRy9vXTCdu7GNxW7acQZ46Xw52ifRYDIVQh8ypOEUf4+BYJwVypH+rwe9MObK7Ta/bBswFdSi8GG9uAsLmQi9qN9bgX0GfQH4IhcSltmizRgBAlekFtueQVP18qNCjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=ZcrZgOFW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NIHtpfkG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="ZcrZgOFW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NIHtpfkG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id BA31EEC01EC;
	Tue, 11 Aug 2026 12:05:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 11 Aug 2026 12:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786464321;
	 x=1786550721; bh=fo9SJZtqgbNl3fWJY6C2G3qAmbfvbO2bzET83v6IHUc=; b=
	ZcrZgOFWmoBCEcmDYC9iB2jZt5v1LGkfzlo2zJ+QpTd/0aGwhuEUJwyDw5ltvUPX
	Ya83jtYY2/wVatFTW9yreO38VT+vN0HHxx7E6iJi6iGTac0BhEQ6mRMJNKoC5KIJ
	K9U9/a5I3ztiuhOBQkP9bjSd2AJsaWz1rskjWjq/zeLHc1ir2brCOdEg6ymP5yvw
	0AGVbg1fLcbS5eylsVsXmrV2rwFG+LYJS0kkfyIEb4C2A6Xv0wjKWjjcqYhdxYM6
	k7we3w2ubPf6V8UqGGye5pS8zQe2P2sJs+EUFmhc2F0HPnZnLJd6cVKh6Hr1mHnO
	q8r352+NxLSexa86OFg1dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786464321; x=
	1786550721; bh=fo9SJZtqgbNl3fWJY6C2G3qAmbfvbO2bzET83v6IHUc=; b=N
	IHtpfkGvpjeDHVMfMSMFZxQ0iqQR4wa7mijxdHQiOkz7ws6q39B+7cBOk7vhSKwC
	0eq8UroN94WLDt9aEmy5Kp2RKN0DMWb8g2lA0X/KFwXoJwd6LvLmjhZNx7unroXW
	xRDWRqTmtou7E7F+VJz7ygl060/9QqpV5/mc4TO76PQChvhnw2C/AMxy9oxTJqdP
	t3wE3vtwF5jujA0yF4tDmcd5xZ7nGjEfxZ4zR/L4qvMzTUx8ps+IB+Re/+Vbj12S
	VexOD8AVud81VufrhTcXBD0hsUp69YeDn2ObEUBIWy9vg/aKY+UWkVESymNFuEBw
	Wg9qNjjh0vUgIn4MIZR8A==
X-ME-Sender: <xms:QUh7alLHKNX1R7HtDbB01Zju6vCz4txk_fAQwz8Bi--Zq8iMvMl1uw>
    <xme:QUh7ap4lMd4hdJpbPJ4vFSvbYzuCZ553LjMUzhap3a8EzlBw4TUeFGS0olcQHIpSV
    rPwMmbXRR5g-VVoi9AoOuQEhF61keYgHd2BbkISp5WjkaKaHtpdcNI>
X-ME-Received: <xmr:QUh7asYXAL8ipyemCvt4z4LnxjdtrCC4DMLXmAV2x6eIYJ5ZhsWhhWVXbWRxgSJ7Ylp-xxescGHdTAxUnM-ohcWyIcd9iGI>
X-ME-Proxy-Cause: dmFkZTGFFPL3N5DTcYVuquFe+/dfRYgBGtSfEcwPVr/8UXV69eF5Z2kDQXSyWboTPttrK7
    JAetTs/ONK4xcw0lYxN11ohJL1TNNnROZ/1pj2JjjH/QI+m/z1p0rk3xKDSc0s9IOfLNdY
    S1NvAAbfRKbwU0dWO8ijvRxnkQvQ1n7u9U0ZLQCt76cwnaUt1HRX3DIYdV2DNnAuLBsP2m
    TAKKZ0BTUVIWPzX266+1DxCdNYgRV3tM+ErDktVDP8OB3PijMOevi5gThvW+G+WUPit13u
    rPNXuFXiGTJq4jLH54RzfSy3xTqCLpzhuPnSQ28V/TTUBDbBCV7S0awlmjJebqC1nrqnFZ
    scAVz5MNuZJ1k4Joaml8GPqNOFkswT+tqnedhFwo6OKYPpXNaGpZZVGxKlb/F1lA7m+GBm
    PNNj1UqQkYGka+wE+I4MOJLLQ+3OFMUKhmX/KTb9/AvCHY/QKuM1ghIU5cJFH1EyUscAHZ
    e3/42yqo0KPiKBmx4DGSoo/9fou36EhgNvwkDzJRy6RszcfjVjgd2djUWjCquijsoxL8P3
    NOhGi7vMsKXBKdXV4tgjl5XlRcOwjTIkvRYgKNICj9gizrigPEIEtmrCns7gcoZc7p41sD
    R3xHMpAMeMuLo/8T2eiZdfxOpfNTmmPxwQ4N4DVRWd7iNW9zfWsKQITk9prQ
X-ME-Proxy: <xmx:QUh7aoyaCGnDjokSwtU_1jlBpiwA0ZcLAelfuDkjon0Qcb1vpZQsVQ>
    <xmx:QUh7agNVSvDai6uaiAviRb-wphpmApLcJyKnRippYf_DX4FYvKiimg>
    <xmx:QUh7au6awRTPkHoIJV72_nVSFTwKL2j0MD2FROPcOt51MNrInmEzyA>
    <xmx:QUh7aufUrhQ7GzDhF3TH0e9BsMU2QzWG6sxMus7xyAYpUa-n8s-H7w>
    <xmx:QUh7ajhW9BJubN3UlbBKDAAZ05sET7mjYttxNwT-JvawjXaAP7nPa4Vz>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:05:20 -0400 (EDT)
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
Subject: [PATCH net-next v2 10/10] net: ethernet: ravb: Add gPTP support for Gen4
Date: Tue, 11 Aug 2026 18:02:00 +0200
Message-ID: <20260811160200.2049987-11-niklas.soderlund+renesas@ragnatech.se>
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

While driver advertises gPTP support on Gen4 platforms it is in fact
completely broken. On R-Car Gen4 devices the RAVB module have no
internal gPTP clock as generations before it. Instead it utilizes a
system-wide gPTP clock.

This change utilizes the refactoring of the RAVB gPTP code to add
support for a system-wide clock and stops the Gen4 devices trying to use
the non-existing internal gPTP clock.

To remain backward compatible the ptp-timer property is optional.If not
present, or not enabled, the RAVB driver will no longer advertise gPTP
support to user-space.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
* Changes since v1
- Use the standard generic ptp-timer property from
  ethernet-controller.yaml instead of a vendor specific one.
- Improve spelling in commit message.
---
 drivers/net/ethernet/renesas/ravb.h      |  3 ++
 drivers/net/ethernet/renesas/ravb_main.c | 56 +++++++++++++++++++++++-
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b4df5cab0e5c..4c8dc02022e2 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -249,6 +249,8 @@ enum APSR_BIT {
 	APSR_RDM	= 0x00002000,
 	APSR_TDM	= 0x00004000,
 	APSR_MIISELECT	= 0x01000000,	/* R-Car V4M only */
+	APSR_GPTPTIMER_SOURCE = BIT(25), /* Gen4 */
+	APSR_GPTPCLOCK	= BIT(29),	/* Gen4 */
 };
 
 /* RCR */
@@ -1132,6 +1134,7 @@ struct ravb_private {
 	struct list_head ts_skb_list;
 	u32 ts_skb_tag;
 	struct ravb_ptp ptp;
+	struct device_node *of_gptp;	/* Reference to external gPTP clock, if any. */
 	spinlock_t lock;		/* Register access lock */
 	u32 cur_rx[NUM_RX_QUEUE];	/* Consumer ring indices */
 	u32 dirty_rx[NUM_RX_QUEUE];	/* Producer ring indices */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 12877a8488ed..30170e92d3d7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2752,6 +2752,59 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.magic_pkt = 1,
 };
 
+static int ravb_gen4_ptp_probe(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	priv->of_gptp =
+		of_parse_phandle(priv->pdev->dev.of_node, "ptp-timer", 0);
+	if (!priv->of_gptp)
+		return 0;
+
+	if (!of_device_is_available(priv->of_gptp)) {
+		of_node_put(priv->of_gptp);
+		priv->of_gptp = NULL;
+		return 0;
+	}
+
+	return 0;
+}
+
+static int ravb_gen4_ptp_clock_index(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	/* If no clock, mimic ptp_clock_index_by_of_node() fail and return -1 */
+	if (!priv->of_gptp)
+		return -1;
+
+	return ptp_clock_index_by_of_node(priv->of_gptp);
+}
+
+static int ravb_gen4_ptp_set_config_mode(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	int ret;
+
+	/* Enable gPTP Clock and Select High-speed peripheral bus clock. */
+	ret = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
+	if (ret)
+		return ret;
+
+	/* Set PTP source to GPTP module, only option on Gen4. */
+	if (priv->of_gptp)
+		ravb_modify(ndev, APSR, APSR_GPTPTIMER_SOURCE | APSR_GPTPCLOCK,
+			    APSR_GPTPTIMER_SOURCE | APSR_GPTPCLOCK);
+
+	return 0;
+}
+
+static const struct ravb_gptp_info ravb_gen4_ptp_info = {
+	.probe = ravb_gen4_ptp_probe,
+	.clock_index = ravb_gen4_ptp_clock_index,
+	.set_config_mode = ravb_gen4_ptp_set_config_mode,
+};
+
 static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.receive = ravb_rx_rcar,
 	.set_rate = ravb_set_rate_rcar,
@@ -2774,7 +2827,7 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.tx_counters = 1,
 	.multi_irqs = 1,
 	.irq_en_dis = 1,
-	.ptp = &ravb_gen3_ptp_info,
+	.ptp = &ravb_gen4_ptp_info,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
@@ -3186,6 +3239,7 @@ static void ravb_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(dev);
 	clk_unprepare(priv->refclk);
+	of_node_put(priv->of_gptp);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
-- 
2.55.0

