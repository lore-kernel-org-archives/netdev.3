Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270064;
	b=y7XpvxPNk7iX6l83acqbUq9fsjep3EYqX7/ludYeaOVm9gRmiWztTvk0wcDexAQrI4QF
	 W/c6ufAtfro+uRU34XcXaIBawBFb0y5qWk7uve9e25UQge3mzTHUrWPbCzzcXEsxuaKsy
	 Umk1ClEBf72fZJGCZZrdAgwde811hsS9AXGH/rXO3p1/87hcDdZjeozwy2Wv7XTMdbTKu
	 0XxzP4/YToij8DJGlOI1GrWvxNM2SWUUvEg9Rtsc536OAzWGir0Ov9Zrzjd03qgDsuHsq
	 JKUFCidmY67QRNALIpqS4kAfAazSOFWS/+He8nilJNPR5r65E1229KNpRtQIFq99Xnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270064;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zuYvl9RTPGfpKJSHddHmzLZeYj09elzQOBQVTivLk3E=;
	b=zcce+Q1X7aASjcNaNg4Mhv0jp/Mi7ANKuTQ+CW1H+rN1W1MSDCaefn6GGm9VQtITVjAR
	 BpRbMa6nJNne6MS+7MXXnae3GEYsWxkgM3MvgrV+UPHVFpbE8qNefzsXwn9BHkQaA1mgJ
	 T9vUt9bFskS+EvG8uQy7FNcId7ZB6JSDbfbpxsvec4uJfmcnKAk2Lab3j6zDvTxNdZpZo
	 omipg1Fl21z4HF90DnmGlx4pVAF2J5NZJodZNqdb7SANedm+YA7fgpKcWYKX7rfs/oqnk
	 1M9QFjPnq/g0DVcdm4jpUyFHECIlTi1RJzqYmMP3POb033+ChV0gtTZ+dqXjSH03JqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cgfg+4WL;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="cNfO/B5r";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053F8606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 053F8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Cgfg+4WL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cNfO/B5r
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vEHw2912475
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zuYvl9RTPGfpKJSHddHmzLZeYj09elzQOBQVTivLk3E=; b=Cgfg+4WL7srhGpoK
	mGLled2a+KpGn0JBvWA4rJyoWfeLWheEO3PxAvIvcP3xD+r6Zgc6DdT7jtW5IOIS
	r9/10S5NpnUvJf/jfwB4iJr1cH+YCOukWt+GOZ3XtIGlesg34Et5byYr/5VHxSvO
	NLdn444O9WJbGnL3xF09/KTppNYl3oYHeCfImS2CmBSv8G0s93CI9BQDer0fAZHD
	2FiwzNkBHqM2Io5KQFcQpDnqbu2IdM84mYU8ZO7KeRCtmwnBIqZig+s+bzC5clHG
	BBgJKy4oJTe9i3VWb3w3BvH6tp/7UGSZjFzC9n85Q3iTxtDbelRmOzNa0ZPWQMH7
	+nJB/Q==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb2bhs4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:23 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-98909a978b9so319849241.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793270062; x=1793874862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuYvl9RTPGfpKJSHddHmzLZeYj09elzQOBQVTivLk3E=;
        b=cNfO/B5r+e/dDHUwKZqAo4ru0qY3/z5KM9LAX6Yadr18TY0JUqdOr7Qhvtf4OAGcbW
         pO+ODUvGqFqh9FGX4aWmOeXMf6IdNVbMv+EqfeW3K93cGXIlSX8oV/qftOuak/o6M8Ao
         PlINMMjQTV1BesE8r2c3QeHcWm+Om9qV4190++Ob/8PARxJBnr4D33m+JrRpz8OCBPiG
         /YebeZx8SfgxPT/zr9tPRm1ri4uCQtgoiidzOVf1etxVMRXib8Ii7sQwa7uddgaLexJ+
         ifb37g8t0rfCTcAeG23Royk0sQdomL/x271m8WZysBlGlqCtZZpJy0m9uWgp140ond/Q
         b7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270062; x=1793874862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zuYvl9RTPGfpKJSHddHmzLZeYj09elzQOBQVTivLk3E=;
        b=wTV2rAtD26ND76e4u0NK6OGO9ANey9KPIQ9JOcEeuUJ6kBNRSXVumYroOnGr/pdkV2
         oMGu6k4Zg9OwztZ63MfXsJ3JFJ+VGSx9Z/Z5zVB3G/hkQa4aEG5DE/rovJJU+OjZttCA
         HXJUe5t2E2OJhzlKn+DBEvJueBp+OdQxs0SeBKONCsGxZV3PZyZKkcdb/E6swyAWJVcR
         E3nKHdTNxp/HfQEkg5s+P4k0WTBAIFuDK15lsb2hlg6dAmXoJ5uZRK0Qf8WL2fMMi/un
         RTlODdW2i11eA7DQHNvYIIiwa1Ft9YSfW2GMoSO849VydDeI9rcdRvcaOkjqPC4SQ6By
         J+fw==
