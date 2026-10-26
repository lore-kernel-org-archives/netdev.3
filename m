Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033790;
	b=PJP9B6laLivaHSiQ9+EIZH2tqfDsH065ZK6/QPvdlS3TzHX206vgcJjSVgu6Cnk256DC
	 XgE33EwzXLvKwglM8u1t8+oBMq3tlLSIvWsUsR0JrSEyGo4/SEac0fhqs3jT1MUr4YjJZ
	 ooNwBRohwvBO1wPgWavyOYS6TWB4zDP19EfZbPQTAb+L6KqvWRjomdqHqsWJiTG8jFsFc
	 /QhIEElDPHjSjQe13XhEqRnCwAgXgCEckwWGvohV6Xtka3KB8MeXZliCvvXgYadmeGk8P
	 1SImvvA7nlaqE0Hkvq5FDw/hi90lSjKLM19NDO534YTOQBq4lS+G20J9W6fdFK6KkMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033790;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+gjHR2ZKnCUDk1zYcm/TGYuZatJkEiYXE35oP4Du0ng=;
	b=4ruybuAPLo+1lIpTA/J9mXLON5z4kHYivxPHLUeG8OMm8zng3jG9fmNJvsCUwRS608R9
	 IPXAQJtGnpv+a5GgU8Ut00mJpJExkEv3Q4t1KKZEykxoaRHOXBjLggTSdafGek1WJofrN
	 9Fo1MsIye2zuCBQ/fSn+b+Vw0sa+jCJq2DjFhA+13F9TmYu6/Lf6/me1OO+Krulkz4HZd
	 RJTEHhGGf5XBelGLMx0d4obDufmR8CIHOEajpsSmf0WAey9epT1sI7QpQA7ZmTWP3E0Hp
	 XFEPVWyySAeom2gNp+G0JoBEPfKiejY5jIv6DfkLRfcJnuth0Rj6OmWiyN8g6N1g+pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l0qPbg8p;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D+nhWnAg;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8410606A31F
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8410606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l0qPbg8p;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D+nhWnAg
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QEvhLs4168059
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+gjHR2ZKnCUDk1zYcm/TGYuZatJkEiYXE35oP4Du0ng=; b=l0qPbg8prFitPurr
	FQkVUv5jWEE/eZKDZkwBLh/YeFyHbOPlxI1y7/MdBOKvfF3GfOBgQs2YKPT44FfG
	JWiJ07UsUyKhOTz5mEmoEXQiDXmp6T6v1/iRV+r0eChR8iqzgmtPPN6toK+z9UeS
	PyXuEZ1Ws6o0Hw/lF47ED1xMCCUYpf1uW62S7Us5I3sUsopObWxbpZ4+rUuD9V3G
	n1wT/yTQ8XSV/kfrk940wSVXezQPJVosj4npNQ+HZPf7wSVG1nKXWyB/YK5vsM4t
	H8E7LghK4dP+7/K+aLQJKXEglzIlgwcdNY4sRKGrrxgv/HfYD1jwt/B/+luP7AMJ
	aTXF0g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf1k68-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 16:56:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f5844cb60so20704785a.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793033782; x=1793638582; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+gjHR2ZKnCUDk1zYcm/TGYuZatJkEiYXE35oP4Du0ng=;
        b=D+nhWnAgb7w9dS93n/ixTUQm1qNmJY/kagcfXw0E+MAkbjHGRxlDl8nCtipc7i+dzD
         Ilb7MhHjirvXxTP6u4vaQ8xLMThz6dLmtODvC9X2mHNvGq/9L+pbYHTlhvP1PE+lAS/e
         0LVu37S2AIgrt4DDmaujvwiOOWVQRW4PSPF16FWnR7I+MwgAZukZNw1cgS8lYrsR32iQ
         gZLJp5T1tJX6sgG//3NI49sEJi+osb0i5r5/RfPqVmStSVSB1NxTcLoBBEklAOARSYyJ
         jxZodQxpO6vya1WQkH9eiBf43yUdT8DyKdNmh6VwE7Sa+DsMP29M5qEcmDhO7hpDKVhW
         krAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033782; x=1793638582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+gjHR2ZKnCUDk1zYcm/TGYuZatJkEiYXE35oP4Du0ng=;
        b=dKrs8COj8rVxokCI3HhoXL822OcLvN1jV34TvE1PixQPdaPNcHHkLmAe2oG2lczds9
         Zc1yhhW9RP5fcMESiVQfY1FCKnWJKe2rKYAGw/gXrkyAhZmRzPG2z5qD9e3PH0xwF0VN
         0YebFXPPhN5Z138F8gCflURNMvOx6we0P8qTK5wvHx2W2oDXAYm0k6jEwxqzpFylOj0Z
         t5MzMq8dZbpYfwhY13wy6uAtGJm6kDCm3/46cCg4jOM0qX3otvcdJLmkaAVLAk8Ih5JH
         A9vxIKq+PiV4Vzpk4bprl0pbwJ8k0LvF0E6OnMukKZyXdEqtJ78Coq5U0mX7nlaz7a93
         S1nQ==
