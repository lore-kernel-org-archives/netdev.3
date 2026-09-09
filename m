Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAA139061C;
	Wed,  9 Sep 2026 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975089; cv=none; b=ZZ5FjX1c+GBLY0k2ffSb3TDnuUepXfq4d+QxulgW2QYeTlSqLLREWwNdzwdzQ2R4d/8YMXlVjvpvleGzj10J+vVZ9QmsA3af/94k8kkt+7xunDK82WzP3tSNfm7nMAdmQWVp4+laQYERk/utgwNrBget/sTbZIsoTuN0MsiKgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975089; c=relaxed/simple;
	bh=4KMQp8rTJQvzBUKJn9sX2qIe5GfiR1pdIJMhnTRBSVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMVOQPchT9/h+rCKZYXP7sF/jToTiDNVlr2ynEI5XSBiWa/J6xB+PSQMqYvUYKmNO4DclMjGoqjPm/Mxi27tD9mEP352MXzHTrmqRok2YptelN8dwZlrx034wWOAruRuMgBYfGpp/RCp3ZkR/Vdx2BvvyglnDkeEBqL7csbKkQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=luBn8IA0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9amcVfz; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="luBn8IA0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9amcVfz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 5F6A41D0010B;
	Wed,  9 Sep 2026 13:31:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 09 Sep 2026 13:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788975086;
	 x=1789061486; bh=ihZEPhfAAgVdPS6YmrQJJR0q1RkJhvdyb72UKC6qyy8=; b=
	luBn8IA0N/t8YRPNtc19aOmjf4LyRFgublyxnjbv0Bdc+zWMFuKB6UV/vQUkEpQe
	+CqlaHUOLB3fMBSW/9FLJaGQKUq9HOIUeihUxluqtzryU5ic6wt9nFDypHJMJht+
	XG6RzqkFvnScPdozn30b7lmzck5ix3rCVOssYPIelM/BfjUwnFOEWI2Rz2a8g5dh
	b13Gnl7RFUu+uFAApTSbpZVXq/UmpvAyQkY2c/thCMTja/vMdWzbe/dEM/J7Gr/t
	+whFwQxlQLQRIMA5l8ED7gL78OXQ61AuJdVg6/HMEMto/71rRnCruGpntIj6NkWA
	1/mwg6kPArsuTClHddR/yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788975086; x=
	1789061486; bh=ihZEPhfAAgVdPS6YmrQJJR0q1RkJhvdyb72UKC6qyy8=; b=T
	9amcVfz2bvnEtAS6ufAd/+v1bqGpWlrUCsHApxldGY3GT/KVvysMhStNUO27XDOj
	DFqsKhRIwAf/phpfQRoREbWgkKWtwy13+zsKoJCTtkZGdY4K7PwBXSeSs6GcIJxT
	8PMg7uhDJOM9m9h51jGcAt7mPRhdqQQ0Vvpv/3WSettp/H9QYjzjZzFvkTknzwVD
	kmPg7Ywn4vWFyE1w8oCRn9XbSKK1pAeHx7RazSIXQcwhS6p8kN8Kv/lO/+6Fqv5S
	C4k65HuBy88uXdJcWJYACDqHY4Eb4yLw/UimkWzzQU4Nsh9dCcN6nlsWluifeaAK
	vzOrDYe1aloQxtY2W8oMw==
X-ME-Sender: <xms:7pehajN5CQf4HFJbqvcNccljYVYfFBWOTQS7BNa82rj1VtRgTngO3A>
    <xme:7pehak7K04tCvCmwOSE6PqqRlxZ9_aVQNPgll6jXEjVAW_h4Yhd9JxUkwZi8c2Xxl
    R_CrSp_YGxjDHVnE8EunPmvSdHBQtwfDXaGr6SH0_biS-691s1SJbkV>
