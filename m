Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98D405C27;
	Wed,  2 Sep 2026 08:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338846; cv=none; b=JTHmCN0zolBzB7lvdMYWbNUz0+HIzakwpJ1fkGCR7LulaSfltzXmLDPsVAPmDRhC/srZVJ3MTR/K3sGbDd9R6jxXniFC1nOxMiNgKh9QBp5Zt861aLj5DEK1BXJ5zLfxyOInNEqfFwzA8V9o6jV7zEPy6kWuLpYJwulnaNSrcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338846; c=relaxed/simple;
	bh=nSR3HSnVpPTuu5U9i4z2bz+hbzVGtMi+/826ESHNgTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FE7/UoY3lXhcAQJswvb5845FOCrLsibchd18y/SY3TOPOVM8eHGDJkQh9tKmYxJmn9kgtpW+SSOd6w2EfwPPduY6HAJYDHc/ptBbrDTtH4A1F9qi8fAFWS/ZYZee/cL9ECzxlQRBbu8k8NaJWdIFX2POatILsO6GiM02x2iNpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=BYiNqnkW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUxkuQPZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="BYiNqnkW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUxkuQPZ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 564F21400141;
	Wed,  2 Sep 2026 04:47:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 02 Sep 2026 04:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788338844;
	 x=1788425244; bh=90yR28BloUHX3qSrTf3FabQIL1bRJn8PhLYzuvKpi4Q=; b=
	BYiNqnkWeoitEb2LG6L2Cy9MXRHxXH8qapMx/iIlUW9Ty6o/xDE5ueKzzyT1jSRL
	Rb4gvSRewwYvK4NA8QPTPg6Zlvor7lG6J6EHYdDPyEcJ8J1OIegw8dH6QYDBAZMC
	lTlvPJnw8qLyYfwIdXxbypQrnN0F3dOGn+SiS3WiYQyie9dL7V1XiDwxHU6azc6a
	Oln2yQt2w5SGufInz5Dt+e7ChVScjjcbl/lHhLlJopti2X0T+STVUMCX7wG+9dQe
	gq4Mf4IJ1oUtycKiBCXiTeqvJQHxQxAIiV/UV1L5R+5M6oYfmEoFwpMdkQVgMiKa
	a1Tg4UHYlm4Y+mkVJZ1eTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788338844; x=
	1788425244; bh=90yR28BloUHX3qSrTf3FabQIL1bRJn8PhLYzuvKpi4Q=; b=J
	UxkuQPZhj2tiAJvWLkXZDbFHa+AzU+ifDTD4osbv8kQpZeyY9xQIs3Nw65t3FH83
	Ae+uVd4XhxERlJjhOTtgY0zV03dTAqhvgywL2ttxzbj2EkTFBHcrvDZBIsYKOtCz
	A+qBvQiBZRTbnBanvdc9xtmwtzyfm/UwOXHTCaAa28+W1piY/QZ5dfKCi3LZ6BYv
	g0/4f6Edmk6aUt76M5okbQOlRcGsITSBzyoH8r/XtaZBsjo8CExDCYgRqpvzhoBd
	StPPuQIhUogmwQ962UjK2rT3bl1bYL6KLEhPgSzf9cG3Oy0RaES8r1HazbRSm0Y5
	abz8IBXzAncDpcUAlDWLw==
X-ME-Sender: <xms:nOKXao3_7OlbyyqdEsgtBLdr7GoeQhUWHHd08ncxtkv4dpx1ax5e_g>
    <xme:nOKXaomcHK78Vs8qVZaiKOYY0Ey9dBoRgdp-GTkQ4EgJEJ0EN9S16hR5P1bxXQ4wF
    65-pGnkGg06gut5SJTbPa-LEODsjJpA_bjq6c6QGd9ozrZnI08U1lc>
X-ME-Received: <xmr:nOKXapNTOFWvF4UmTISHZoDvj6m2yCN1REaYuJlG5VbPYjM7f9A1tRRC18SlZwarjPIfS6zaGHd_10y885NMpKe3Vnwgh2c>
X-ME-Proxy-Cause: dmFkZTErXYyCsZzfm92YrYcrxv1EBH+3gGzXCytSVYtChsjw1I8nxza/1mVbG06NescpYI
    ijrlhm4QUzIjE1Ta52G1XvMSZ4UmT02/e9XVdS0BTzqvoykuwFxy/egHwAHuIK5TsZWqyr
    6u3rd2F6xKDzPh6I7UI5M2Oxx4x87Ag2ZZpCVRRu8f911TqF5Cy2xNLpzpgkOb8q9nX6ps
    mmiA5czZc27unSRsWpixJ3qrm7f3jL54dMR58K8niQduWDuh5XpAPG0F+2ZvDE1zMXgnik
    DNhL5F/TPATp8CRF168TAMl5+ifcCsryg5QvKT3wCd71cG9Vzl3KCg/O1spMcDB+VjotjB
    YyHxwJtu+KS+6YbRLUt0QLAPOmwF7QV2AOCGyzXN8n308VLto6LrBJOFDmbZGcxM38BUSP
    F1Q0jBZW0cht3sdlhK7JGpoX5s1hNFq4gqyUn2lKgPaXwf2qXawI0G+DK13eToe9SDVs5H
    3K8UzRvNefdwMb6dS9y0cL8JFDY5Ye1c9Gl29+BoRp8QJ9u9mzAqpk1wnjfhKCpXqTeCtm
    4b03WW2lNgHdiWS2ohdd81JCXl1c8nZf+p3KMZlqvtH+e9oQ/cZ++pcnzAWjyVjXL2siT9
    Om61/Mqh6Flg+7fbbZYNY2bF+Cb//J1TS0kjlRIJdyILEvMSz8kmXEB+VNLA
X-ME-Proxy: <xmx:nOKXav5mTAW5lD4vpmjSprIC7l1ro75xgi3iUk_JLFPPvo5UNCUF3A>
    <xmx:nOKXas3ELiCpTH_GauaZ5PlPNRZ_5ixhCOZyv58NmH-I57Zx9_4VeA>
    <xmx:nOKXatoCXAHCcsLtaPzFtMpjfKQYElkH3jXAZnm_VI4Yskz9nGSh5Q>
    <xmx:nOKXamlwmADdh1Ec0u-8U9X85KBI3bi4DUzgM7qf6AOFW7vZBSfhag>
    <xmx:nOKXaptP7Jilrfv2y0NvqHXhebVnsMI1p9heAQag70Dw11QIYMKWq_A2>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:47:23 -0400 (EDT)
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
Subject: [PATCH net-next v3 03/10] net: ethernet: ravb: Simplify gPTP start and stop
Date: Wed,  2 Sep 2026 10:46:56 +0200
Message-ID: <20260902084703.3228504-4-niklas.soderlund+renesas@ragnatech.se>
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
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
* Changes since v1
- Improve spelling in commit message.
---
 drivers/net/ethernet/renesas/ravb_main.c | 37 ++++++++++--------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a89f6fe7866f..2d0022a4f85c 100644
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

