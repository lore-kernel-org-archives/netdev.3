Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8104EFFD8;
	Mon, 21 Sep 2026 17:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013078; cv=none; b=P43uaVqXq1mnjpSY/SsegC61pSgrHP6tCrjb9wb3FojvnZMGk4VrGvXEkWqxtiiwIc5YGxPAqzp/kRBSjWUMmKyNPJ3qoSM5qkUd2zlUd+eo7+9v4hdEnFS2vyxN+u9QoQkG8W4A1gOXGzXz3shQ05TWrt/eXw3e7JLtz9d2aOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013078; c=relaxed/simple;
	bh=afRHI9FtEbxCLNKeHKo467KfMaY6RFbHTRoY1FFrJ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r44irH5jWcXc6VGwtZyclU/4i7k7qis6xPQ613eaw8hhQ2EUGTrpGF98R5bDwwRObnDlTpk3UA0K77TcmBPdFxw7WIq3mQN5eJvZtXuyh4fxlFziQZHnCI3Vc8SvMyhI7x3WeV+8mekOkuXnv2JFasXCzzwpzzeaUipmxy8zpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=WB9+vVPx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MV104EVo; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="WB9+vVPx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MV104EVo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 684401D000D6;
	Mon, 21 Sep 2026 13:51:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 21 Sep 2026 13:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790013075;
	 x=1790099475; bh=ibc1CId1Nm0nkVBYGtch82/IlWWe7XN6GaGSe3rG3FQ=; b=
	WB9+vVPxMAKRFyiQ5llOMkNzuCVNNhuCC3pHoMG0RAM9PN2BVLxjOy+mvZThT2zs
	Yxoen3f21Q60IDTKHfGPHSnrp1TQ7K9NneAP1XOX8CfzfEu7+VCzUfM5q9jO/FO6
	6YwHj/NRzmXAYxF532THt7pVq0gOJ/O9Ss10+rloHSZ+tO3DQKyaCdSqorY1vS0K
	Bx0thVJV8Yejl8FH8ydrx+9oh3DDsO5p0bI5kCY8+Dutnqd6Y6aGaIKRdlidv3YD
	zll384EkeNzFurbFUxVWDW6GAaAhl7R2N53a7JrO4RwUXY/26jlujFjRcuBnIR+9
	1oTKdj9L1t9fvAeccIb3nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790013075; x=
	1790099475; bh=ibc1CId1Nm0nkVBYGtch82/IlWWe7XN6GaGSe3rG3FQ=; b=M
	V104EVo9EqhPbajuovpm6HGmOEteZgS3pPYaBGblE4qz06gX9+WlIlVaW70SJ+iJ
	X/oC+fdlFZT/HuoNFFMy5KET1AvcIqJodvGnwZc20k7mNGLoT/NxIgQDzmVkpquw
	A8nRdt/akGrVYWg+jhoeg8dm5mMSvDyc6PGsLc8J8WSEdL9KDejltFYtNIu80bin
	eqiVHxVzmhGYTLmdAStHolcxmkjLpgqv64+XFbOqKnJOc0LoRuqSWucmy5VS5t7R
	Iz2kGQWqCa6YPbwx2ypaXOA7MPEmjKVe2PouTV+NlEoqZ/4fyXBpjmkWx/6MWaie
	HHjvqsnRSAoRKDp8x70yQ==
X-ME-Sender: <xms:k26xaqSVnD7HTXwsudlTjTTspjS9SMhFMhqZZP-hlnvrXd-qhNXPbg>
    <xme:k26xahNhPDRzOAqkiLie62UStgdiXUj0ktyqEsi2urCeEo_30mgC5d93BHnGDNW8W
    venZ7XmbxQbhRa5P27LboczAMdS9NbMvI5hVdk34-zPD93n80r2hIk>
X-ME-Received: <xmr:k26xajOfJpnwsM5M6A1LQSRdJC4BGxPt3-qAqQxdmh8KMOTT9eAXLbp5DxPgfdwNH8KixN41qdyhXjSXy4AH7i1uq2uJb2g>
X-ME-Proxy-Cause: dmFkZTGxueDU6ybJrp3DH63sos1//zx+SFUDv+Z0HmZd1kiJ7nzuFU0LghLhMGbNt8CtYt
    wt5HRnq8CzXv75RJbh41RmrgUsjkhBuSa7HsiS+BvOsgN2w1ECbKLiyF06hhLO/qiieiwC
    wkZKkiHKAYNIzrgCTqxZ7xQexBG+kgbIhc6BI6nKd8ZJJotjeCwEepYGWxT35kQ689BIZa
    NOiqgBNzAoMxfOrq/9EkB1onjknI4lCkOrel9/ympJ7mWhVbylSWekfBi0VyqfMViZEcZk
    gme1mTHDxRopPgczIQ18lr31i4s7n6F5NBqxwBc9Ufu8NPc84/QeYVPBiw/u91oS2vtklv
    beAf+X8nWUg0+r2jTwRUSUk2ild7xmQSw0ga2dyPXHbz6AnFSpa+XkCGumAcffURgoJOir
    HorPI2JO7gHoDrd9fdgsQRXpaLIezOAuMa+liDjW/4KnCSsIGH6xFl8yXJy/IR16mtImeL
    cggR5G0f/i355LetlOnO66j1JNMlvQfpsopIVP0jQG5ubaXIeWibWPmT1Rk/E/F6FrPg84
    hPTFQLMvsO1P9MUa3w2WNn1g3eIwpfIf1Fz+TfDEfVFtCeQBpjUJjSLqd7vheEoczhbWqR
    jNuD4wbJYO3hSjQF4R6QHbvKynK38Ny6Ln2GMONiUdDH7zWN9fL9Uq6WYQew
