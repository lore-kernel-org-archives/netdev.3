Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D49361950;
	Mon,  7 Sep 2026 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758430; cv=none; b=kcE9dpMfub3N/ogmMNraLoO9VXbVo63FTN71r3zFsC4ia0+jNtWE8QqwSCMRkqvAGvoZsLP/TpeCVjEA7Ubape7QdE0yPf/IJ1Aa0vWEjo9lSx7GRVWeEa52SBH3JHFuXBaT9ODwePXpstYS3swleVtg5xY+f4nv/HLzdjdOrvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758430; c=relaxed/simple;
	bh=hx2giW2ozMSO4t46wLo2FL3naZNSI/4x1TP/Kdru33A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6HjRjhmwGhDD5fEvGYjX/fbWwzeSVl7nSzmV1r9L6WOLgbNfiLP0URU4bL42XX/AXF0IfsGqzgBOPJzrCRbcj62MEkl+Q36RhpxOABu0R0tNqtZUFe+Hh1Symxki0vM6Keo6GR1+ZeTpyIdQLaZjnPDyO9W52Wzxd94Yp7wzwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NGwkg87U; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NGwkg87U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788758429; x=1820294429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hx2giW2ozMSO4t46wLo2FL3naZNSI/4x1TP/Kdru33A=;
  b=NGwkg87UYAgBJ5Zl2KlExr6tMCwWX4gVhtfroljxJq10VkciZCbYEGnP
   LpNS6NEo1YyvA+HpAcEuA3kjVX6bo2Nk44vO9ZQQmatrYpGuAojzENAEl
   SQOelq/ZBTcC+4vn8H2V+GyLK+u2UqjUvw+995t2zvA9GHagibkCPqoFQ
   YzkW0GoYZgOBROzxJXaM5m69YDVQjnMMaAapqrnkZkwpDMV/ZEXYg/sb1
   Q+qBUTeAQa5oUerVyt6mFNXiJLpadJhBmhE/jAjdDmH619g1TUINZkiO3
   YeH820fDr4+Lk4WzJ4TmI2rgrmYfoxYrqI8u2udgV3KdNvdChEaXstOG2
   A==;
X-CSE-ConnectionGUID: CiEaxq9VSUmt0Q+af6kiwQ==
X-CSE-MsgGUID: VhUlQuJHSHm5mlj1RztPCA==
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="73159401"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 22:20:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Sun, 6 Sep 2026 22:20:27 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 6 Sep 2026 22:20:24 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v2 3/4] microchip: lan865x: enable PHY interrupt via virtual IRQ
Date: Mon, 7 Sep 2026 10:50:05 +0530
Message-ID: <20260907052007.391972-4-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907052007.391972-1-parthiban.veerasooran@microchip.com>
References: <20260907052007.391972-1-parthiban.veerasooran@microchip.com>
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
virtual IRQ infrastructure in the OA TC6 framework. This allows
phylib to operate in interrupt mode and drives the PHY driver's
config_intr/handle_interrupt callbacks for LAN865X internal PHY.

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

