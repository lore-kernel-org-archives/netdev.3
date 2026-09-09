Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C78397695;
	Wed,  9 Sep 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975074; cv=none; b=rsACcMVMhi0wp7wTek8fiLMoU8e4wzvpaTn0n0lNidgjk7e7QeioxvIddSBMSDsT+HQX0+PPu1Pdn2SvAi98U76wnlw9CiSOJt7JVYVAXgP764AF4kroR6TUpyWpu1L5tyyeUA2Xk1lxTPk4sPHaBcKO3SIKjoWGo3+z7n3ejtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975074; c=relaxed/simple;
	bh=U9tSzxcVWwLrJR9B4hdd9gitDj6fl2dhFCC0n8ujmSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdDH2EXkuOPuMDMztJrWln32VVXVd+u7xMrt7mPIGMYFhUBUt6zeoirDr4xM/W1AfMmJASAosuQA4RSVnflnGx+VoZjpRxBQcPXG+tQ6LeBfjHz4Bnysel9QUBsexlnrWzr0snfyr0sV9o01aHWTzum82w+/lq1/thW+FkY6gdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=LLj89Wus; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=knLjLujX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="LLj89Wus";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="knLjLujX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1FF907A00CD;
	Wed,  9 Sep 2026 13:31:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 13:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788975070;
	 x=1789061470; bh=OmKc6ftdoWzNo+hls5mYDi7giLLHAyvIxMQEScl7AIc=; b=
	LLj89WusFohixK2o8hmec81K0ZI67t22qMnultmSnzFm9nsxeoZgYpcDJH8f70yl
	LkRRU6dRwIDXTGTehEKUorRkYLzqGWziqJ3mL19SXPAU4iah8mdS5ND9n/iPF/Lx
	WAJVpV5m5yckT7jHKeb4KzKHp+5lJrcc9mSWT8Mr+7u7N4Bg8SN6iiNbCLCT3ORp
	TgOAcJ+5RWW7njncfj5mlDfgcQ0yXjexY4SE5yPuSpJtmQx5kC5BkWCwm137GxSM
	TPffNBMLTCSAfpfs+6jUpvQCIymeiKdi/LwL8hrV6Bk9keSssioBUTjwgjE1DR81
	+DgvPAJYJAJevqkrikO+Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788975070; x=
	1789061470; bh=OmKc6ftdoWzNo+hls5mYDi7giLLHAyvIxMQEScl7AIc=; b=k
	nLjLujXce6oGs9Oli1asdKC2GXizKjCNiXBtnlQU/qPW0hTOtFvc8GeG8WGm7v65
	BsUzdJGYN7Wtir5plhytamaHjs3TdLy1DqgL2u2+1ZEB6DM6vq424O9xrV/js6Bv
	fT0udZQh9ON0kvrm2F9Y8Kbtpk4AXpDb1zF74OynSgZOThVe4nNQrPracntv9NpW
	KvvQPBrHzZB2vDM6NkdA3s9QobT2xJmPhZk4Lqx0EkC7w2G2y5XbYbTidxo5FHLq
	xwfb5+DhrW0189iqIov+f08Xhtm5WT0B/YOkbRKdyvzYnOnnb0HFYCa4hD50mNRY
	ssktAWHKMSETjUQT6Im/w==
X-ME-Sender: <xms:3pehaoGpmy6YYVwQTXCcZ8xfmpVXfqzgfE24LPCbm9RyBee2j3M9cQ>
    <xme:3pehaoRvYOiJVABJQiMiPS4hyFGcdW_p3vNUVlGndF7Ux_z64McFpc5x2C7IhZR_m
    bYk6bQ62BBcIwUS5LZ3bDSo8WQF-N31PU5JPvZ2H4UCz6hhH5UcVcSN>
X-ME-Received: <xmr:3pehanNl34zVaoK0ZmQhGjHizc64m2bw-EdzWtxBHL-pZ7q1-H9t2nS8u4VLmGgFENa2GroVhvB4f8oUphZZzKGDhzvsr6U>
X-ME-Proxy-Cause: dmFkZTEq3FTDpjBKCOp3f5adHaq2tctvBTIVYwu5YOD0r0APkXdl3WnbUjSR6/ELXOuGwM
    yVqK963GfWKzhYFHOuyj73vHCWpLZYeL4lXE+xSHQ/6u5zAyWUyUH1lL19FgVYefxLnxkw
    JDufjKfO7IeTL1+lxnZuLtiNItrdGTMd0TVELvwKG1ioGaoJ7wtq6fOo3MGEelnTx+w2/X
    Gw4u8BJYKT6tnahKuZrI1Ih2Wju0n/fYMnzGwrvOYfWhdd3SegXgegvYMb6dCDGLQwpzqa
    JEJ2U0Goa65eRPBK7NB//Om3OLwpDm4jJqOKowyW9j5bpAnW4hQjDKnoS/uEge8yrexmjs
    w+bgvPWwqLNWuMAR7YZ8VYlsSPpGDN40uecvwIXxilS3Zry4Bge2xnUusN0bQ/0iLXzeJ2
    u4z8qR0UCRz9y7HuCsGtjA3HQZHwkg0u0IzGSxbotsmIIth3+cFb/5t87N+TiF3V5n8okA
    Gl+ErLF3XuACCv9bGXfhA1ej/tm/Iwt7p16vntlm4cLs5JHbj9M7cRuLo2PjEBt/osUgmY
    aWAkBzD1PpiF2v6drYsJ0EMkNQ2Ngil0MDhqsYSXl3ClGZxR/+TrH+rgS0dPSv4wb9ziEZ
    ZZ0xuz2uzZzStIq2RMJzVPtLiPlSDtbxnM7HohpGAR777X4XiKt8OelinvJQ
X-ME-Proxy: <xmx:3pehahO8_RTN02YDQTjgI9N6kfa2jfqTwGvrV1kruBoAar1sPnGU9Q>
    <xmx:3pehapEa5dwhEeqzsm7TJ9-D2XGoUiQkBiY3uexcjEEebjsoF5N9rQ>
    <xmx:3pehajNt6JtoP-kMs3KtEePappA2Sd5nQX5uCfuCfV0BUjzzjpshKA>
    <xmx:3pehajuZYkzevYA4ke2iiubQIDZl3YDX6nU5cg9pJaqa-xpdrcdlgA>
    <xmx:3pehau2fK1XF2OjB-Cx7IF73Ny9OYfuPk7UidQowtTvG7w4QUiEGjbUe>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:31:10 -0400 (EDT)
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
Subject: [PATCH net-next v4 05/10] net: ethernet: ravb: Propagate error from ptp_clock_register()
Date: Wed,  9 Sep 2026 19:30:22 +0200
Message-ID: <20260909173027.2201560-6-niklas.soderlund+renesas@ragnatech.se>
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
index e44d065f77cc..5ba322593a01 100644
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
@@ -2934,7 +2934,6 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->rstc = rstc;
 	priv->ndev = ndev;
 	priv->pdev = pdev;
-	priv->ptp.phc_index = -1;
 	priv->num_tx_ring[RAVB_BE] = BE_TX_RING_SIZE;
 	priv->num_rx_ring[RAVB_BE] = BE_RX_RING_SIZE;
 	if (info->nc_queues) {
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index f70b616ac847..37161c0579ce 100644
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