X-Gm-Message-State: AFq9FYIN8hR2dcTwFmo3Z2NBr7FWJfyU55aAmz/vzADoAGN8hQ/ODDeF
	EKe0t5rpp1gQj7Q9yn3Wb/RdlHtT/KelrHBUUGZ+o6DFO7WOLCmoYi6Xg+rDXi0/l5qlSHip/gY
	x7ADz/dH5S0w5VEK1VjNsIZn36nn0D15y6NA883e6kqJSQyGGXF/SNhDOCuM=
X-Gm-Gg: AYBFou2ulUVO1b3WoDHyF6HwbOmfvv46WoJ6vXj8HL3kVkaLADvyDt/mq8t1T2tg7+5
	isHTnE1+XMr23eArgnQGkCMelXdYM3hxR2DgW9ok2ggn94I01uzCtQ39A5mlRg3wm5luj5jrb/u
	fjLgUeGfmq7UcY169xbIX6XPXxR4x/hyH6A5WJ2Q2ey0Y61DcLgKTrwpWIasqcySm4Jtdi4Gyyj
	tqmv8DrfYylc5kkHkl16yM19CbuO6LgCIlciIc9IE9Ggvmpk6hzNEK9Sf7IK0KZ5yZQmt6mstym
	xrTCiaAz8J81IwahPQ7J86iAheikguqmZ2SFjwgjTSLOK4S5etO6Zc3PeQAQf3Faog6S1fM5GT9
	CAS9A06qdlwcLChsC76VLab67qABQJRMF12jP93ANF82PWuJTCUHjQurX3qunpkySGmpDj63eQG
	fW64aW25eH0ZxyWY0ylDvIeg==
X-Received: by 2002:a05:6102:c4b:b0:7b3:8f0a:f76c with SMTP id ada2fe7eead31-7d03a50d0c9mr2037788137.13.1793270062087;
        Thu, 29 Oct 2026 03:34:22 -0700 (PDT)
X-Received: by 2002:a05:6102:c4b:b0:7b3:8f0a:f76c with SMTP id ada2fe7eead31-7d03a50d0c9mr2037769137.13.1793270061508;
        Thu, 29 Oct 2026 03:34:21 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdf9bdsm32219567f8f.55.2026.10.29.03.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:34:17 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:33:56 +0100
Subject: [PATCH net v5 2/3] net: stmmac: pass the desired EST enable state
 to est_configure()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-stmmac-est-fixes-v5-2-85b830a795a9@oss.qualcomm.com>
References: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
In-Reply-To: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae3212f cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=Lt0KCD4LekEKBd4wozwA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: acASsGyGsqdN8c8WXt1OhH3mu_H8dJC6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfXwzp44zyNsQXv
 HoJyqtXF5zRN3vhVd5ly6YYqxVqiy3o/fbGKTM4BUGbwC4A/OpTvX0Ry4vUvFEQvkyeByP1AumE
 shl08VtYDhZNlSvnRoptQwC4h3bum1w=