X-ME-Received: <xmr:7pehanWJxqb3rxXsRCMSDLJua0jxHReTQEIpfuUrXE9qCshEUtq6WANC1Op5_EmLPFJL5j1NAU68_i8DyCmVf2Q_288TP0U>
X-ME-Proxy-Cause: dmFkZTFUeD2bObQ9WETToF3IY/QOFektlLy47Td8nXeDSoyFzR75aH2WHfWROwb+gG2z5i
    qhQ5oFT0y4K2rSmBFwxmPvTFvhvpZ6feFNq1lZpwY2t9xN+OnxEIfNpov4ISs/yEYqSikD
    NwhVc6CmZQP5uH9JEc7TOqdE/ACZ93Kd5U8kCOjp+r8Twj7I3pUPq7WNMNT0pfSrTOHbdL
    KxnNZ/xrHtGSfH/K2UjWS2ACkETqC6qR0lP3OfQqZWi9CIel9kXW4BULtzgwBB/UoVUv1m
    QR/NrTw8T3Nudg3xAWbZGN8Iw5WqtsQjaIQHbItaSt72RyM1u2UvvxJzzhGH4yw6tpvcJy
    9lkitttXcOZwuXQpk+be/wlnkR9bnskJ0bFDOOonRVpZM8+Gn50spYKV6QqtgMA+1i7+LY
    diT4LhXZrfQ631OwD6HyRfL7OHyeTWC5duiP7yPc/RbNLL0WeV3gdZVH1fIPevTCWp9Mdy
    jZCJLHWBADbMGcJvVhnUiWH2KZXjlr7sYPVqMzCMamR3H9rzdDg9USarn3gohSZGMM7wnq
    6ZHeujAG3XNZVHVfCiHx9OoFmoqB7wX39Dcg4Nr66JcR+1MlFHNHI92sYzv6SJIf44eMJU
    0HjqpiRQUmGaSr9RtPtkivG40jbaYkIyUwkH94ni/ioAsvKv4+myw22nYA/w
X-ME-Proxy: <xmx:7pehau3cmbS15_PGmeMT3V7dz3-gqzv0rEMkkSGe-YQrvDrF5-vdGw>
    <xmx:7pehamPz2mxKsA1izEaNe1q0aivb8y8QXuRTF3MX5GppIQITJul-CQ>
    <xmx:7pehap1q-sVup_t0NVctraX6_MOIF0LLfdR6ESNhZtQGZcj9C8--_g>
    <xmx:7pehal27cOlALFPgCiHaj0Kn2bO5ymxBsEuQa0DMgx5LRC52-eSU3g>
    <xmx:7pehaluDBcBMkesAsVgwJxJXtsNl36Y6z68OXe9sxLJ4kQJhjJ6w6she>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:31:25 -0400 (EDT)
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
Subject: [PATCH net-next v4 10/10] net: ethernet: ravb: Add gPTP support for Gen4
Date: Wed,  9 Sep 2026 19:30:27 +0200
Message-ID: <20260909173027.2201560-11-niklas.soderlund+renesas@ragnatech.se>
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
* Changes since v2
- Use full 100 character width instead of breaking at 80.
- Remove superfluous return statement.

* Changes since v1
- Use the standard generic ptp-timer property from
  ethernet-controller.yaml instead of a vendor specific one.
- Improve spelling in commit message.
---
 drivers/net/ethernet/renesas/ravb.h      |  3 ++
 drivers/net/ethernet/renesas/ravb_main.c | 54 +++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 27e2b31955ba..5d35b40d7c58 100644
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
index 8617c30dbb14..c8aa40136c3d 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2755,6 +2755,57 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.magic_pkt = 1,
 };
 
+static int ravb_gen4_ptp_probe(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	priv->of_gptp = of_parse_phandle(priv->pdev->dev.of_node, "ptp-timer", 0);
+	if (!priv->of_gptp)
+		return 0;
+
+	if (!of_device_is_available(priv->of_gptp)) {
+		of_node_put(priv->of_gptp);
+		priv->of_gptp = NULL;
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
@@ -2777,7 +2828,7 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.tx_counters = 1,
 	.multi_irqs = 1,
 	.irq_en_dis = 1,
-	.ptp = &ravb_gen3_ptp_info,
+	.ptp = &ravb_gen4_ptp_info,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
@@ -3191,6 +3242,7 @@ static void ravb_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(dev);
 	clk_unprepare(priv->refclk);
+	of_node_put(priv->of_gptp);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
-- 
2.55.0

