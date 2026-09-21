Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542F4E5336;
	Mon, 21 Sep 2026 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013073; cv=none; b=Lr07LI1ztqjXDxyPlyB44+UKC5TRz7zIlODUnjpOYUDmMyrnOJOHadWhJT+zpazfJnriwlQvuH6PD+6rOx3SOeZh9eXvltKd3ioMRq/GZHJmsOcl8XZGLOP3Hvn3IJbbLzl7IeYrFtzjuSBiEVHb8n1bflU53JwGR9JtLCG716k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013073; c=relaxed/simple;
	bh=srAWmKXguWc0q1fxvPQkRLk3OtDf6cRshaZ343sxc4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fc5iCjkHyVX8zt3UwRv/chpK5sFfIFEv6a44p63/DGx4dLSwWLNsw8s1xCU81tyVOnk6SPGEZZI344jkHYqKY2hv9+p6cjO+gWhai7maac9KjbOK5atp5QeLZzEv06/asooitr28FRs4+xuz2DFsFh6Z5zKmhf/sHyE9dZZAYJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=jIaoTuw7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QqQB38Z4; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="jIaoTuw7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QqQB38Z4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 70F0F7A0104;
	Mon, 21 Sep 2026 13:51:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 21 Sep 2026 13:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790013069;
	 x=1790099469; bh=Hx9Zvyr370J8/nt0naogfD+gRG6r1y/8v2dOZV7ReHo=; b=
	jIaoTuw7ZTnrGdjEs3y1Xp5SxoKOzMnQfoq2gNWDOGEcxedt1VWVj+RfWgM5WyUJ
	hKXw7OacWn2KGyrMEEDxiOhfSpSAJU428fKf/WinvkkGq/vid5vhFqjhRHY3ECSr
	5YwpaS7DId08l+A/bPBhwakuDEkAwVTkSffFkLgFmZqLaWnLYCd/DF5wU+qAAwji
	ySVc6hwQFRnwZ5YdiU/Ge678LOaLX1VuMw5LAbYqTNeqxZRDsyFbOM9hUKVDvMFe
	3Ddr2zZ8Lc9Ipb3g5+GkIWrseG9ViWdGxTXGok+j2ECfPO3LEVVHdfL0KzmAbpZ6
	O48QRtFGXDqluttMUq8nVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790013069; x=
	1790099469; bh=Hx9Zvyr370J8/nt0naogfD+gRG6r1y/8v2dOZV7ReHo=; b=Q
	qQB38Z4AMMmL0nxXshF3Yz4YYq0B7uDROAqK+cYr4ebb0xNfxp8KTvlFQgSftvJH
	yMub4vvx6KNGg20KfJbDrmMIorA547nUUhrkdUL5V4bWbgzOWsPlh1wYWeXPVMZX
	3JkKRJ3lamBkofDbHxGXfi+FtV423OsBAHw1dNpBedTrc/+3zcj4a+gmoWwiE2BO
	TK4nSFAEP2ABb5m/N7Haz7rnlm1eFhpFOf7qQ8T8RUWbL823hEe7i8ZBMZbi1/59
	TRb01phcgWfWmDySHHAsYVuiDd4WUD5VbTXLotoOMogQZbmeDuVaDPeH7cjMX2Vv
	WbjtniJnjqbSumdObKBSw==
X-ME-Sender: <xms:jW6xarWhQ9h7wbV_sqZhJVZ5nM0WNcodFZhVlqI15NdDgh2fyWNYGA>
    <xme:jW6xaqjV0_VynM4Trdk-f5WZ8oY9w8y2eEdSXvJU0JV1LuYnVqqoUEiNHL62IIeWD
    1qDcN8pLYRYlsTsRZbjpl7IPf6XrABcdPduWVM3AWDEV_ml_EKUqOme>
