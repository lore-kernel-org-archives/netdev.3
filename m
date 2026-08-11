Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F1E3FE351;
	Tue, 11 Aug 2026 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786464307; cv=none; b=HX010V2mEV8QiEkF5mFGY+CM4Iq5elmTVOc7hH+kci4+4LLOMLIjaOc/j5WWjKi25lEW+OqhK8o4oSWM23Ad73tmGBAklzMQlmWEpuSOKEgYfwE5NOGwFLj8BlyHlr80BRkhKrL+O/ckqRyyVjGngse1lM9mOyq7yc948lzxVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786464307; c=relaxed/simple;
	bh=bJQEL1cmu3iA85cP7Rs9xPhId7BWFCsyoLqmche+90Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z56GL69wD6rOyvgwau4BBfL4JJU51rOmLXSEyju+RGQu9udhV7sw9B6N/7z7WCzKyoiozuCo/VgmPubuPOktwixnP2B/4ffm1sol1vYAZdHg2VJaqTaLykk4gAQWdm7E97VCcV08wTjjFaxi89xkQHL7IRRn7YRgY/2FtCgtJpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=ni9hUkuZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Va70kpqP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="ni9hUkuZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Va70kpqP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 040C6140005F;
	Tue, 11 Aug 2026 12:05:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 11 Aug 2026 12:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786464305;
	 x=1786550705; bh=T3YDA8QDdc88Ru13MqYL1x16d+r2XJYof4EL5JyVqhY=; b=
	ni9hUkuZU0QdhuZnjFLcmOnmGJSV/d5AVSjXNuPRY2WNRpEJEHHvcSAApp5aoxH0
	bQpnD3E8Es48KLBIetMcUR1BzRMYY44GjRIGp9nbsLcI7hUpxdWb2EaI4RefUFDp
	kswNhGU0sdqIwPAbHlpT6YixvpJDkxLGP3ClgIy2GcU0IqcBys/wAqNqpkGANXf3
	s1ypSr5trNRXctaYfFAnSanKY0aK6gp9xU1sWeJeMDOOERMQy+ImctQgiDXk8gRT
	PSkUpsNO+p8HsL3kVU2OM2BstA5qn4DynFLLPq9AdZoxawiwx4wmBlVHW2mHeS69
	xrpX2Mg5kcwQyyJyJR2jbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786464305; x=
	1786550705; bh=T3YDA8QDdc88Ru13MqYL1x16d+r2XJYof4EL5JyVqhY=; b=V
	a70kpqPXQjU4MISGeYRl/XrFYhvUCggdljYfdLx4MfkIW20REg33Az2pukDy1AXD
	xCMXWPw3+N8zQJNE3YiPT6pwNpJuuxRaXnaFb0Y37okQP8oY+cQCNyt4Hd7Ir0lt
	XoaVSFxQAzmz2jb8d56OeImCeZ6mrw1eDRDSGGmiZu0QCsrVXg3DbVU0NMYGNqym
	ATV9MEtRMSjPOT2eWKtcxQYcoiEUNxGKKlWQRqqF1OrbK6M3WWIdITMFeD58LKei
	3Lt1sWNCxG/eLHL603I3UB+u2Z15MA2avtwASVqa2qR569VqMrnhRmUGF0pNoMlh
	gtSZO5qHOIJbn/8zShvhQ==
X-ME-Sender: <xms:MEh7ai7bqww4Vg4y5Q9y-JcZQmMFxbLMwTznjqd5EzRC3o3_EpXecw>
    <xme:MEh7akpCqFutEPb-zzMdBHMK3OZJzPXz5TXtD6R8Y4PCDaCTSS7apDaSjBHVbuZVJ
    BXdyyvxXAH-jObQY8nIvhk2ZGpVar6ATZ08h9iDKJxny2jyO4eG9A>
