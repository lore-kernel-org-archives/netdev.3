Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D774F3EBE;
	Mon, 21 Sep 2026 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013075; cv=none; b=fomNdyrHaKCC5u6iDYaLz0bfJiCbzFTK89jQTLBY+cKDTgiUuGDaizwNMa7B7JmDeq6vXJkdNrPxDX4xSKfqF9K8Le0wdDC0Fd6mJi95+kEKbxNF7qtagnPtu22/jhi0lU1eji9udJ9/UsM4CQ8Vd3TvLs0ZdNz8BFy/FeQrXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013075; c=relaxed/simple;
	bh=n8uMvO6lkLqeZI1gW7SImMJOFb8/LIYVX94RbwXVc8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBY+zzowNOHcPlg744a3Y0xHiRX2z070PA+/2qLMKxZhSG4cReChbqVxYmoHouQ4ssZVlHPRizeCRw6W+BOzvSmJYc/582Gb97dGhkS0QeCyahFaaM30nEFXp5a93kab6OzxSvsDDbxtrhCoVQf2Dg+tDmW/IVrIIsGHdiG/ZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=GF2Tf8Ld; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DmO2APUG; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="GF2Tf8Ld";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DmO2APUG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 862EC7A00C2;
	Mon, 21 Sep 2026 13:51:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 21 Sep 2026 13:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790013072;
	 x=1790099472; bh=zhK2da/WvXsINzlSRetnNOBunpzwaf0zMWO1x1DU4zQ=; b=
	GF2Tf8LdvYOe6XnClhdZBkkdYYvGpz+5pMGDJdmCagKXI04rdIUHrqp/OJDpa+IZ
	6pRu4T0b++TiBrx6wYoSfQLKnSU2kd86bTfSzRE569RN+hjNDOU+alLFCjVq2h9u
	DadlQT9XB7bvUXbnpQDUdo3wBzDsSc2/TEM3QHxhepkH/DVOfFihm7ZI7OJHUi+Q
	0IQZDji6HUD/y0ktjSBlX/vA+R2b1J7F/pMWizyH1OBFAwZcpdZ/GXN9CPTnpJzO
	7H560ta1WoERUWUfH4u38JUiVN44x2iIKSIo52h8mDGEOuv3VOENNRWvQk8cN2sn
	ZSQbp/Fw9f2rcu4c0enkxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790013072; x=
	1790099472; bh=zhK2da/WvXsINzlSRetnNOBunpzwaf0zMWO1x1DU4zQ=; b=D
	mO2APUGJfTdgl9Lo1kfFI5Xme0MaAsHLiPWzCeVuLNDl3syuGwVg0leM4W8mQV1O
	vK0HEpAso8bhYWhxc1pAkVxbTkZ9r+vd/AcK+Aqv3do++LWlQBURnxXUi0p98SVM
	/nQqcyRTQmk0/LBJFGiBBv4K7tg49xiZQBOrNdEmE2rSG3rEpIW9s7oyFh0XzBiM
	1f3c2Op4M2kU3nTP95evv3l5+N/wRA1QixUsUnIQmPlZA7JzhHZ1rARpALtCGFCG
	s/q8S+kt28XVZlSv6mRcQRzB2o4GH9PNzuMHHd549xZus9QsIV1Z8+pr9wjN4Ux+
	rwY/uq6UFbE0ADk8pf50g==
X-ME-Sender: <xms:kG6xavYCFVP2jZN5a1TTaDeJMsvkbQzphtqzIPJWIOtCfrKteFU34Q>
    <xme:kG6xav2YUgGfUuDr2qHzMoMaGoZCwrUyIMGQLakZVPNfEmAzcRt6g11QIGN9R-7fn
    nrJkYfJfBGaD0zSikjleCND13dXBuhhrDXpC2WDlyXgq1Wby4pKFp0>
X-ME-Received: <xmr:kG6xatWpkFlJexzU985ItbPI6HeWv-0zU9tVb8bis8axI0NB6zPsNYNgI3M5lm9cvbmi40nAOaUeyWbd085pFMXRAKMNBDs>
X-ME-Proxy-Cause: dmFkZTERb8iWuOaCoZl7Bdy7ms8LtfxU+xjK78I80yyQZdvSwOOOfv5Eh589Pe9RlM06WU
    dDnU8HOY0XEZCSLotd4wkziCSyOMbfYp7QQMcpxqxHGnE0sN+h/hwRsMQX/TPzjkM+eutR
    EyTNwAM1tWMwrq7QvnP58hqr16hBRsM/xWQjxvzbUj3rLPulCyCubKGS8/OfnPdml28WZP
    11HBM2ETQKxQIL8VV/A/GNA6vlfx97xrmJ0/jihnD6jQBVLDZo9wvlSWgasgNowAQLofbi
    uJp5/Pi8DlT51OEeXr8hn2lIL64WOU6L6jZxXkbUv9MeKffjxF51gA/7UnWz5uX+sq6JG2
    ITdsLqQkFa3h7S3XVJV0s/l0O9h6eSu9xjJlIxNRDIXO5nUD0b2RKhnw2SFFqzoWbu29g2
    Bdwu/9dmua7YTDTI4b0lqvqDOmhRS9v9UVt4aR+IzhoNfumI/VOEnicDL0L4FAn0tMzZu7
    74ztFZnX7wM9f3NmbRoMzaJQkeiIEjaEI8WrVXxBrn1to1E+HpzLFWpDpSAlVSLdLKwVLC
    7/h+zRTW6H65cMhNU+gP6HZ7KX17mbRzR6Yndqai0wsS2OTTYoXI9EBksT0tNKH+e6aZqm
    pccKl+oQA+Y3ewOZeIAlECk6dPWK1IqQIBt8yVfWWnDU/ICzcYSjgPLa0ogA
X-ME-Proxy: <xmx:kG6xaiui6Htu0CD-0_2_cHN0pBA2W4XRYXk_GDK-voZ65hmIaOve1g>
    <xmx:kG6xasWFNQq1LmFXdKXaRHRNRVA3GdWiQo7EsmUflKtXhv13L5KAoQ>
    <xmx:kG6xamU74cl98YYuN7GARkEgxOXXTqOJEOiuY9X9n4-v87A_LIZy9g>
    <xmx:kG6xaudWYoORaL-gVnwgLaee9Luxc-O616jqFs0A5qAq0AG-kh8Izw>
    <xmx:kG6xat-F2acYgnCSH1wwbchE6HaX9jmDNaxK-I32HX7p-0ZFrgSNCPTp>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:51:11 -0400 (EDT)
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
Subject: [PATCH net-next v5 04/10] net: ethernet: ravb: Remove redundant argument to ravb_ptp_init()
Date: Mon, 21 Sep 2026 19:50:31 +0200
Message-ID: <20260921175037.4084310-5-niklas.soderlund+renesas@ragnatech.se>
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
index 42d208e6b8ec..1dfe905832a0 100644
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
index ac91a6813368..6817e94721b5 100644
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

