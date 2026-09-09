Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755723921E6;
	Wed,  9 Sep 2026 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788975068; cv=none; b=XOOaamfHBTARtcpS0xnBA7bjIGry7AUdHA+bNUWxqxekzeL2aIpvT2l6+tt7ixQFw3AiNKD8hxdzD9TbmedqbkR96JLcBiQiuiMWeOIEuTRMIiVMnldz9aec53L4IeHf+9aBMyzCSX487VGdCmhdHJLzbqRu2qkmR4fWinqBUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788975068; c=relaxed/simple;
	bh=nSR3HSnVpPTuu5U9i4z2bz+hbzVGtMi+/826ESHNgTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5xd4BhU+/lDHDm1L6yDQLG3sHmQBt6GmKsomD7BSFXfDHOb7TRXeElHuZaDm/jHNcZYX/VgikggtPrY2JOj/YMCMHzuF3hIwO+egxr5hfA9uQHs3PnTY4LWwdP/jFr8l3r1cT7qN1DxX+aG9O2jB+TxKH9PVkN0U27ylngRf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=mDU2Xc5b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b9zmnIew; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="mDU2Xc5b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b9zmnIew"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 351B77A00D5;
	Wed,  9 Sep 2026 13:31:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 13:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788975065;
	 x=1789061465; bh=90yR28BloUHX3qSrTf3FabQIL1bRJn8PhLYzuvKpi4Q=; b=
	mDU2Xc5bo2wDSWbPnDHUOunyUv0uGCgNfBSbpzpnymJIHHLUoo85GaOJ45fNEvZ4
	aIXt1m1eP5jCSrGoKLeXN6gRNGGPOQ/uYPiAhmCs6uFBxVTTOWfCcmbX5z/rIWZa
	brinLi0uoL8Y3Zt6/w/km6+RaksFAtEwSNUHMDHfowAv0BOYMG1fSzVAU8X4P7UP
	bD8PDbIC8vXtPVmgzyeutAj+RNsS6/ZcwOvM0pSGxOMVbOzOdDy67iAew24uNRy7
	ilWIOOauNA7ngMBurJkS/DQ4fmPcVHcnYnxF5/yhGS+boltXC9d9kWqFbPOkPiSg
	m4xi8/zT3oFT+rXPMrqEUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788975065; x=
	1789061465; bh=90yR28BloUHX3qSrTf3FabQIL1bRJn8PhLYzuvKpi4Q=; b=b
	9zmnIew2W7dd7QJaIsehj99OVEHu23KpKSlKUSAFybKNPHGqFHjd+gGgZQOH/RSG
	S8LUVhUixWcqrzrE1bzdcv/rBwZJ6vMT77I8IthB3tCtEu4r5s1k4Z9qRPjldkmT
	W9q4JfycUy5T14H/5vcSC94la1j/3rpEDzEZS8OmM042lj7z/m6g8Dll2m0Sll9k
	sxQEg2LUl7oQhZ4HMzE1RBRI+Yzhxd7raoDFzw3tvQiG8wAAC9dwFGwSobv2MxFB
	XljEQHs49ot13RHDx+5W1hmnJSJoILZB0fXmcVel1Q5M/GHEJap4WpMTJ0+sS/0o
	IBwztgXPuEipULE7DMF8w==
X-ME-Sender: <xms:2JeharPuQTkoajOj36gi862lIcyANsOD2_0TyeVQvwvkRWMLEZH9lg>
    <xme:2Jehas7RbvkM1UTJH4iTIzASoBhgAJjGocqwLuf-3xrwL5ORpolrZ3i04RG415j83
    SHgy7UgIB9gSuGdhHb8l-JVKlnBG3dGhnqyOicG1QJ3Etmm3QGuZnCrrw>
X-ME-Received: <xmr:2JehavW6hYROt7DWtkUD5NQ5c5OcDEtGrhfjoxDWtSVN6jSiI4cR0WHPoTgXlQloQQ4fFbc7ZkWQ96j9oi9zryrthBclUZw>
X-ME-Proxy-Cause: dmFkZTEF01o62KOqUAHAoE+QVORj7r8TaCrIRf5OPWQ9Sp090ondym5bOSJDH9EhDA0N1J
    m6oWrIHZUlXi6Du7gssdeyy+/BlAkuIXaHCAN1uAugotP20y1lNMlpeZQus2Nlz/ti9KgY
    FhB6kaG9EPjkChJBP2fV57Rf5YCpIccezHDvjFb5cYW7BGEV2v4vM6aFtwlMNxZ7lMRyEj
    +cp5LwLEc2MEUsvUI+o18XYg0zrEaWvgxZJMSqPSeKERfPJg0jhZ39Wpp4IzKso4KrZ+Jd
    nafFym7s9udRKlmBiDB8FyT/3eFfMJ58g+x9eInhq64X5vYSgsZjNwy9qzGmVDF5g97He0
    jwjGOdP2zxodBtHyxeswTt66zoEuOiT5K/ajgPJ/cfb5AS1l6Mc7vPrzwDpG91gY4Oci+u
    Xm+DmCGdZNyLlMzR34cOGDagDKnnAH4nDAZLP2tByo0uFC7tkBI9nONWEifxUXs+NY0tXT
    nmzfFePjHoBF4FKJiz1gZ2/q/xDC7PFseT3rnq3KgGxc7g/knTnfyLTx2Gqa61/YqvPCWh
    w8O/m5ibygF1Ahc6b0OkuZDmO1vJcj2qxB4jy/1Nf90i5c1uE0uP/DtfAOdDxu2K3p7IW2
    TMudaa4PNRiThQ07cKeyKlJwtrjTw6Hl9zNnKJVj8aPMIIF+T/nlOq0Tg68A
X-ME-Proxy: <xmx:2Zeham3weofPXYMB0lYp3uffanE_wNr-OWjDvTwktRZphfTOfZ8zqA>
    <xmx:2ZehauNANWgzHZ-6KfwApASLPql6h8K-Y4SEonOYbLBhxTU-FDznWw>
    <xmx:2Zehah1qDl8r8Srf9YR0ErxdA6FIGJNnmPNk091g_eFM0NsBDF8Bdg>
    <xmx:2Zehat2EgZgxHCVUdNmgpKXR_sApZPBO8Isw5-Jl3Ogs-9aV1BfBXA>
    <xmx:2Zehar8T4OnLE4Zme-0tqYVCDGWu3e7Ps5ydGj6Us52NBePu8Bb_Cayk>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 13:31:04 -0400 (EDT)
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
Subject: [PATCH net-next v4 03/10] net: ethernet: ravb: Simplify gPTP start and stop
Date: Wed,  9 Sep 2026 19:30:20 +0200
Message-ID: <20260909173027.2201560-4-niklas.soderlund+renesas@ragnatech.se>
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

