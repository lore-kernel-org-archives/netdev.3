Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479851AFD1;
	Tue, 29 Sep 2026 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686795; cv=none; b=jRX1991OF0dbMWxSEibXSenjqCj0Cl0XoY7Cwh3sLYPoBspvGmEwu6gelt3Ay4GzRQ5fm/DLl4rXTI/A113QGl5929GLX6yR7/C/Ms8bLBysSprLaWu6fNTYCR0pvp4hkWS/UoWFLH3mYpgCBhPVrZCL/o216IqzGM6PEROcIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686795; c=relaxed/simple;
	bh=1h1l6EVcSaxGKi3qT/aLpcNXfq2uaMZqt7OPMn46yEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h66AX0K9FMlP26E2YJURCWfSY/0rmiRYshvFzSFYryUohMLoL0Xca9Xfmi8vYPeMTT4Ac3izuvFTCnEyRiiUbP3An81PHuC8UOyrRR5VV7DWW5KmNSckH9RGyQ9Y9DFSDmk0VCwHNR8daAKChwOQpO+iZ6LCaZlcorbdQSJTtnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gUmca33V; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gUmca33V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790686793; x=1822222793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1h1l6EVcSaxGKi3qT/aLpcNXfq2uaMZqt7OPMn46yEU=;
  b=gUmca33VnAOTlapuwfhwsXVwjZgS90iinKi/Ti6QjGRWHe9g+aoiYOyi
   2qISXVWMQTySJZbJFWxJlM/Z2FXMgYZYRTG+PDCBpXowvz0auPioKWPiv
   GhAGse1Iek58c1aCeHeBr7BbhCQS+k+l0L8J/Wvn5bi4W//zU45JjvPWY
   w28qzENeNeeujflv9VyS+szZNqxlcQdfCQwrimoSnWKT+FhykMMdv6CRC
   1uMc/2iXc1yXnE0fLXWfH/jGDeum5NVW9gN82izRQzU0mclg+/V1BAUKr
   KvfQgcixRXGdCNlS7vf7t7ulcMF5M1cxq3chSa15FNracLeDhMTTA+n4E
   g==;
X-CSE-ConnectionGUID: N1ZeMET7RVKq2vb0+vHNZg==
X-CSE-MsgGUID: dPIi7TuGRnaRKDEONb0k9A==
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="74502203"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2026 05:59:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 29 Sep 2026 05:59:52 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 29 Sep 2026 05:59:48 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v4 3/4] microchip: lan865x: enable PHY interrupt via virtual IRQ
Date: Tue, 29 Sep 2026 18:29:27 +0530
Message-ID: <20260929125928.611784-4-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929125928.611784-1-parthiban.veerasooran@microchip.com>
References: <20260929125928.611784-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The LAN865X integrates the PHY directly into the MAC-PHY SPI device.
The PHY has no dedicated interrupt line; its interrupt is always
delivered as the PHYINT bit in STATUS0.

Pass the OA_TC6_PHY_INT quirk flag to oa_tc6_init() to enable the
virtual IRQ infrastructure. This lets phylib operate in interrupt mode
and drives the PHY driver's config_intr/handle_interrupt callbacks for
the LAN865X internal PHY.

This completes the collision-detection fix started in "net: phy:
microchip_t1s: fix collision detection on PLCA status change"; without
this patch (and its prerequisite, "net: ethernet: oa_tc6: deliver the
PHY interrupt to phylib"), LAN865X stays on that commit's polling-based
CDEN synchronization/fallback instead of tracking PLCA transitions
dynamically.

CDEN is synchronized to the live PLCA status when lan86xx_config_intr()
runs during phy_enable_interrupts(), then tracked on each subsequent
PLCA transition via lan86xx_handle_interrupt(). This PHY interrupt path
is critical for keeping CDEN correct across PLCA transitions.

Fixes: 78341049fbcd ("net: phy: microchip_t1s: configure collision detection based on PLCA mode")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 127afb9e9f14..d47560f9847d 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -332,6 +332,7 @@ static const struct net_device_ops lan865x_netdev_ops = {
 
 static int lan865x_probe(struct spi_device *spi)
 {
+	struct oa_tc6_quirks tc6_quirks = {};
 	struct net_device *netdev;
 	struct lan865x_priv *priv;
 	int ret;
@@ -346,7 +347,8 @@ static int lan865x_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, priv);
 	INIT_WORK(&priv->multicast_work, lan865x_multicast_work_handler);
 
-	priv->tc6 = oa_tc6_init(spi, netdev, NULL);
+	tc6_quirks.quirk_flags = OA_TC6_PHY_INT;
+	priv->tc6 = oa_tc6_init(spi, netdev, &tc6_quirks);
 	if (IS_ERR(priv->tc6)) {
 		ret = PTR_ERR(priv->tc6);
 		goto free_netdev;
-- 
2.43.0