X-ME-Received: <xmr:MEh7agLVCcXX5f_isXv7dP9uApdRNDfZ_9938AvHE-Zcje3YQxmFcGZvHsfaZN_34RI0XTD0WSliY1-Cu0uSy7jhNiAGclg>
X-ME-Proxy-Cause: dmFkZTEHSKU/mHe+6lT/LKJ8bgeRk/V053AqRrN1BR5zk1Shu2DOwdZpAbiAy9Gu5V3kwl
    d1h5rYgq3ypc8+YqRDw6+W1dLYGl7xAf/JnE2fouoUr+uQ91a2BYYQH9MIj19hgAFS85bG
    HKLTscK1JcTpPAqcQJWvsSlbtUp0RdE6RTfSS+w1mzdxNe3xP0yAJfQK9V9lP6dWT+dM4P
    mUlTM4aI20t5AwNoSG0JmkMiw/Mr+hK7RWJaGzCv7Qao7/mJJZshfXyd+BX97L+xujDMkI
    ysyzJYX2sNeQaedRdU3MhBFGetibaJ+uJ7gBG5oaNX//F32Vx9hqF9Rh8nKQaqzD+8IAVJ
    etqUMHEgSv4Qhs/QXH/NmRYelEof9u2Sk8BbBKIWpmyPEP5xxsLe4FLyT+uxcunf099KcV
    mpPIupN5jptkbuGsCc3NOriCKZFGH6MfatqZ6+L1YDTEvBeH/usl3Wcn6xynUlTVkA8WWy
    hAahMcGqwWNTI72SNP5eWtOZSF+wkzgkxCQ/l5PtRho61MxkkjV2xVTQ9I2cyqIsB4RUYz
    n3V4200Cq+ZqfIpcVdQVp1WSFtXo93lhknkkUQBuU0DFwu8sXAzoXMpnHZENVBmO36coCC
    S/g4UU5DLhoE7ZxqR+u/elfsSza+IBjABM7WjIz2wAM98Oiqzezn6casMcLw
X-ME-Proxy: <xmx:MEh7ahgVgjZREiLQTZa64UvrMCcjT6Acl9EZjZ7dYNxCcX8jxeN0_g>
    <xmx:MEh7ap9KLfJJIbpQT7_-9Qv1NO7_vJGHtJz77R68lDPsqRVccCpIbw>
    <xmx:MEh7alpW3n7bJ4ruOcSk34k8K2BuWYFO5CJWprb7xwaG4KqHC_TlCQ>
    <xmx:MEh7auOp3YKlDfpl4XigctwcrT5brQyIUHIP8Sdsd8tZhM-CmnVrWA>
    <xmx:MEh7anTgO2bww9DxDYA_4hU8qVtn_r_kweyMejKVDt5xvE-S_LPzlOrI>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 12:05:03 -0400 (EDT)
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
Subject: [PATCH net-next v2 03/10] net: ethernet: ravb: Simplify gPTP start and stop
Date: Tue, 11 Aug 2026 18:01:53 +0200
Message-ID: <20260811160200.2049987-4-niklas.soderlund+renesas@ragnatech.se>
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

For devices that do not support the gPTP clock in config mode the
somewhat oddly named flag gptp is set, compared to devices that do
support the gPTP clock in config and operation mode where the flag
ccc_gac is set instead. The two flags are mutually exclusive.

For the gptp-flag devices (Gen2) the clock is tied to the AVB-DMAC, when
it is stopped so is the gPTP clock. For ccc_gac-flag devices (Gen3) the
gPTP clock is available whenever the ndev is open.

Prepare to add Gen4 support which will add a third way by cleaning the
Gen2 and Gen3 cases up a bit.

Fold the gptp-flag start and stop calls into ravb_dmac_init() and
ravb_stop_dma(), which start and stop the AVB-DMAC. There are no
functional change as all call sites to the construct:

    if (info->gptp)
        ravb_ptp_init(ndev, priv->pdev);

are always just after a call to into ravb_dmac_init() and all call sites
to the construct:

    if (info->gptp)
        ravb_ptp_stop(ndev);

are always directly followed by a call to ravb_stop_dma().