X-ME-Proxy: <xmx:k26xajGP3P-NAH2UqHuw39XNUa1iJNF0IIWNVf3rtNomQa85WHwIaw>
    <xmx:k26xalPVjBV8MoMObqi4JJNW5_ymyMzvbtA7iUEKz4jur7hivEEkkA>
    <xmx:k26xatuub4qhg1VoGueDF5iaBcVyvCCdRzEyiq6Csct44l1xd4vBWQ>
    <xmx:k26xaiWEjUBveqTHAm3_KbYLN1DGrW9WsNXwTtvQ0ylu0-v6YNMdgQ>
    <xmx:k26xao2Mb1P7_7PWh5M5wsIZQ2xX8oW5L2AylWsaSHuOc0ET7tC8XKlC>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:51:14 -0400 (EDT)
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
Subject: [PATCH net-next v5 05/10] net: ethernet: ravb: Propagate error from ptp_clock_register()
Date: Mon, 21 Sep 2026 19:50:32 +0200
Message-ID: <20260921175037.4084310-6-niklas.soderlund+renesas@ragnatech.se>
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

If the PTP clock registration failed the error is silently ignored.
Before reworking all callers of ravb_ptp_init() handle and propagate the
error so it can be used.

Link: https://sashiko.dev/#/patchset/20260610102432.3538432-2-niklas.soderlund+renesas@ragnatech.se?part=1
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
* Changes since v3
- Add check to keep sashiko happy, the remark is fixed already later in
  the series but to keep the bot happy.

* Changes since v2
- Rework to remove the caching of phc_index added by LLM without access
  to hardware.

* Changes since v1
- New in v2.
---
 drivers/net/ethernet/renesas/ravb.h      |  3 +--
 drivers/net/ethernet/renesas/ravb_main.c |  5 ++---
 drivers/net/ethernet/renesas/ravb_ptp.c  | 27 +++++++++++-------------
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index aa45f5466001..0c122a815840 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1028,7 +1028,6 @@ struct ravb_ptp_perout {
 struct ravb_ptp {
 	struct ptp_clock *clock;
 	struct ptp_clock_info info;
-	int phc_index;
 	u32 default_addend;
 	u32 current_addend;
 	int extts[N_EXT_TS];
@@ -1163,7 +1162,7 @@ void ravb_modify(struct net_device *ndev, enum ravb_reg reg, u32 clear,
 int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value);
 
 void ravb_ptp_interrupt(struct net_device *ndev);
-void ravb_ptp_init(struct net_device *ndev);
+int ravb_ptp_init(struct net_device *ndev);
 void ravb_ptp_stop(struct net_device *ndev);
 
 #endif	/* #ifndef __RAVB_H__ */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 1dfe905832a0..db3ef87f0991 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1774,7 +1774,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *hw_info = priv->info;
 
-	if (hw_info->gptp || hw_info->ccc_gac) {
+	if (priv->ptp.clock && (hw_info->gptp || hw_info->ccc_gac)) {
 		info->so_timestamping =
 			SOF_TIMESTAMPING_TX_SOFTWARE |
 			SOF_TIMESTAMPING_TX_HARDWARE |
@@ -1785,7 +1785,7 @@ static int ravb_get_ts_info(struct net_device *ndev,
 			(1 << HWTSTAMP_FILTER_NONE) |
 			(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
 			(1 << HWTSTAMP_FILTER_ALL);
-		info->phc_index = READ_ONCE(priv->ptp.phc_index);
+		info->phc_index = ptp_clock_index(priv->ptp.clock);
 	}
 
 	return 0;
@@ -2937,7 +2937,6 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->rstc = rstc;
 	priv->ndev = ndev;
 	priv->pdev = pdev;
-	priv->ptp.phc_index = -1;
 	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
 	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
 	if (info->nc_queues) {
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 6817e94721b5..407ae97b76bb 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -313,11 +313,11 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 	ravb_write(ndev, ~(gis | GIS_RESERVED), GIS);
 }
 
-void ravb_ptp_init(struct net_device *ndev)
+int ravb_ptp_init(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	struct ptp_clock *clock;
 	unsigned long flags;
+	int ret = 0;
 
 	priv->ptp.info = ravb_ptp_info;
 
@@ -338,15 +338,14 @@ void ravb_ptp_init(struct net_device *ndev)
 	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
-	if (IS_ERR(clock)) {
-		netdev_err(ndev, "failed to register PTP clock: %pe\n", clock);
-		clock = NULL;
+	priv->ptp.clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
+	if (IS_ERR(priv->ptp.clock)) {
+		ret = PTR_ERR(priv->ptp.clock);
+		priv->ptp.clock = NULL;
+		ravb_ptp_stop(ndev);
 	}
 
-	WRITE_ONCE(priv->ptp.clock, clock);
-	if (clock)
-		WRITE_ONCE(priv->ptp.phc_index, ptp_clock_index(clock));
+	return ret;
 }
 
 static void ravb_ptp_disable(struct net_device *ndev)
@@ -369,14 +368,12 @@ static void ravb_ptp_sync_irqs(struct net_device *ndev)
 void ravb_ptp_stop(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	struct ptp_clock *clock;
-
-	WRITE_ONCE(priv->ptp.phc_index, -1);
-	clock = xchg(&priv->ptp.clock, NULL);
 
 	ravb_ptp_disable(ndev);
 	ravb_ptp_sync_irqs(ndev);
 
-	if (clock)
-		ptp_clock_unregister(clock);
+	if (priv->ptp.clock) {
+		ptp_clock_unregister(priv->ptp.clock);
+		priv->ptp.clock = NULL;
+	}
 }
-- 
2.55.0