X-Proofpoint-GUID: acASsGyGsqdN8c8WXt1OhH3mu_H8dJC6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX5jb2+UHeexzo
 qMWNxis6HyQW4VPW34MnH3Kf+y3pcc5a7rJogDQwaUW6T9loFLDAD8oUIbtL05ewfOCHfvj6rL7
 6xhUhIRwzGWf+f5th9EwsFG/UH0ZB7e7WPpq1wu9HpX08QN4cpx8fu7b0N6bELriZwhsbb1jnzx
 SS3CxJXIjIE8e/YyvTKXFzr53XQzfDHmym4uE7YI2ulb9WyN7fIfxFU5PkBlZY+NXFCUSm7SpsL
 raVD37+4XtP4ALYCr/SS7BaI8JLUBDcyVIWPCp7wBhVf56AQ1rzRwKYw3lY++Bhz/HNrs1XvowF
 APHStaSVQuaK6uPrXQNucDMR+0ytMgOeCNrvUk8qezPNvd+IUq+75prKA2m3MdAo7VP3BLltZ/r
 1mZuE4XX5+LjeAL7bUz1p9dahCunQzLdYcQXvEBJAffj2zNdYsOO9zXwWsHzX3yw/SonM779JUf
 cXlkU68K+xhyujGp5gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290040

Pass the desired EST enable state explicitly to est_configure() instead
of having it derive from cfg->enable. This decouples the hardware
programming state from the priv->est->enable flag, which records whether
the taprio offload is attached.

No functional change intended: the callers keep toggling
priv->est->enable around the EST programming, as before.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index b2e557788803..8ae95e91a36a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -620,7 +620,7 @@ struct stmmac_mmc_ops {
 
 struct stmmac_est_ops {
 	int (*configure)(struct stmmac_priv *priv, struct stmmac_est *cfg,
-			 unsigned int ptp_rate);
+			 unsigned int ptp_rate, bool enable);
 	void (*irq_status)(struct stmmac_priv *priv, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt);
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index afc516059b89..f15d4d046aa7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -26,7 +26,7 @@ static int est_write(void __iomem *est_addr, u32 reg, u32 val, bool gcl)
 }
 
 static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
-			 unsigned int ptp_rate)
+			 unsigned int ptp_rate, bool enable)
 {
 	void __iomem *est_addr = priv->estaddr;
 	int i, ret = 0;
@@ -62,7 +62,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 		ctrl |= ((NSEC_PER_SEC / ptp_rate) * EST_GMAC5_PTOV_MUL) <<
 			 EST_GMAC5_PTOV_SHIFT;
 	}
-	if (cfg->enable)
+	if (enable)
 		ctrl |= EST_EEST | EST_SSWL | EST_DFBS;
 	else
 		ctrl &= ~EST_EEST;
@@ -70,7 +70,7 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	writel(ctrl, est_addr + EST_CONTROL);
 
 	/* Configure EST interrupt */
-	if (cfg->enable)
+	if (enable)
 		ctrl = EST_IECGCE | EST_IEHS | EST_IEHF | EST_IEBE | EST_IECC;
 	else
 		ctrl = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index e54a3c887826..9a32af00d7d2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -74,7 +74,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		mutex_lock(&priv->est_lock);
 		priv->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->est,
-				     priv->plat->clk_ptp_rate);
+				     priv->plat->clk_ptp_rate, false);
 		mutex_unlock(&priv->est_lock);
 	}
 
@@ -105,7 +105,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 		priv->est->btr[1] = (u32)time.tv_sec;
 		priv->est->enable = true;
 		ret = stmmac_est_configure(priv, priv, priv->est,
-					   priv->plat->clk_ptp_rate);
+					   priv->plat->clk_ptp_rate, true);
 		mutex_unlock(&priv->est_lock);
 		if (ret)
 			netdev_err(priv->dev, "failed to configure EST\n");
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index aea235a69105..ac926c60f9f9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1090,7 +1090,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
 	ret = stmmac_est_configure(priv, priv, priv->est,
-				   priv->plat->clk_ptp_rate);
+				   priv->plat->clk_ptp_rate, true);
 	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
@@ -1109,7 +1109,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_lock(&priv->est_lock);
 		priv->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->est,
-				     priv->plat->clk_ptp_rate);
+				     priv->plat->clk_ptp_rate, false);
 		/* Reset taprio status */
 		for (i = 0; i < priv->plat->tx_queues_to_use; i++) {
 			priv->xstats.max_sdu_txq_drop[i] = 0;

-- 
2.56.0