There are two special cases where the calling construct covers both the
gptp-flag and info->ccc_gac devices, one for start and one for stop. The
condition that it is preceded by a call to ravb_dmac_init(), or followed
by a call to ravb_stop_dma() are however true for them too. Reworked the
two special cases to drop the check of info->gptp.

The end result is that the gPTP clock will be started or stopped for the
gptp-flag devices in tandem with the AVB-DMAC, while the info->ccc_gac
devices will be controlled, as before, when the ndev is opened or
closed.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
* Changes since v1
- Improve spelling in commit message.
---
 drivers/net/ethernet/renesas/ravb_main.c | 37 ++++++++++--------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index dc2fbbeff895..dff66a347baf 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -707,7 +707,15 @@ static int ravb_dmac_init(struct net_device *ndev)
 		return error;
 
 	/* Setting the control will start the AVB-DMAC process. */
-	return ravb_set_opmode(ndev, CCC_OPC_OPERATION);
+	error = ravb_set_opmode(ndev, CCC_OPC_OPERATION);
+	if (error)
+		return error;
+
+	/* Initialise PTP Clock driver */
+	if (info->gptp)
+		ravb_ptp_init(ndev, priv->pdev);
+
+	return 0;
 }
 
 static void ravb_get_tx_tstamp(struct net_device *ndev)
@@ -1115,6 +1123,10 @@ static int ravb_stop_dma(struct net_device *ndev)
 			netdev_err(ndev, "failed to stop AXI BUS\n");
 	}
 
+	/* Stop PTP Clock driver */
+	if (info->gptp)
+		ravb_ptp_stop(ndev);
+
 	/* Stop AVB-DMAC process */
 	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 }
@@ -1719,9 +1731,7 @@ static int ravb_set_ringparam(struct net_device *ndev,
 
 	if (netif_running(ndev)) {
 		netif_device_detach(ndev);
-		/* Stop PTP Clock driver */
-		if (info->gptp)
-			ravb_ptp_stop(ndev);
+
 		/* Wait for DMA stopping */
 		error = ravb_stop_dma(ndev);
 		if (error) {
@@ -1752,10 +1762,6 @@ static int ravb_set_ringparam(struct net_device *ndev,
 
 		ravb_emac_init(ndev);
 
-		/* Initialise PTP Clock driver */
-		if (info->gptp)
-			ravb_ptp_init(ndev, priv->pdev);
-
 		netif_device_attach(ndev);
 	}
 
@@ -1961,7 +1967,7 @@ static int ravb_open(struct net_device *ndev)
 	ravb_emac_init(ndev);
 
 	/* Initialise PTP Clock driver */
-	if (info->gptp || info->ccc_gac)
+	if (info->ccc_gac)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	/* PHY control start */
@@ -1974,9 +1980,6 @@ static int ravb_open(struct net_device *ndev)
 	return 0;
 
 out_ptp_stop:
-	/* Stop PTP Clock driver */
-	if (info->gptp || info->ccc_gac)
-		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
 out_set_reset:
 	ravb_set_opmode(ndev, CCC_OPC_RESET);
@@ -2020,10 +2023,6 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 
 	netif_tx_stop_all_queues(ndev);
 
-	/* Stop PTP Clock driver */
-	if (info->gptp)
-		ravb_ptp_stop(ndev);
-
 	/* Wait for DMA stopping */
 	if (ravb_stop_dma(ndev)) {
 		/* If ravb_stop_dma() fails, the hardware is still operating
@@ -2056,10 +2055,6 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	ravb_emac_init(ndev);
 
 out:
-	/* Initialise PTP Clock driver */
-	if (info->gptp)
-		ravb_ptp_init(ndev, priv->pdev);
-
 	netif_tx_start_all_queues(ndev);
 
 out_unlock:
@@ -2374,7 +2369,7 @@ static int ravb_close(struct net_device *ndev)
 	}
 
 	/* Stop PTP Clock driver */
-	if (info->gptp || info->ccc_gac)
+	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
 	/* Set the config mode to stop the AVB-DMAC's processes */
-- 
2.55.0

