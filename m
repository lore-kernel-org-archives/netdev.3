Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A9C3F23D0;
	Wed,  2 Sep 2026 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338844; cv=none; b=d2uuLbKfRXedB281M+YLrG8tX8KmTdsclUh7de4HZkBDdPb+NrvLShzVPwJCM/CP7A1gfEAI92klxtf2p/ul9zVRuUWz6v90wvCYZs2reYojW3bvjkK8hCEVi3dydxyKYPSvI29BSxvyvoA6IFvG4rZ8crz2p376fXBDnJFT7Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338844; c=relaxed/simple;
	bh=hmpis5gJE2ngNtWrXSfh/ef+Yj7WTtZXvIsOf15v1rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JjC1CtuqBCDLVttPymQTVYSwAvunvslnWeRDrJihFPrgXNmCC2vTUKw1AEWXq7HpAloaXPro2QR04DtrdWAF9S6XNmxW1rIfP/fhxuRjs6tpnxT4kn5e1LNPJlGD0L/Jiw2Awt8oRN+cHDky/UhaobD89ZyHtY2VZKk/NLOmmiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=P3dx1XLs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UwV59StM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="P3dx1XLs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UwV59StM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E491814000F0;
	Wed,  2 Sep 2026 04:47:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 04:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788338841;
	 x=1788425241; bh=L+9oK0TXXxk/EiHiWORG0xWm1SXmTAQfkqGE6zxyfjg=; b=
	P3dx1XLs8aTJUKby15owYZH3kG64wx+rwwltd7REOwO1IWEE4VaMy9qDoDVpSlb+
	+nZ8MgB+6UTlb/3fpbmk+kKpU8IKbU+Rud52cKs/ygCzDIOsjjmX6kepkzhNQiXi
	Zp618KzhX2rnSAhNVNhP1UnunLe0PFLcTcdf7we2GKZCscvoiwQFl5nz79uT+DJt
	4jY2HreDyRkUnGRitzgRndT7URizI1043/iWm0qpez00/PctdpJ/xp2uaWE7J0eR
	S95d6PwpZtRnEjHoi5kIK4MDxHMTfX9ElrOyGXYo/Y0p0reZOlVRJcyBpM1S2ZWH
	eo/yqj8LDWvAMs/GWNmuSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788338841; x=
	1788425241; bh=L+9oK0TXXxk/EiHiWORG0xWm1SXmTAQfkqGE6zxyfjg=; b=U
	wV59StMftjV7g3++WYYJ4+hmbxWaEyidQ2/tuhYs+/0yop4Jdmwc/hGMzrSM0Cyd
	obzlLz6ZCvnHyVceF7EwZr5bDfGSVA4+wJvdkXH4MlJV+BNh2VI2i84bL0o77+xc
	fcVFmZl9JvdOGv5TM+MXwWXqoF7bCM3Bflcx6pa7o9r7Eu6NP9q3GAUx1JIrYt09
	mvffv11hg+zHpcoV3niAIBOQMIB4V2OcxSQsskPVXHEW5JGMBTeWq9r+VYk9Pixz
	WOleBvPFNn4ukMITmuVH2joefDdKCWsr5yiYn5thXG2/QHZpp8Tn2PzKzls6O/gK
	5hzdPEYen5nVR8ROXVzfw==
X-ME-Sender: <xms:meKXag3CndTR63W-gm2O5A9Vn_AOPb6t1WTn2KcxrWdp9ONiGO8SgQ>
    <xme:meKXaj3ppwqD98SX7F-tRMixnS3sP2D-fNLQZNYotLmj9iV6mWhewDNMqP_MkQLI5
    gyKgEbUn9yVEHBwDg0-U-d4sE0b8Srq6QMMrd0WVh1qxJvWyXW-QH4>
X-ME-Received: <xmr:meKXank85pmst9vfWA5ijsp-JPlUUx1G1SPinOWYUfz1H6y0Xd29FgixfA59kpjWni05XF1cIQDfGiEp2dJRMuhtEcc18S8>
X-ME-Proxy-Cause: dmFkZTErXYyCsZzfm92YrYcrxv1EBH+3gGzXCytSVYtChsjw1I8nxza/1mVbG06NescpYI
    ijrlhm4QUzIjE1Ta52G1XvMSZ4UmT02/e9XVdS0BTzqvoykuwFxy/egHwAHuIK5TsZWqyr
    6u3rd2F6xKDzPh6I7UI5M2Oxx4x87Ag2ZZpCVRRu8f911TqF5Cy2xNLpzpgkOb8q9nX6ps
    mmiA5czZc27unSRsWpixJ3qrm7f3jL54dMR58K8niQduWDuh5XpAPG0F+2ZvDE1zMXgnik
    DNhL5F/TPATp8CRF168TAMl5+ifcCsryg5QvKT3wCd71cG9Vzl3KCg/O1spMcDB+Vjotnb
    55PfxDbJgdMwIG2wOAnBRZ0Ap6iwua5YtQrCrj824bYlSgwlo/FY/Zzx1Hp7JNY+9whzID
    qSFt1yJqtj3v5Bmpaya3TRdYCD1Un+69QacvBAUCbORa2v+sOmDKvFQTDK0Fcb11z1ToL1
    jPfIDHYFdhkTNaf9hwBgPuyUIETIKPsfhOWfMKIw7LsDMGOsk2CXDSKkHQLMlJZgW8yWeY
    VnOBtotvtjhWk+nQhvugFPY0RQLlFGHRKDfDyNVWTLMjki+vUgaNOHiqKkAMufFwX39SZv
    NVO/WdNfczLKia0HmP9/L0fGf/drWoqMXJSWWeoLOxam9hr4d6sMVMFJ2Tuw
X-ME-Proxy: <xmx:meKXasMMA3E4YPMrhC4buoBLH1MfjAXmpIMbuyXRnexVtvlbFW7BUA>
    <xmx:meKXam5gPlW_E76SPu5GMNhdFNYg973eEoAf6ioiimYZqveg_pEC_Q>
    <xmx:meKXan2ZkKPQn3Ht2rnUM8Tp8KdIi8mfPK3JLXLrMDdYgXEBNIPiDQ>
    <xmx:meKXasqxWYk90sBWIEenPAPudCjfBsCyh_GyjkYYzNEzqTrl5N-wNg>
    <xmx:meKXaisZp8p8OMZ7M31YrHIc4P3jdayGnE_ur2xFI357f8frDVphEH2j>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:47:21 -0400 (EDT)
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
Subject: [PATCH net-next v3 02/10] net: ethernet: ravb: Move programming of gPTP timer interval
Date: Wed,  2 Sep 2026 10:46:55 +0200
Message-ID: <20260902084703.3228504-3-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
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