X-Gm-Message-State: AFq9FYIcBxL29j5SGLS0pXKf2gMK0djWo+taNTmJG9HuG5yuOIET2iU8
	HJE7s6WPfaHfbh/Ie09/TkF5rY+DeP7ubOInizVKx3QQsNnCm3BIm/cBB6Ir6qLqBAjkXxUZ5Zl
	WhsCbmhNX0fNCC5cGRabc8YYiOUBJtF/tyqbGsKGQxJu6LVi6sh6bhZvaLHE=
X-Gm-Gg: AYBFou2oJXpXQw17usgmrTxZLMXocw/jwbEuUePTiBh1iJtbuX0XJexK+Y5spA03rDc
	beVoG/derRwnVW+7l1O4ykovVc1+9+16Pl/yr5YBrqyDOJVcxL9qzRNmHm8EqjC6C2EDaoT32qn
	keaYiE2qSF7QeqarOGMXXXXyULFVbhCz31BhzR8Ls+NQYHfafdkZ/jX6jUOetsLqLuTzxOdJVWJ
	ROxlAnXCmz8QwRbeBqyeatK3DRuVR/g0YVEDVAuLhZDUuwlQibLvrC3VeYe0yWybfcZEaQMJDRB
	7EM2+bdSAf1+mel8ZvFgfr6AoF5/IqkHMJ4Ua09QaAvQxNFqz9geld3MxWeJ0mQ11gvH7rduicR
	2pL2xXaXLwK8=
X-Received: by 2002:a05:620a:2626:b0:93f:22af:ccdc with SMTP id af79cd13be357-943f4a05f51mr47917085a.4.1793033782274;
        Mon, 26 Oct 2026 09:56:22 -0700 (PDT)
X-Received: by 2002:a05:620a:2626:b0:93f:22af:ccdc with SMTP id af79cd13be357-943f4a05f51mr47912985a.4.1793033781681;
        Mon, 26 Oct 2026 09:56:21 -0700 (PDT)
Received: from localhost ([93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfd8dsm16504747f8f.56.2026.10.26.09.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:56:20 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 26 Oct 2026 17:55:57 +0100
Subject: [PATCH net v4 2/3] net: stmmac: pass the desired EST enable state
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
Message-Id: <20261026-stmmac-est-fixes-v4-2-999dac4de44f@oss.qualcomm.com>
References: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
In-Reply-To: <20261026-stmmac-est-fixes-v4-0-999dac4de44f@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA2NyBTYWx0ZWRfX7FlIs80lv5HY
 nRjDrviNW7VzU71OqAqbzkagtfFs5bCES0RZ5D7d7pwpDJDJAQz+m2GSwU5s1CVoRz6p4En7a2c
 QlhpG0vHNa3iw39/B66M2qaugxyi4xU=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adf8637 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Lt0KCD4LekEKBd4wozwA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: JSUuAnpSWJPmVNGvJ3x6GHkL_M4Y02Uk
X-Proofpoint-ORIG-GUID: JSUuAnpSWJPmVNGvJ3x6GHkL_M4Y02Uk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA2NyBTYWx0ZWRfX9LKLylPjNs+V
 k8Q3SABgnsGrPimCkFVSHf8MJRcCTZvV/C8YR0EH2ZiqZdvHW0AhCqTALeXD3ocg0zacal254XA
 trGp5pDGazdYF4wjw1UeqSC/fHw8Pc4v/bE0X+PKAxBA0CnKzOVQ2qsbQiND3B8YHFxS7AiwkJ0
 hbS0iQbfTBmTttuBGUmF3DLUltS737lEF8yTMFZDCbtGnLEz/1ZpmwZ/QznFNnuQfH34k+ssi8z
 0ZosYT+WDChCvjBfik9Gr/l1RVr46njvmtdSHzeCeGWkBvvCm5dRV/wQPbGKPX/msO92GYiWoDc
 ycTVdJ5Lr+hOd9/KeJeDICaIGcQQjFBLs1JkHoVmN6AqDECJiKAOGxImjyBcNxXYKkP3nIeVmmv
 85P31ua7Xekdt/JAZdTklC8x/lXXDPEm5G0JmYM2+A9V8wYxZOXtMIqh7zO4S0XgBj2oLUyzLeu
 l4g+JCagGZO/HL9zKqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260067

Pass the desired EST enable state explicitly to est_configure() instead
of having it derive from cfg->enable. This decouples the hardware
programming state from the priv->est->enable flag, which records whether
the taprio offload is attached.

No functional change intended: the callers keep toggling
priv->est->enable around the EST programming, as before.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.h       | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 50b590d67d87..b28509555d81 100644
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

