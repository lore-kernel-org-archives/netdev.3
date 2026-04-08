Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE1A313520;
	Wed,  8 Apr 2026 13:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775655125; cv=none; b=nt5CEdyWMFAP7WRV4qpD6iNlTRFSR0HyvN27/lqILm3AOdfSNVvhvTerXzQ3PQozVn4PjQxS1vW4FOjlUqt4oDjW/X+jrUkqRse37yzNaY5Mh7gjeaoZGupIFUwURvTJC8tbED6e3MDyg/9vSBSSvUS38qDJbQKw0+uCPKbd8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775655125; c=relaxed/simple;
	bh=08JCyzj5Xrn7/aFHZXRR/0nwsBlACnLkG+LycSzml4s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uGenI4fCEt3CIkwy5BqukWGUqOpEM4npKhyZelToX4PxsGtmLWAiWaDDq8WVlvLtfhr/R3JcRhhM0lUcEWu9eRZ/Mf5ntecyYo2I+la2lNtpNp1+cqPLZul776Z573rftMYMHwdX+xo3XAJ95U5kcSkt4cgIJ0m999XssiuNniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=K/IHY/+k; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K/IHY/+k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775655124; x=1807191124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=08JCyzj5Xrn7/aFHZXRR/0nwsBlACnLkG+LycSzml4s=;
  b=K/IHY/+k18lcV0rTT+20Dxx3DtFLsCv0Q8w/TWuGz1Hm0BNrCb8Y9BAu
   FJyHDWJQ337PZKq0EibzW1ZRSP7IV0o10l9FfORqKdXMLOKksA/4ov9NE
   ucza28Gw9HbnDyzmlz/VSFrrSR4bhfK0HOwTyre64wZYpIyj3U4wNcyd0
   v0jLov0+lOrFLhILQ5z543U3pW0JM7rp4w3/NOOhhAU1ZBLfqSgene4sy
   Du8qGjNZJwqZAMDvEgL4G4J7Ck3ioa2W7QCCHGh8uOW6OlXqAoMNxorwv
   YUYmf3m5kGWJiRLCxUDe+haMNtgq/fhd5bOBq+BBofJ9D8jLpun7pPgvO
   g==;
X-CSE-ConnectionGUID: fPwiRt5YSsWuk0jJwaLkzQ==
X-CSE-MsgGUID: J92zM7G1QaeEpkDIyn8h+Q==
X-IronPort-AV: E=Sophos;i="6.23,167,1770620400"; 
   d="scan'208";a="56242933"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Apr 2026 06:32:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 8 Apr 2026 06:31:55 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 8 Apr 2026 06:31:54 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <netdev@vger.kernel.org>
CC: Charles Perry <charles.perry@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: phy: fix a return path in get_phy_c45_ids()
Date: Wed, 8 Apr 2026 06:31:44 -0700
Message-ID: <20260408133145.1177417-1-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The return value of phy_c45_probe_present() is store in "ret", not
"phy_reg", fix this. "phy_reg" always has a positive value if we reach
this return path (since it would have returned earlier otherwise), which
means that the original goal of the patch of not considering -ENODEV
fatal wasn't achieved.

Fixes: 17b447539408 ("net: phy: c45 scanning: Don't consider -ENODEV fatal")
Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 drivers/net/phy/phy_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 81984d4ebb7c..810327fa886a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -973,8 +973,8 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 				/* returning -ENODEV doesn't stop bus
 				 * scanning
 				 */
-				return (phy_reg == -EIO ||
-					phy_reg == -ENODEV) ? -ENODEV : -EIO;
+				return (ret == -EIO ||
+					ret == -ENODEV) ? -ENODEV : -EIO;
 
 			if (!ret)
 				continue;
-- 
2.47.3

