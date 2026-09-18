Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FF93BF67A;
	Fri, 18 Sep 2026 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742007; cv=none; b=Ekgn+hVm/AC0QgOEQm5u7o44c1reUDnKrl1G2lDI+3FxETJ1rEhOEDnb6Z23Yt05YlQFxoqWu8qF2DFnNcHEsLlGjC35NI1mNuMVYc1E/aqAZ4YRzvT1fV5mz15B8OKIAM4ahIZuqa4c+kS/A5Y6ApvvTclTYH7uKafyvcF6IKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742007; c=relaxed/simple;
	bh=NCowSd3P7qx8s6nC/FhxgE0HdwSDbaiO8q8/eY2PSjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTSVxa/FHKThM66Ie2D1SpjVzposJB32PcmRheSu+VChDQNDFchFu4vgjcL3rle/if0659VdWp3s3FgiRzwJ6luNq++x5GzIbAWkh8n0YCokJhMriZj83hGHS9Jyv4YKCYsO2SI1p9gpf4o41v8BimAwClrVffR+teITJ46WYjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VtnZUJPO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VtnZUJPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789742005; x=1821278005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NCowSd3P7qx8s6nC/FhxgE0HdwSDbaiO8q8/eY2PSjg=;
  b=VtnZUJPOdUJfXzv6f3yylC5N12skCM/tO+lluqCsv16oBznTSunAVUpK
   TYwjJw+B++vZ0HCrACO1hLeV8TuvnAiAq9mHFkKv1g5p7QYOLEiIQi2p6
   mBkHD+uDkgIxAKRMB7ujA8Qq6LcFqujXg0Wz5cUaLy/HxJYB0/wBZBfQ8
   zjRxnmp5luLDUJbfXvZywRgvwTjk+6OZxvQ9yvfBQfZyBMHxsT/K5svoX
   ib+rOpNeFjsxFBc1IrZ36B+Kc7198IViZkFdL7SLFu5fDB/iLuFvGSbrm
   GxD04J65rjeMJxfoko5npcBcV38Ek3oC6LkU2TaMs4dfyLkeWlAnONKYI
   g==;
X-CSE-ConnectionGUID: xUPNpqYGQCePtL1y3X+2eA==
X-CSE-MsgGUID: AmliRLZhQAa/UoRfTz2lEA==
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="64127951"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 07:33:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 07:33:24 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 18 Sep 2026 07:33:20 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v3 3/4] microchip: lan865x: enable PHY interrupt via virtual IRQ
Date: Fri, 18 Sep 2026 20:03:01 +0530
Message-ID: <20260918143302.76909-4-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918143302.76909-1-parthiban.veerasooran@microchip.com>
References: <20260918143302.76909-1-parthiban.veerasooran@microchip.com>
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
PHY interrupt to phylib"), LAN865X stays on that commit's static CDEN
fallback instead of tracking PLCA transitions dynamically.

lan865x_revb_fixup_registers[] does not program COL_DET_CTRL0
(0x0087), so CDEN correctness relies on that bit's hardware reset
default together with lan86xx_handle_interrupt() tracking every
subsequent PLCA transition via the PSTC interrupt this patch enables.

Fixes: 78341049fbcd ("net: phy: microchip_t1s: configure collision detection based on PLCA mode")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index 26a2761332a5..043a3dc3f965 100644
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
 	if (!priv->tc6) {
 		ret = -ENODEV;
 		goto free_netdev;
-- 
2.43.0

