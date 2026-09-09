Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE44389452;
	Wed,  9 Sep 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975065; cv=none; b=LHgT4gpugYF+Lk3F6t3krKc1gGTcH3eMkWl5DKYsY3gePQ/Ql37EWwK/DhrPW7Jy1fGBNUbR4dROMLz5sfVATFWWRlIHEL7U5BKAzlmfhAHhn8+4no4NWCnQuYc4rwpUSoMo9mPoo4vy2IA8OCxLJECwO44mBc2NDv4J4/zSIAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975065; c=relaxed/simple;
	bh=hmpis5gJE2ngNtWrXSfh/ef+Yj7WTtZXvIsOf15v1rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmehKOrC4qbfiFNu7Bk/Vh8xYbJcrfGhPRXXqMkKZE8R0kg1RVsPJ/FXoqUKExynQWX1SuGk7JYTNw9f+C/VMD1XKT0jcYWOOqOZ6MnjxxpfbEmruFvLGPK100HVEY/zlI8Hwhr7n+zqPcVns5AISqXYJXIN6p/bfHIwKkpygf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=Q0disXzW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TkRThlIf; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="Q0disXzW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TkRThlIf"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 359D87A00D2;
	Wed,  9 Sep 2026 13:31:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 09 Sep 2026 13:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788975062;
	 x=1789061462; bh=L+9oK0TXXxk/EiHiWORG0xWm1SXmTAQfkqGE6zxyfjg=; b=
	Q0disXzW/jt1mdlmdwzTH8b1dBGoNZRbg0Q026rJTCjAg0+omEszQvpED4yLO4H6
	hDtJo5ImwfIUD/w9x2gmRSPV5qjLKTwnmDpO6XWpXZPmDcLsMdIbClER58Py89dM
	IgUMA4+90G1+T+PzmGV9XfJ8i3WqsAM/hbn3N/kRuLLO2VFkfiToPKx8WOUegwcV
	oNAYBxPsxPvsZlZINE1AsnMaE67995EUdeoC5XD/rbGhuqHvphZWQtrfAPqD0JWN
	rj5EESmbNyDFPALJg/7JT0U1WUSMCS7yfdYigsEd41gjW49k79H0KzEAcCukhs2A
	p59d+RxbA7jJ2Nfmfub34A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788975062; x=
	1789061462; bh=L+9oK0TXXxk/EiHiWORG0xWm1SXmTAQfkqGE6zxyfjg=; b=T
	kRThlIfsWCHV+PavOxIo4B8NfM7IxUXoiOQDOR/xx3qP66n4l6pIXHbDbcGfBbCN
	lSAgfIr7v2itKCRDJ+gCn/vunubpOKWX3k1KOFc5fjuH9P/5amRRoLBNIaa4kVEF
	jM9ViLw0c80TFosyX8gxqhg5J03SMjhmKEWLR0bElYF1bsa76Dmk/E4F1G2cKULl
	NvR6quN+Cv0p+9lwetxv7K0eAhGTFR35/zgFEzkwdf1hUKof1vE+Z8OreIsIe7rz
	07rgPHAtDcVuVDeZnsjAJZb41AhtpJN4BHmwV6xw03m1wzI6Hsgq20L8dF1ca4e4
	IdMHTA2US3etoJHR3/rqA==
X-ME-Sender: <xms:1ZeharKNLjobGhELiPJgr50awjS-WbC-Tc7GnMfxak-E_zWGmtf8Fg>
    <xme:1ZehamGeG6rHhLY-l-NaFA9KXMfTGYTNyndpvBN0WBfhF9_4tGpILhG40GFD-GGse
    _K7t17JS3V0mhKK8IM6MnVwLZtVw_talJMrYGtLUEdFrI8Ku157Eeg>
