Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B44582C3;
	Tue, 11 Aug 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464319; cv=none; b=OezxPsvgI0o/kYx2bd4P72ffYqKAYBu/ErtvMBXnjguzvWWVQWUQxW0QEcGla5/WgI0wCIk9sUmfnSFB5JV4QctV3JPZ9s58K/HBkyqxvFMdyJi30wXkGJYKxpT3xeN+vsfGqJJ1sjMu3vpDB2WbMkcFX2YUbtxVNnCS/J5njGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464319; c=relaxed/simple;
	bh=X4V6pqv1L7DLePElG41uMwQFINIrQdUm019d/aBUnb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mJG88lZex0IQKON801/R37mJ1WmVJxvBnbfna1JTxTH3LmdX5Rq79HxkA3FnndnIKSYttGL+KM2h5KklOH8UmTlWBrfyzqA0LeHLiq/l6gpgS1jyUOk29bzVDsDeJ1CBm3iZcwiGqVllFSL9aSz1tVdUUGO/gss+25Gr0UoAq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=IySDLC4T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R972L3La; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="IySDLC4T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R972L3La"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C1D87EC0236;
	Tue, 11 Aug 2026 12:05:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 12:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786464316;
	 x=1786550716; bh=h2CWSjYKebv+lHKTn3SR95shVlMTTwIMi0idBkVPXMw=; b=
	IySDLC4T3cfo0YSqG8b14oY9dHKVJLUcWN1iwA5dfbSDM1FFvOtehRvmaC802ni8
	yo3jeyK9zlS+DOFACA8+AsxyspoxesPRVLtWpi3gtT7C9/V9BgXICPmpJZwyxtrY
	owLRWWmZNEQwMhKQjTEziaSK7aSwwgPd/3pQEVXKZls6iYwf1nSy7mjShkucWXi4
	NEiXn1ozvyK6kVmIXBz08ePc5albLTCgIk84PvqsE9S0ojWDhPia5bt2Zhj9v8D8
	DdkmIBVwcSOGJODKJ2NLOhAarfXMpNvBjnJP9Avh098ryVKEY1pwBtR7JCFVwkQC
	9FBJ0jBbVGiSRX31X6cxlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786464316; x=
	1786550716; bh=h2CWSjYKebv+lHKTn3SR95shVlMTTwIMi0idBkVPXMw=; b=R
	972L3LamRSaJPBeI4Ot81cCyymjh6TenT33mtD4AKgHrF/XWM6Pqn83WgUxeUq9i
	vjyL1gadHndH37rnCJFCiHYCQUKBZ4Zj6lI0oocU2X39br7A540clT7Qstt2o2Cm
	W3CeEhfUAl0hcJ4++IXyX6l5wleUW0NzxmhCF2USYeQAj88Q1dDpgw4E6AUIjqof
	pzwlnb6kcJuu1esCoDpXqrAWEAub9+HY4XTWcwh/Bmpr+iFxlNSzpW/fwIj2tHHV
	HsxQJgTKmoBf3Mi1RR9Aun9ML4JMEipiOVBANAv5wwLpeNTNAGp4C/qWEL+2vMHB
	QIRLWMINdWTzsDdUsOO8A==
X-ME-Sender: <xms:PEh7as4sXR018Ds7MN5gG_Dju7IXBwssBHqFquX7TVNo5HwMBPLPNQ>
    <xme:PEh7amrD_cWpZABZXdgH41qEv-ca95qtkg-DU1ITqEmML-W7ZZUOeEHKSmQ7mYzE3
    fauxRK48ymwbbebE7jVm9jI9w3S_JEqjvnw0tf-4sAJwkB5GDgvIpc>