X-ME-Received: <xmr:jW6xasc69lUOV03OCZi6BYu0WDIsSRRfBMRDtmsfFBOBFx5VSB8nGzmGgZ7bR9z83uWPa6iBxL95qSn_I0eSS0VZoYKaFm4>
X-ME-Proxy-Cause: dmFkZTERb8iWuOaCoZl7Bdy7ms8LtfxU+xjK78I80yyQZdvSwOOOfv5Eh589Pe9RlM06WU
    dDnU8HOY0XEZCSLotd4wkziCSyOMbfYp7QQMcpxqxHGnE0sN+h/hwRsMQX/TPzjkM+eutR
    EyTNwAM1tWMwrq7QvnP58hqr16hBRsM/xWQjxvzbUj3rLPulCyCubKGS8/OfnPdml28WZP
    11HBM2ETQKxQIL8VV/A/GNA6vlfx97xrmJ0/jihnD6jQBVLDZo9wvlSWgasgNowAQLofbi
    uJp5/Pi8DlT51OEeXr8hn2lIL64WOU6L6jZxXkbUv9MeKffjxF51gA/7UnWz5uX+sq6JTi
    enyrpEnj+/zN34WERnmon9+hcAmHRPho/VpdEQOXolNmPWpxSUHoqG+RQfBBWClN/WkFOH
    uVTgyrYzqn+kLoRCbFl0CVE111Nnfoxq3KchnJzi8VRas0Y2dbLOhvIsPW/fhMOyNXq9T7
    x6ttQ3uaNRjOrOopTGoyza5q87lgml0DzBK/jI0s6PaGWxq8Z91Omc2mgDjpjMR7T6o7/G
    9QZNNHQXjoH3FvAb9KrI0VkE1JLHBVnpkR/X3x4fJ3W1ng9JCw1xHsd3UFJx1sNd4nls//
    i8fFw31QFi7k95ndiobkDJ20MEKGAzytsQYOTo3oIM1Uk4F4f3Kr1nN+LkWg
X-ME-Proxy: <xmx:jW6xatcI0LjOWEIjhfp8fmuh96BaORHGvXI8Wc5-Eg2EWBV1sqK4DA>
    <xmx:jW6xagXiF0t6i3G8EuvZw6E2YLREG_uWGHHQBR9ga1InRcRd-m_vyQ>
    <xmx:jW6xapeRqZ0h8QHvoMkD1oiHR4o5chmvjIVMb8QeGjqPWJZOsTeH0A>
    <xmx:jW6xas_vgNbw6os0cF-Zr57_rrri3rPwYrJdhK5zS6NLyDNNd24ZHg>
    <xmx:jW6xasXurFJtZO6Z0VSvrEyJUREIkjk3o8i-fsxglvyjHIt7oO7h5tLR>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 13:51:08 -0400 (EDT)
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
Subject: [PATCH net-next v5 03/10] net: ethernet: ravb: Simplify gPTP start and stop
Date: Mon, 21 Sep 2026 19:50:30 +0200
Message-ID: <20260921175037.4084310-4-niklas.soderlund+renesas@ragnatech.se>
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
* Changes since v4
- Fix gPTP stop in error path of ravb_open(), thanks LLM a real issue!

* Changes since v1
- Improve spelling in commit message.
---
 drivers/net/ethernet/renesas/ravb_main.c | 36 +++++++++++-------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a89f6fe7866f..42d208e6b8ec 100644
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
@@ -1975,7 +1981,7 @@ static int ravb_open(struct net_device *ndev)
 
 out_ptp_stop:
 	/* Stop PTP Clock driver */
-	if (info->gptp || info->ccc_gac)
+	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
 	ravb_stop_dma(ndev);
 out_set_reset:
@@ -2020,10 +2026,6 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 
 	netif_tx_stop_all_queues(ndev);
 
-	/* Stop PTP Clock driver */
-	if (info->gptp)
-		ravb_ptp_stop(ndev);
-
 	/* Wait for DMA stopping */
 	if (ravb_stop_dma(ndev)) {
 		/* If ravb_stop_dma() fails, the hardware is still operating
@@ -2056,10 +2058,6 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	ravb_emac_init(ndev);
 
 out:
-	/* Initialise PTP Clock driver */
-	if (info->gptp)
-		ravb_ptp_init(ndev, priv->pdev);
-
 	netif_tx_start_all_queues(ndev);
 
 out_unlock:
@@ -2374,7 +2372,7 @@ static int ravb_close(struct net_device *ndev)
 	}
 
 	/* Stop PTP Clock driver */
-	if (info->gptp || info->ccc_gac)
+	if (info->ccc_gac)
 		ravb_ptp_stop(ndev);
 
 	/* Set the config mode to stop the AVB-DMAC's processes */
-- 
2.55.0

