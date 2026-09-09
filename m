Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B72639524D;
	Wed,  9 Sep 2026 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975071; cv=none; b=b/xQ8hrQGdwx4EWxpJ5m8gdE80VYFdRh+ZkMd0h1o2UVrfyVRJdBQs37uQiiLzjBaFgnjxAHBnySAtRGWuzXe0TtBXMZbMRjDKJ+7+d+6U00xHZQ/mkz+DeP+Nf6rE1yqlep/fQzN5D0hPIm5JpuXAhV7G2Y7VZAAIsa66VaJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975071; c=relaxed/simple;
	bh=FJztA2dI//Yj90jhc8DfU7N4OGjw/VMslofrOnrUU2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfnKzaHnLQxFpBgcUduKirB/rcPx58Wz2yHXD9S/HlGsTPGuNDwPm14spp+wsT4YkdUQbOeKAR7jf+eH9S1rSqNxET+WUB4W6tdyxQvh4mIpXF6OotvvP2YYgMDdlE9D8F77X+qwzb1Y0DA4vUa/6w2dAEbVur6MnNL6cYaJAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=J0oMWM8J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=klEG+QG9; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="J0oMWM8J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="klEG+QG9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B5597A00AD;
	Wed,  9 Sep 2026 13:31:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 09 Sep 2026 13:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788975068;
	 x=1789061468; bh=eHUolKWoGc53KCB8pHoRUBfxoy8S27gEX2vWdwF1i7Q=; b=
	J0oMWM8JKbGRJQ0K8mzMbrZhOnrrVwQFxjXp4sJcltGo4FskGxDEe14t+yDM9kqn
	dfxQu17tgkVkwqdjaBmHJRsnZA8EU5yGKDsB3inWEHdhjPC92m87c5ADUgRYn46q
	ZVUqOw++0Vxl4fkQ84kXoL2JHG2wAGrGhqTa72l2EvpptozFepeyLBTUpK+xPn2h
	lToALxxoY5GJTRoVoesVnLzeTwIjScus00wq+oxezVsBeiEoLxP5v5dXQhN3/4TO
	ywtDNK3mW5h4u1bA0QhQ+VQ2ddu5Q9t1ARMM1PlTtHpEgXmw2HaWgnNjXdRkWOmK
	aNN8Zp7i8zRATg3VFAHecA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788975068; x=
	1789061468; bh=eHUolKWoGc53KCB8pHoRUBfxoy8S27gEX2vWdwF1i7Q=; b=k
	lEG+QG9ZQm3R5ocA/rbANV6dBIz0Lb5lyTeqFZijjcoKroF9bObE9SRfz1F+DrDE
	6ORBwTyi6OxCoG3tkINaHFJ1gSNY2U3loKSL4dNaK6KVs/rJKZDwMX5sSD7ZZifN
	TeTuBe6wfeRsjShkbmiHVdHPV4TKiSGE8C0puY9lE6qTzobZUAHIFzi79nKQLJEi
	S+K4I1NK2ay5GP3fdJuWLwCXGis7jbn6kOav1i7iOXM/aVqGMAtOHTeGCZ18N/G7
	H7H1ljXCAqXcRPUeDf+J/0bC77wNOAbQ+jiqiOu+c5Qni29iuvvYRNB7vWkJuMBd
	sa/AcVeHhx8ttFh1jElqw==
X-ME-Sender: <xms:25ehascRd6bmzaraGvI6sutTsDlmEoNSXzCnsirDshP8HF8mSnwJLA>
    <xme:25ehalK5AuVRwKUnStoLa-B3EBtfypsGpXbMmJG9TNP7DAPdmQ57G065uEiofQYR9
    hf_A66vadNV0QF_cNWVnSiTKtyaNgZz514MBev17VOycaTQ1F3WjXnyJg>