X-ME-Received: <xmr:PEh7aqKP9KYc-RzRapBSR9sw0oqqXG40Wq34PJk80EpgttMDC0_NPXtBCVsWE_WWS36qe26vOBooFiyI0pxfrenQNTVSDsE>
X-ME-Proxy-Cause: dmFkZTFfnGnY8BNwOA38kHRMG8VuzfLdIbhby+5Bx8gDcHOGPnT40FGPYNyCNudnsAONXB
    H8pWSZ6bBmeWpQQOmfFei6KngSe9Yx6Qk+pC/ACAEvRxouivkd8qsROwXyV48xlBXkHsz7
    20IuB7g5LxPj/iq0mkR1IN+7EsBTQ0GQpyjdrRhvx2UmJKFhd1XKK7nczK+adEITj8T6G0
    mZRSq0ML+IsbReLxuQYotPJe1O47knG89tJ7TKattIgJWgUwd5mLou6v7sOPkGSi3fg7xP
    k9+//LPJcoXki8o+enm+zveAYcBX2aiqtsV6+faiVGfeQW1q2jznsB6+ZfFRxVP6n0hhHu
    jW2CSCk3AAKtpdriopMC3QoXkoXN6PQPWl2EAXZVNhzb3/jf56VbqEsk65M0Zo/k2LxzW8
    LMaOV7niNfhU4dFNe5n/2+DCu9/F2799x664uYHJFsHlc02yzDM26bV4/ZKzs3jAFwEFiy
    16TjVZX7VFO4/Z7UfYSDpyvi8PQBXhUVSIKd0+PSX0232jsvbkpKSgxGxzwHHBSN/MaZaP
    gFLBUnPl+RrSSoywNIaAQqAwW5j0GbzlJFLc/uY3OUg9NLtu1KCRAEvu6hPxDIaSLdjOsy
    5ESaIEvoFVcOnmpydIb+QjRDqIixBsymuVqfc2hR5Fs/+BMz+g0HFr0FKgmg
X-ME-Proxy: <xmx:PEh7ajhLnxZSPmHl-womd29jdmqx2Y7CQ2XyarN0ZkZUNk2d5fJgDg>
    <xmx:PEh7aj8WvkKvpfdy66MAol44THl5M7vFOdENtjp4IdRlWrCoxlqb8w>
    <xmx:PEh7anrJ9lqcrjaD-isfxSHGRnRo20QZ8lXALn2KuIEU3x3mEUVK-Q>
    <xmx:PEh7aoNuNRJGTTqUmuJssMwWMDAoyjMMu4e-a4vtbzOBkAgZJcsP3w>
    <xmx:PEh7ahSTFzsWTVDaFiJLSVyMA6yGf-O_NDfZjOW11KEF04ADkxJ8Xhyw>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:05:16 -0400 (EDT)
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
Subject: [PATCH net-next v2 08/10] net: ethernet: ravb: Add callback for gPTP clock index
Date: Tue, 11 Aug 2026 18:01:58 +0200
Message-ID: <20260811160200.2049987-9-niklas.soderlund+renesas@ragnatech.se>
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

Prepare for adding Gen4 support which have an optional external gPTP
clock. Add a callback to get the clock index and use it to determine if
the device shall report gPTP support.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 ++
 drivers/net/ethernet/renesas/ravb_main.c | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 60f32bfa48c6..b4df5cab0e5c 100644
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
index 743f53f61bb8..12877a8488ed 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1773,8 +1773,13 @@ static int ravb_get_ts_info(struct net_device *ndev,
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *hw_info = priv->info;
+	int index = -1;
 
-	if (hw_info->ptp) {
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
@@ -2653,6 +2658,13 @@ static int ravb_gen2_ptp_probe(struct net_device *ndev)
 	return ravb_compute_gti(ndev, priv->clk);
 }
 
+static int ravb_gen2_ptp_clock_index(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	return ptp_clock_index(priv->ptp.clock);
+}
+
 static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 {
 	int ret;
@@ -2669,6 +2681,7 @@ static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_gen2_ptp_info = {
 	.probe = ravb_gen2_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen2_ptp_set_config_mode,
 	.dmac_start = ravb_ptp_init,
 	.dmac_stop = ravb_ptp_stop,
@@ -2706,6 +2719,7 @@ static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_gen3_ptp_info = {
 	.probe = ravb_gen2_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen3_ptp_set_config_mode,
 	.ndev_open = ravb_ptp_init,
 	.ndev_close = ravb_ptp_stop,
@@ -2778,6 +2792,7 @@ static int ravb_rzv2m_ptp_probe(struct net_device *ndev)
 
 static const struct ravb_gptp_info ravb_rzv2m_ptp_info = {
 	.probe = ravb_rzv2m_ptp_probe,
+	.clock_index = ravb_gen2_ptp_clock_index,
 	.set_config_mode = ravb_gen2_ptp_set_config_mode,
 	.dmac_start = ravb_ptp_init,
 	.dmac_stop = ravb_ptp_stop,
-- 
2.55.0