X-ME-Received: <xmr:1ZehaoznaA-QcTHVZSysb3MXQurW0a5soXZzWX3abtSUiuDp_C36X4saHgvud8LkSnT6VRo94UtZ3QyOXlmS3SAEA1jkjRU>
X-ME-Proxy-Cause: dmFkZTFpKuOoHA8K6npXM0EyPQ3B6fuJj1V92yxTkRTwTvOrGLmaogCPSGJNdxe3w3n+ts
    3Bnq9S0gANJKKK31pjNWK50OZ9a7PMq2fNO8DZXCQ+/ff2Kmc+UHBXNITlDnGREVxg/f50
    czaZu7ewfHhQ8KEOahciUDlJaktTnHuAyQxRzBwFm86u+eYYubMr2Wb9/todjLgmh5z450
    82zfjBukuoe9N1IpciNBSfLDvZO88JgjH/tASHI61YFG/pSFyNvmg0AvAJCBYM82e580+H
    IntiqdDAd7FDyLCJPHSk55kS+5m53Gxxbft8dJNI3qmcm7XJFRCQyhfwNMEehhg0cLBjAQ
    GQP0Aj9YMiTcjbYXAWjQrxALfSo2EwiTRSfOeMEnoCrdKuBsKlErL3n0aPeT8hZT3lJk0n
    Rvl1AKVaNMZ/zReDwUXlJzOnPQzaF3wt4VLWeeYHuB0eFMxmkgH81WWGreieo/W00u1Arr
    tu3+KkIsDC/+iIrL/HRWdOy/N0T/1x9a9TqZ5/l5yKT91hVTrTrq+6MBHMMyHfszgeie6e
    /Sr6rvY/6XDelquMGnAROqaSy9bJhbbR0dTf+IT9zjYq/P7idLJTL+4/ZGKzLmkDfzoVc7
    ZenSvPvC3N6yaftlDlgZC2njMZx1h6fx3Gp+b/B1oIiFsGwSyQNtgwoVxGWg
X-ME-Proxy: <xmx:1ZehariWeNFIIYxep4asn8CJlQKxAwyBETeYomARlkmw92KqektcsQ>
    <xmx:1ZehatJwwCNZbrRcI2Iw-Dumwnf3aM9mvmBWW_QLdpUEe-repxBf9A>
    <xmx:1ZehauCMtrhOhCdpG6JNs6uvEZA-p1J6LTlzYVzcxs0yh7_AsVmieg>
    <xmx:1ZehauSDF_qPjbCAxd2REDb9o7Lmv4fAP7YXjwlide1oi5LEqqAyiQ>
    <xmx:1pehajo5CPqNbXjYzcvDfU-STYO8xVWXCryXQEPTAdZ8A85FrrRhO6Cr>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:31:00 -0400 (EDT)
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
Subject: [PATCH net-next v4 02/10] net: ethernet: ravb: Move programming of gPTP timer interval
Date: Wed,  9 Sep 2026 19:30:19 +0200
Message-ID: <20260909173027.2201560-3-niklas.soderlund+renesas@ragnatech.se>
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

Commit f384ab481cab ("net: ravb: Split GTI computation and set
operations") broke apart the operations of computing the timer interval
and programming of it. However it kept the programming of the interval
in the RAVB main logic.

Having split the two apart this can be improved further by moving the
programming to the gPTP initialization function, as the first action of
the gPTP init function is to wait for the timer interval programming to
be acknowledge by the hardware.

As an added bonus the interaction with the gPTP registers for the
programming can then also be done while holding the gPTP registers lock.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 16 ----------------
 drivers/net/ethernet/renesas/ravb_ptp.c  | 11 ++++++++++-
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 36173a09e2fd..a89f6fe7866f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1846,20 +1846,6 @@ static int ravb_set_config_mode(struct net_device *ndev)
 	return error;
 }
 
-static void ravb_set_gti(struct net_device *ndev)
-{
-	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
-
-	if (!(info->gptp || info->ccc_gac))
-		return;
-
-	ravb_write(ndev, priv->gti_tiv, GTI);
-
-	/* Request GTI loading */
-	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
-}
-
 static int ravb_compute_gti(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -1974,8 +1960,6 @@ static int ravb_open(struct net_device *ndev)
 
 	ravb_emac_init(ndev);
 
-	ravb_set_gti(ndev);
-
 	/* Initialise PTP Clock driver */
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_init(ndev, priv->pdev);
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 43218bc15b15..157fb78209c7 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -321,11 +321,20 @@ void ravb_ptp_init(struct net_device *ndev, struct platform_device *pdev)
 
 	priv->ptp.info = ravb_ptp_info;
 
-	priv->ptp.default_addend = ravb_read(ndev, GTI);
+	priv->ptp.default_addend = priv->gti_tiv;
 	priv->ptp.current_addend = priv->ptp.default_addend;
 
 	spin_lock_irqsave(&priv->lock, flags);
+
+	/* Set gPTP Timer Increment Value. */
+	ravb_write(ndev, priv->ptp.default_addend, GTI);
+
+	/* Request GTI loading. */
+	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
+
+	/* Wait for GIT loading to complete. */
 	ravb_wait(ndev, GCCR, GCCR_TCR, GCCR_TCR_NOREQ);
+
 	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-- 
2.55.0

