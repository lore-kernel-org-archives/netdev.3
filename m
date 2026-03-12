Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DE230B51D;
	Thu, 12 Mar 2026 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322906; cv=none; b=VJTSsjFLyQTdtcsCch+JfWf/4NuIQSmU8nhJWcnhQoaq+wR/m/D0/CIrxBDudBMsV6TrUjhYIqSqyS5Zc6Z/XDoP05xxd2QCZxZssVhrYyHfeFWtTD9cC/4lQUG5ciVdqBnSHlm0g7kLQsbZn7NGcZQGbk4n4uJ8G/CAjZ9Ykl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322906; c=relaxed/simple;
	bh=OIYxdZHWNquGPThxduQFNcu1VDsZM+QBbR+zNqLLiPg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vvd1r22vT5Lkd/TWXvQLY+B88OPNVmxiP70yfgN7BqooOM+K0y+XXR90p+8QYpFMbYpAob/3RUQmlOeW2+LVPjRVXy1VXOtpsjq3jqeC5WxMjpbT3TLI2p8tDQGNcwQGYrMyoa9IFDxC3YYyiB4Xy1qSTWMzd3jNaSn3/A+z+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UwYZJNzx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UwYZJNzx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773322905; x=1804858905;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OIYxdZHWNquGPThxduQFNcu1VDsZM+QBbR+zNqLLiPg=;
  b=UwYZJNzxqN7hjBnJoTi9C123BAKJQZf4s9YxJNdzDPCyi402XZxafeye
   GTavtchqCQOU3/XFpeATa6uXgzexFB/PaYm/F/IC7++rToSFBw1ScAFXf
   4LCx9S0kZwlF9nihck1RiJIk5gJxUERdngDurK6cpYdYTKFBSAfOcLDGH
   n+0SOPugSoxFIkaznZA1KsOOh83QlHqOtQ9x4B44pK3XlVWRwpOvE6jO1
   5WJkHKCnXUPWDF+VGH/bDmuXXIKDCfTlzwjwrTVjrSQlxeBolhccQ9npi
   bKqyD2tjM+UA2H1atOSl21ZIpGmgxbr+w1Wp3nBaCK2brIigJWsT479Qu
   A==;
X-CSE-ConnectionGUID: RjybdDEQReW8VnevA8aLZA==
X-CSE-MsgGUID: KwjeFn75QlephaHJsrijKg==
X-IronPort-AV: E=Sophos;i="6.23,116,1770620400"; 
   d="scan'208";a="54995152"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 06:41:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Mar 2026 06:41:13 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 12 Mar 2026 06:41:12 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Conor Dooley <conor@kernel.org>, Charles Perry
	<charles.perry@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: macb: set default_an_inband to true for SGMII
Date: Thu, 12 Mar 2026 06:38:55 -0700
Message-ID: <20260312133856.2911581-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Most platforms using GEM in SGMII mode use in-band autonegotiation
because it is on by default in GEM's 1G PCS and is always on since
commit e276e5e40e92 ("net: macb: Disable PCS auto-negotiation for SGMII
fixed-link mode"). Leave it on if possible using the "default_an_inband"
flag of "struct phylink_config" so that platforms that lack in-band
autonegotiation configurability at the PHY do not break with commit
1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled") which
will turn off in-band autoneg for non hot pluggable PHYs.

Once the majority of the PHY drivers that support SGMII have the
->config_inband() callback, this commit could be reverted so that non
hot pluggable PHY use outband negotiation with macb, like its the case
for other MACs.

Fixes: 1338cfef1ff1 ("net: macb: fix SGMII with inband aneg disabled")
Closes: https://lore.kernel.org/r/20260304-nebulizer-rounding-40fbc81a2ba1@spud
Tested-by: Conor Dooley <conor@kernel.org>
Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 963a5d4e1a88..d1fc6a9b9fe5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -838,6 +838,12 @@ static int macb_mii_probe(struct net_device *dev)
 	if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
 		bp->phylink_config.poll_fixed_state = true;
 		bp->phylink_config.get_fixed_state = macb_get_pcs_fixed_state;
+		/* The PCSAUTONEG bit in PCSCNTRL is on out of reset. Setting
+		 * default_an_inband to true tells phylink to turn it off only
+		 * if necessary (e.g. a fixed link or a PHY that doesn't support
+		 * inband).
+		 */
+		bp->phylink_config.default_an_inband = true;
 	}
 
 	bp->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
-- 
2.47.3

