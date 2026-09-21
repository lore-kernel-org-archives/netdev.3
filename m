Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9594AF9F4;
	Mon, 21 Sep 2026 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013069; cv=none; b=duKmvxKtpci7+3aj1AsKLoPnk1AasmNaK+e9Qi6/YcKQKQYzdL8kpH2WiJtA/+44dthbvNSPk1e46hyHnzkL+Ylq62BbBgRBOQaZSS4q6YkOsIPt7L4yEmKcUFNB5SRSlvgT/o6lxgRuDSvfNRsA2/eMQ6LmFDl1D3wle1zj2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013069; c=relaxed/simple;
	bh=OK8h4W8Qb3WdBP0L5gFqTZOwrg1Mh9yNZb1fGNPTOzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdI5TCY5ptI+BoGh5nZQt/LMy573a1nvC1zsF546c0fotwEqqB1JiSrUMKsW/2DEAEMnBwng0Ca084vxRHU1fQEDZSOqAKUawLak52J5fveuS8IM2kbvbiJfdTlcugTYN0WcN7CzCXetYagZTJMnF+sSG6Qp4Xm5leLgMxn1lnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=OkxZCfPL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R7P2SBrF; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="OkxZCfPL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R7P2SBrF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E8451D00117;
	Mon, 21 Sep 2026 13:51:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 21 Sep 2026 13:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790013066;
	 x=1790099466; bh=xLsQam9KYOnUXlZpyMTlagCg0xIJIMA0dYVJY+iePdU=; b=
	OkxZCfPLqVPrna/yYKGCQcTcP+T0fs8ufk2y6qCG7JZmoLPSMsqgWNb1fc7nqye5
	j083C3LUHgBjwo0kQTEC9fC+3TC1jKFQ8ei76MBjNkiskQAQSCMiByoZ94OqBS1Y
	3b7X4iiOvmfc0jXG6908/66P9V/FQ/LJueJhc3NEA/fX0uSKTRrq8lbnhiONjt3i
	YuSVB4ey5isgQgzFam84bKzqaZY034QCuDvBX/XrkIUU3Y4o0fYTnW7lg/HczAOx
	4NWiqlqMXdEAweQb3jKcyZXdlifx6vJNPFobIm3yToqpGyMghnGDXkyCtAM3rqNR
	j/Qz5qfMkO1At+avRH/o6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790013066; x=
	1790099466; bh=xLsQam9KYOnUXlZpyMTlagCg0xIJIMA0dYVJY+iePdU=; b=R
	7P2SBrFI8UpVY9583Pc6v9qA0h69HjouuF6dPyrco9pGLeBhIWc2CC9FbMX3QIuV
	Meuv64nWkh2q/2qfeiBxG5+tDZwBY4uhBDqFjQaT820OxEGHwKPQaplMa8d8MsFx
	EkY6Zt60XjOdeskRnyvRLPRlldnTOt/vX7C7vNMEoDcoOvAqs4ZDHAhgMuRCAvWd
	Cn+h/mmJ9xh0Td9XfeoIpWEVthBce9WkD/eVZgVt5EdSUbQvMPrhOTQR+cwIvq3b
	6nIrO+qUZfcv8hHqB0vMACspFGCsNMxjXY0MnqWAKLqUreXp2MxKqYQLOHHfECpv
	aov8CCNSNJAd+jSKRA+kw==
X-ME-Sender: <xms:im6xavOPuD8v-SOAlTROLCCx3lKm_-IWlMHd7f0QEK9w81Bo0t5ZSg>
    <xme:im6xag760HX-gOeKcNBfJJfL0acopZNwruUUdjHNKhgs2GgHArcVSQTa6sKkPMana
    rpEKqh2ykAC68NCZ9GeXIGUkzbT76M-I-nN-qQgR8IfmGoBXEB-47Lf>
X-ME-Received: <xmr:im6xajVeekWgicDW3mZn7psGGHpHylZOQ-clYX3y9Ds4yEIhSEy-4tzrsK0elDfXMfSgYgeVv5PGJpfLF09KivvLZPvw4jw>
X-ME-Proxy-Cause: dmFkZTFKyuwNHokJCgIndgtoOusqu1/6uPi/0uzv51oOMJoBVzbBuuQBERlY9Rv3NvmA6T
    d/CD1lxyU3UgPnEeJyPNbZpf+4OQPJ3AbFbyzvtJqzJyhSU0WyRw2N3jkO5MC6tTob5H+B
    TCxu9EekrWCaHBw+6MstQGy681MV+L5ictmDPIp7n4+FYelCRH1YJ2M1xfPZF1CqF0smxw
    c4JIURjRlH1wsfm+CyMKRUhHTOncPDoh9a2aZMLd+DzObP2w66sKePqFvy/aIxy5vDMgrD
    fRXTZksUaWctOWTnUr66Aqn0xuMYZyKstCQR4Y6Vusob1m7Y0ettnqm2yu1mZb4HnTRWZc
    4pnvDWpnD1pj18sTy78Sk44z0Oj10BsEdC2DhTgIeFCoq4Z61df/0k0eQ0qxYOZAagjPe1
    MOWqOR62HXnFbhlk6S1Fs+KZT+/ic0N5f/yUjYgtDj0kH/mI540pWjRukXRVwA0ClrIIcZ
    5BipCBkPtf+hxnqrfYv+pJjpBZOB0Hxr+fgPEZQruH0Yxc0F9ZDFLOZUQSXknflbZqdvOD
    Yp+LeBlxcUH9bFndAZ8kenRg4wwtC90QDZvqkvH3msLXkBon5iMURb4C1abqNFL8YcpSfX
    kBSVbGiFvFCH9ibzNwBJ9f8cVavK9WV6K/1i/DLQPNpH+jGzhfdwcXGZLxSg
X-ME-Proxy: <xmx:im6xaq3yT3k2mre3LyNxBcXTAacSzKsBgVO7Qsp8urpjZigwlqW-HQ>
    <xmx:im6xaiO27FJJsu_tdNsQyVl2tlVKTQFZG4yUbaHah39jN8xruVyF3w>
    <xmx:im6xal3WgrnUnLIKDPXOPIhMV5Lx0GJSxIvyEV1Sp4a3VEpbSrKe7A>
    <xmx:im6xah0cVQCW__Nzl70VVUYaiBTdYHe02qmhC_6JM1s7KDIcgS_wrw>
    <xmx:im6xahvpWeuxpqYTY0OMueYxBsqXm8MxExWdjkAEqs28ICzsnUUHm_tn>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:51:05 -0400 (EDT)
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
Subject: [PATCH net-next v5 02/10] net: ethernet: ravb: Move programming of gPTP timer interval
Date: Mon, 21 Sep 2026 19:50:29 +0200
Message-ID: <20260921175037.4084310-3-niklas.soderlund+renesas@ragnatech.se>
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
* Changes since v4
- Update comment in code to try and address LLM hallucination.
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
index 43218bc15b15..ac91a6813368 100644
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
+	/* Wait for GIT loading to complete by checking there are no requests. */
 	ravb_wait(ndev, GCCR, GCCR_TCR, GCCR_TCR_NOREQ);
+
 	ravb_modify(ndev, GCCR, GCCR_TCSS, GCCR_TCSS_ADJGPTP);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-- 
2.55.0