X-ME-Received: <xmr:25ehainmL5oix3JAf375EqsZ7l06HowmuhJyT7YxEwmxjRE_7ld6OeXF4Fty7UlQ3FBjj3Lg6Mfxv82lc8YB3Ouwqq8E5HQ>
X-ME-Proxy-Cause: dmFkZTFpKuOoHA8K6npXM0EyPQ3B6fuJj1V92yxTkRTwTvOrGLmaogCPSGJNdxe3w3n+ts
    3Bnq9S0gANJKKK31pjNWK50OZ9a7PMq2fNO8DZXCQ+/ff2Kmc+UHBXNITlDnGREVxg/f50
    czaZu7ewfHhQ8KEOahciUDlJaktTnHuAyQxRzBwFm86u+eYYubMr2Wb9/todjLgmh5z450
    82zfjBukuoe9N1IpciNBSfLDvZO88JgjH/tASHI61YFG/pSFyNvmg0AvAJCBYM82e580+H
    IntiqdDAd7FDyLCJPHSk55kS+5m53Gxxbft8dJNI3qmcm7XJFRCQyhfwNMEehhg0cLBja5
    WgLaZ1Lqxmvw1wx+QQv41fmkLC2+Vv2Pv4bGKyBP37fq8cqHZO6ONYoP6b/MygCMb8nxYK
    Nc/9Nsa6cRDmBr/mjlq+/hq6C5knNdKQOe+NeElbJCKgxuYd1SUUln37CaqRo57WQOmRx2
    bU6GhfwNg0zWc98wW4qA/5GiIg6CqUQLakHDfxOPOrKtbHVZpaNrj3FmxwAi/YWrBLR3kz
    6CbTRTjRzgxJEPABtplw1BO6IqSHSlAufxWW0toBu6rr+ejC1RzA5LIxNkVNC7d550TpDs
    LvZNbVrCAEb0VcSJqm9ACHgTdztEElnAoTE/W3CQ9G5D1eWxg9TibnHfPXKw
X-ME-Proxy: <xmx:25ehapENsI-QASeSU39M_kP1y5kpx8epPxcplLDAGLWCuCg5i44tZg>
    <xmx:25ehajcBMbSTmdR4qUdvTkkNSAhcZKp5Alj_Ea_74RJ2MmaPth51dQ>
    <xmx:25ehauHFeg2Sqhr7ztoTq4cEBtR_ZjxDnv5VLQwZ4lHuJazb_ugvQQ>
    <xmx:25ehalGvxsd1GPt4iYx8MuPRnD45FzsWQYQeRlPDKSAg4jIr2I-fBA>
    <xmx:3Jehav9Ob__Svc1AAaf2WxG2bY5-Zfu6ucEzzVEHzQDdUFLMNjUETwAj>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:31:07 -0400 (EDT)
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
Subject: [PATCH net-next v4 04/10] net: ethernet: ravb: Remove redundant argument to ravb_ptp_init()
Date: Wed,  9 Sep 2026 19:30:21 +0200
Message-ID: <20260909173027.2201560-5-niklas.soderlund+renesas@ragnatech.se>
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

There is no need to explicitly pass the struct platform_device pointer
to ravb_ptp_init(), it can retrieve it directly from the private data
structure.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 4 ++--
 drivers/net/ethernet/renesas/ravb_ptp.c  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 3ee4c6108189..aa45f5466001 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1163,7 +1163,7 @@ void ravb_modify(struct net_device *ndev, enum ravb_reg reg, u32 clear,
 int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value);
 
 void ravb_ptp_interrupt(struct net_device *ndev);
-void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev);
+void ravb_ptp_init(struct net_device *ndev);
 void ravb_ptp_stop(struct net_device *ndev);
 
 #endif	/* #ifndef __RAVB_H__ */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 2d0022a4f85c..e44d065f77cc 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -713,7 +713,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 
 	/* Initialise PTP Clock driver */
 	if (info->gptp)
-		ravb_ptp_init(ndev, priv->pdev);
+		ravb_ptp_init(ndev);
 
 	return 0;
 }
@@ -1968,7 +1968,7 @@ static int ravb_open(struct net_device *ndev)
 
 	/* Initialise PTP Clock driver */
 	if (info->ccc_gac)
-		ravb_ptp_init(ndev, priv->pdev);
+		ravb_ptp_init(ndev);
 
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 157fb78209c7..f70b616ac847 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -313,7 +313,7 @@ void ravb_ptp_interrupt(struct net_device *ndev)
 	ravb_write(ndev, ~(gis | GIS_RESERVED), GIS);
 }
 
-void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
+void ravb_ptp_init(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	struct ptp_clock *clock;
@@ -338,7 +338,7 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	clock = ptp_clock_register(&priv->ptp.info, &pdev->dev);
+	clock = ptp_clock_register(&priv->ptp.info, &priv->pdev->dev);
 	if (IS_ERR(clock)) {
 		netdev_err(ndev, "failed to register PTP clock: %pe\n", clock);
 		clock = NULL;
-- 
2.55.0

