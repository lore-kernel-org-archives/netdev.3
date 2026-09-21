Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ACD4F4036;
	Mon, 21 Sep 2026 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013093; cv=none; b=RMXFA7bcu1hWcFDnnWUR87lw0dZkcO0X2rtKdPMMFXnzWHeJit9eE/Qm2Rtw6i+Be3sHPa/urxbZH+TEgTA84r6Fm8xOhzMKZuwutSC6v5okqiYIB6Mr7G6gnKEIW2o3xtyZhU3XrFWrYg2VqlyoAwV2ETGAqcM5zuDa7T4hev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013093; c=relaxed/simple;
	bh=0bwI0a+uIW27qUsZVp8iQa/5REZHgX+PZuhBY/cEFgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaiIZmQgzuF1nIUqh7PTorKXRbM2H2cyHtSTiYkTUdpYoYZSlLcwx3T1ZWAC14y9MiDdYOhQqxhndJ2g7cDoTJ1/sN/vI3WPYHBKUzcCOCPfKDOYTRl3EhL0muHUDfRrILjP99VvKVGYF0M+0p1j5+FG9ozruU2Sxv9C9aftuD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=a5Tgt80f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p78n+Xvm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="a5Tgt80f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p78n+Xvm"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 87DE37A00C2;
	Mon, 21 Sep 2026 13:51:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 21 Sep 2026 13:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790013090;
	 x=1790099490; bh=kW1EsC6GNtfwVJkQYsrWS24yxwxN7itDa+qfiyvuU80=; b=
	a5Tgt80f12rpHElTp49KU3VDQsRhziCYdQncna/YxdQnhtrHxtjS3EPoLDJOIl+E
	Llwqm+I4vQdUXwtV0APKXePKHJWuTXiNbhUgjo15ZvWg5/gAuaPDeBc5nZMFMF7o
	tWR0S3r9xqG0Bovf1yfdo+ZKJmGYmks3ExougFUfTxFpjEFrWUFY9VPJig5Xuxj8
	vpGOGtO85ywhbf19iP+aX9HhRZhpHXMvsCLwBBM89d9B4LWFYHzIdk0NX+5iVXWL
	28Tf3pUTcY0tqvpwQrc5JukYPVyCanoRfkL47xokzwxkXrsepPsHU7NImSso/dX1
	BYCopPGn9cOTT7I+g4uWjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790013090; x=
	1790099490; bh=kW1EsC6GNtfwVJkQYsrWS24yxwxN7itDa+qfiyvuU80=; b=p
	78n+XvmEG6NtPEvNWZfnx0OaGvLgbDBXxNxMysRjzWAgjc9qJL8f3oiSRq/7fDqe
	aABwL5uZ/mlnZGNqTeLl1KKvD3B4sP1Zul8LDyY4cmYLvg86zw3uQrDLU7hPoqLq
	EsO1bhCxhQFv2kyQ/CSPcB4odmt6Uz2ZpwDYloACe76HHSpw31CUb+Kjt0SDvsJP
	xh9MZomB0t50z31pKKxyFbsBehWlLkTkWj0zcaweDtM3YhIGPbvSJKxiHBSowm25
	P1Yo1M8iUljRMMfd2JXfZEsMKkylB6pzoUYcSEL3eTcfaNbZoN5rpZEWTOQojPvC
	KyLmdVcUmbn+UXZ/onxyg==
X-ME-Sender: <xms:om6xakQgHn5zfQsot35JcKSFFzv2nJPFkPxP9Wo-EUj62DaqCdL75w>
    <xme:om6xaosyZI8gL9KrsQUUp44aj8i4eGEwgtcvlGUI4IdipvoPSQqivkITUyT5vWYaj
    sq-AVZKzX2xY91WGwEH4cMjDBIcIapSV9_8j8Os8Z1i9pm8fYBoZ8U>
X-ME-Received: <xmr:om6xam65JeeF-zH0YuzYmk9A9_yy7Taeftll-1OcT__dDkaR9yiDGmYxjH0fYNrNuYkdBhNZUKzZL_TYCA3WYf_X1afzKx8>
X-ME-Proxy-Cause: dmFkZTGx2PI0DCnFrKcjMpN3OXygpnBESiscvY5kHlzEb0x0+o4FTTZEJElp0ZbKiSJAfr
    9qumY/qqho/hgXggk3d2wfNQkjmBj+lpobCkXWUqdRsAj8XXkUiqQjcsx1q5D9Wr9zaWI8
    X64FUraMSuaqcvyCi5Zhye9Uarla6wOm8gh9JnIMF7PxnXg/ryhWze3tQalyHbFA0/PBOJ
    jWU1l09x6SyhF42n1BsmxFmPXUpPQUV4hYfNI72sJwVWpwxhsveDqh2IlreCDI9lzkEkLz
    JR8n209yuLfW1Bux0fdKAeNpBPQErw7/J0JR/KE7EW2jk3BZnTl0MVG1vEfIko8Lm/Jpmq
    Ht4rPkeDpEJHHhl7lY3i9wNMhvyporoE/t3IPXgNoNmeCYWbZhBtv6SEWseSJLiLAHV7F9
    3zNuDItAfPZ7JlDUnJcit6WxQrA/yjf/EIkHuVRs2wNwiIJ34bFbfit+bAgs/T7pkhEPsT
    WXm8GXCG+Lb9KGV/8InpO+EgulTsl6uyyzfFa2O3ys+0anmz/N6PdYuvkfKeuvohimCK1l
    5FMjJbLQY58jA67JWVsH/154FEPtLxi9LuhXEBmvfLzowCf8efptklm7r50vY14NZ0rLiB
    j0PMiOtXon1riAaVJOeiNdoiy2uHgiOoGNAOV5uY+RDdvlZGG22aZZZBGocw
X-ME-Proxy: <xmx:om6xavL_xsllZ9HmCnL30sas8kdvlDX7Oe6VolorVn2wzPU5yjbmew>
    <xmx:om6xaoRaJZ2_t5pNGlnzSJ4f5B71r-oYawAzJBI6OCuPX1McNOWfWg>
    <xmx:om6xaqr5u95IvXm_8-B4VJ4N5TMQyszebwl1Dmo8qVpKziGoGiXfxA>
    <xmx:om6xauZRXID_1IXy64FAZq57Vcysx8SNWwaxsbGrJjK5NY3A0yrnPg>
    <xmx:om6xaiCSRSdx1Nodk-TkBt9qcRvJ0uN6sD6edo_6tJg2J3zgpQIWHOiC>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:51:29 -0400 (EDT)
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
Subject: [PATCH net-next v5 10/10] net: ethernet: ravb: Add gPTP support for Gen4
Date: Mon, 21 Sep 2026 19:50:37 +0200
Message-ID: <20260921175037.4084310-11-niklas.soderlund+renesas@ragnatech.se>
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
index 2dff47c2a125..5a07cc0180d8 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2758,6 +2758,57 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
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
@@ -2780,7 +2831,7 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.tx_counters = 1,
 	.multi_irqs = 1,
 	.irq_en_dis = 1,
-	.ptp = &ravb_gen3_ptp_info,
+	.ptp = &ravb_gen4_ptp_info,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
@@ -3194,6 +3245,7 @@ static void ravb_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(dev);
 	clk_unprepare(priv->refclk);
+	of_node_put(priv->of_gptp);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
-- 
2.55.0

